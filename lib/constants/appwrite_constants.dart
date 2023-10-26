class AppwriteConstants {
  static const String databaseId = '6539fcc228bf0a2acd0f';
  static const String projectId = '6539fa008b3c6446dccd';
  static const String endPoint = 'https://cloud.appwrite.io/v1';

  static const String usersCollection = '63cb8ae73960973b0635';
  static const String tweetsCollection = '63cbd6781a8ce89dcb95';
  static const String notificationsCollection = '63cd5ff88b08e40a11bc';

  static const String imagesBucket = '63cbdab48cdbccb6b34e';

  static String imageUrl(String imageId) =>
      '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}
