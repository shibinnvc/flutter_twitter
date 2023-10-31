import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitter/constants/appwrite_constants.dart';
import 'package:flutter_twitter/core/failure.dart';
import 'package:flutter_twitter/core/providers.dart';
import 'package:flutter_twitter/core/type_defs.dart';
import 'package:flutter_twitter/models/user_model.dart';
import 'package:fpdart/fpdart.dart';

final userAPIProvider = Provider((ref) {
  return UserAPI(
      // db: ref.watch(appwriteDatabaseProvider),
      // realtime: ref.watch(appwriteRealtimeProvider),
      );
});

abstract class IUserAPI {
  FutureEitherVoid saveUserData(UserModel userModel);
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uid);
  Future<QuerySnapshot<Map<String, dynamic>>> searchUserByName(String name);
  // FutureEitherVoid updateUserData(UserModel userModel);
  // Stream<RealtimeMessage> getLatestUserProfileData();
  // FutureEitherVoid followUser(UserModel user);
  // FutureEitherVoid addToFollowing(UserModel user);
}

class UserAPI implements IUserAPI {
  // final Databases _db;
  // final Realtime _realtime;
  // UserAPI({
  //   required Databases db,
  //   required Realtime realtime,
  // })  : _realtime = realtime,
  //       _db = db;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _db.collection('users').doc(userModel.uid).set(userModel.toMap());
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(
          e.message ?? 'Some unexpected error occurred',
          st,
        ),
      );
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uid) {
    return _db.collection('users').doc(uid).get();
    //doc(uid).get();
    // _db.getDocument(
    //   databaseId: AppwriteConstants.databaseId,
    //   collectionId: AppwriteConstants.usersCollection,
    //   documentId: uid,
    // );
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> searchUserByName(
      String name) async {
    final documents = await _db
        .collection('users')
        .where('nameArray', arrayContains: name)
        .get();
    return documents;
  }

  // @override
  // FutureEitherVoid updateUserData(UserModel userModel) async {
  //   try {
  //     await _db.updateDocument(
  //       databaseId: AppwriteConstants.databaseId,
  //       collectionId: AppwriteConstants.usersCollection,
  //       documentId: userModel.uid,
  //       data: userModel.toMap(),
  //     );
  //     return right(null);
  //   } on AppwriteException catch (e, st) {
  //     return left(
  //       Failure(
  //         e.message ?? 'Some unexpected error occurred',
  //         st,
  //       ),
  //     );
  //   } catch (e, st) {
  //     return left(Failure(e.toString(), st));
  //   }
  // }

  // @override
  // Stream<RealtimeMessage> getLatestUserProfileData() {
  //   return _realtime.subscribe([
  //     'databases.${AppwriteConstants.databaseId}.collections.${AppwriteConstants.usersCollection}.documents'
  //   ]).stream;
  // }

  // @override
  // FutureEitherVoid followUser(UserModel user) async {
  //   try {
  //     await _db.updateDocument(
  //       databaseId: AppwriteConstants.databaseId,
  //       collectionId: AppwriteConstants.usersCollection,
  //       documentId: user.uid,
  //       data: {
  //         'followers': user.followers,
  //       },
  //     );
  //     return right(null);
  //   } on AppwriteException catch (e, st) {
  //     return left(
  //       Failure(
  //         e.message ?? 'Some unexpected error occurred',
  //         st,
  //       ),
  //     );
  //   } catch (e, st) {
  //     return left(Failure(e.toString(), st));
  //   }
  // }

  // @override
  // FutureEitherVoid addToFollowing(UserModel user) async {
  //   try {
  //     await _db.updateDocument(
  //       databaseId: AppwriteConstants.databaseId,
  //       collectionId: AppwriteConstants.usersCollection,
  //       documentId: user.uid,
  //       data: {
  //         'following': user.following,
  //       },
  //     );
  //     return right(null);
  //   } on AppwriteException catch (e, st) {
  //     return left(
  //       Failure(
  //         e.message ?? 'Some unexpected error occurred',
  //         st,
  //       ),
  //     );
  //   } catch (e, st) {
  //     return left(Failure(e.toString(), st));
  //   }
  // }
}
