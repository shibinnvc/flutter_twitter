import 'package:appwrite/appwrite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_twitter/core/core.dart';

final authAPIProvider = Provider((ref) {
  return AuthAPI();
});

abstract class IAuthAPI {
  FutureEither<UserCredential> signUp({
    required String email,
    required String password,
  });
  FutureEither<UserCredential> login({
    required String email,
    required String password,
  });
  User? currentUserAccount();
  FutureEitherVoid logout();
}

class AuthAPI implements IAuthAPI {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  User? currentUserAccount() {
    return _auth.currentUser;
  }

  @override
  FutureEither<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final account = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(e.message ?? 'Some unexpected error occurred', stackTrace),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
      );
    }
  }

  @override
  FutureEither<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      final session = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(session);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(e.message ?? 'Some unexpected error occurred', stackTrace),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
      );
    }
  }

  @override
  FutureEitherVoid logout() async {
    try {
      await _auth.signOut();
      return right(null);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(e.message ?? 'Some unexpected error occurred', stackTrace),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
      );
    }
  }
}
