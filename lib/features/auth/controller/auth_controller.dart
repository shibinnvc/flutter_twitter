import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitter/apis/auth_api.dart';
import 'package:flutter_twitter/apis/user_api.dart';
import 'package:flutter_twitter/core/utils.dart';
import 'package:flutter_twitter/features/auth/view/login_view.dart';
import 'package:flutter_twitter/features/auth/view/signup_view.dart';
import 'package:flutter_twitter/features/home/view/home_view.dart';
import 'package:flutter_twitter/models/user_model.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authAPI: ref.watch(authAPIProvider),
    userAPI: ref.watch(userAPIProvider),
  );
});

final currentUserDetailsProvider = FutureProvider((ref) {
  final currentUserId = ref.watch(currentUserAccountProvider).value!.uid;
  // print('user id $currentUserId');
  final userDetails = ref.watch(userDetailsProvider(currentUserId));
  return userDetails.value;
});

final userDetailsProvider = FutureProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;
  AuthController({
    required AuthAPI authAPI,
    required UserAPI userAPI,
  })  : _authAPI = authAPI,
        _userAPI = userAPI,
        super(false);
  // state = isLoading

  User? currentUser() => _authAPI.currentUserAccount();

  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.signUp(
      email: email,
      password: password,
    );
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) async {
        UserModel userModel = UserModel(
          email: email,
          name: getNameFromEmail(email),
          nameArray: getNameArray(getNameFromEmail(email)),
          followers: const [],
          following: const [],
          profilePic: '',
          bannerPic: '',
          uid: r.user?.uid ?? '',
          bio: '',
          isTwitterBlue: false,
        );
        final res2 = await _userAPI.saveUserData(userModel);
        res2.fold((l) => showSnackBar(context, l.message), (r) {
          showSnackBar(context, 'Accounted created! Please login.');
          Navigator.push(context, LoginView.route());
        });
      },
    );
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.login(
      email: email,
      password: password,
    );
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        Navigator.push(context, HomeView.route());
      },
    );
  }

  Future<UserModel> getUserData(String uid) async {
    //here we want to change later
    final document = await _userAPI.getUserData(uid);
    // print('here is the data ${document.data()}');
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    final updatedUser = UserModel.fromMap(data);
    // print('data is here $updatedUser');
    // // final updatedUser = UserModel(
    // //     email: 'shibin@gmailaaa.com',
    // //     name: 'Shibin',
    // //     nameArray: [],
    // //     followers: ['ejas', 'javi'],
    // //     following: ['rashi'],
    // //     profilePic: '',
    // //     bannerPic: '',
    // //     uid: uid,
    // //     bio: '',
    // //     isTwitterBlue: true);
    return updatedUser;
  }

  void logout(BuildContext context) async {
    final res = await _authAPI.logout();
    res.fold((l) => null, (r) {
      Navigator.pushAndRemoveUntil(
        context,
        SignUpView.route(),
        (route) => false,
      );
    });
  }
}
