import 'dart:io';
import 'package:appwrite/appwrite.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitter/constants/constants.dart';
import 'package:flutter_twitter/core/providers.dart';

final storageAPIProvider = Provider((ref) {
  return StorageAPI(
    storage: ref.watch(appwriteStorageProvider),
  );
});

class StorageAPI {
  final Storage storage;
  StorageAPI({required Storage storage}) : storage = storage;

  final _storage = FirebaseStorage.instance.ref();

  Future<List<String>> uploadImage(List<File> files) async {
    List<String> imageLinks = [];
    for (final file in files) {
      // final uploadedImage = await _storage.createFile(
      //   bucketId: AppwriteConstants.imagesBucket,
      //   fileId: ID.unique(),
      //   file: InputFile(path: file.path),
      // );
      final ref = _storage.child("images");
      final uploadedImage = await ref.putFile(file);
      String imageUrl = await ref.getDownloadURL();
      imageLinks.add(imageUrl
          // AppwriteConstants.imageUrl(uploadedImage.$id),
          );
    }
    return imageLinks;
  }
}
