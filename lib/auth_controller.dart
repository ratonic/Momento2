import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';

import 'package:application_medicines/appwrite_config.dart';
import 'package:appwrite/models.dart';

class AuthController extends GetxController {
  final Account account = Account(AppwriteConfig.getClient());
  final Rx<User?> user = Rx<User?>(null);

  Future<bool> checkAuth() async {
    try {
      await account.get();
      return true;
    } catch (e) {
      // Removemos el Snackbar ya que no es un error real
      return false;
    }
  }

  Future<void> createAccount(String email, String password) async {
    try {
      await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      await login(email, password);
    } catch (e) {
      Get.snackbar('Error', 'Error al crear la cuenta: ${e.toString()}');
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      final userData = await account.get();
      user.value = userData;
      Get.offAllNamed('/medications'); // Cambiado de toNamed a offAllNamed
    } catch (e) {
      Get.snackbar('Error', 'Error al iniciar sesión: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    try {
      await account.deleteSession(sessionId: 'current');
      user.value = null;
      Get.offAllNamed('/login'); // Agregamos esta línea para redirigir al login
    } catch (e) {
      Get.snackbar('Error', 'Error al cerrar sesión: ${e.toString()}');
    }
  }
}
