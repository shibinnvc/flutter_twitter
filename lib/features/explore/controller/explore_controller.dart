import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitter/apis/user_api.dart';
import 'package:flutter_twitter/models/user_model.dart';
import 'package:fpdart/fpdart.dart';

final exploreControllerProvider = StateNotifierProvider((ref) {
  return ExploreController(
    userAPI: ref.watch(userAPIProvider),
  );
});

final searchUserProvider = FutureProvider.family((ref, String name) async {
  final exploreController = ref.watch(exploreControllerProvider.notifier);
  return exploreController.searchUser(name);
});

class ExploreController extends StateNotifier<bool> {
  final UserAPI _userAPI;
  ExploreController({
    required UserAPI userAPI,
  })  : _userAPI = userAPI,
        super(false);

  Future<List<UserModel>> searchUser(String name) async {
    List<UserModel> userList = [];
    final users = await _userAPI.searchUserByName(name);
    users.docs.forEach((document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      userList.add(UserModel.fromMap(data));
    });
    return userList;
    //return users.map((e) => UserModel.fromMap(e.data)).toList();
  }
}
