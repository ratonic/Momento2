import 'package:appwrite/appwrite.dart';

class AppwriteConfig {
  static String get endpoint => const String.fromEnvironment('APPWRITE_ENDPOINT', 
      defaultValue: 'https://fra.cloud.appwrite.io/v1');
  static String get projectId => const String.fromEnvironment('APPWRITE_PROJECT_ID', 
      defaultValue: '67e47f4a003d75e7cc47');
  static String get databaseId => const String.fromEnvironment('APPWRITE_DATABASE_ID', 
      defaultValue: '67e47ff2000a76f52a7f');
  static String get collectionId => const String.fromEnvironment('APPWRITE_COLLECTION_ID', 
      defaultValue: '6825191e0002a69deddb');

  static Client getClient() {
    Client client = Client();
    client
        .setEndpoint(endpoint)
        .setProject(projectId)
        .setSelfSigned(status: true);
    return client;
  }
}
