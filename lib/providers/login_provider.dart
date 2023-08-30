import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedex_mobile/main.dart';
import 'package:pokedex_mobile/screens/login_screen.dart';
import 'package:pokedex_mobile/services/navigation_service.dart';
import 'package:pokedex_mobile/services/snackbar_service.dart';

enum AuthStatus {
  notAuthenticated,
  authenticating,
  authenticated,
  userNotFound,
  error,
}

class LoginProvider extends ChangeNotifier {
  User? user;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthStatus? status;

  LoginProvider() {
    checkCurrentUserIsAuthenticated();
  }

  Future<void> authLogin() async {
    if (user != null) {
      //Navigator.pushReplacementNamed(context, MainWidget.routeName);
      NavigationService.instance
          .navigateToReplacementName(MainWidget.routeName);
    }
  }

  void checkCurrentUserIsAuthenticated() async {
    // ignore: await_only_futures
    user = await _auth.currentUser;
    if (user != null) {
      status = AuthStatus.authenticated;
      notifyListeners();
      await authLogin();
    }
  }

  Future<void> loginWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    status = AuthStatus.authenticating;
    notifyListeners();
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((result) {
        user = result.user;
        status = AuthStatus.authenticated;
        notifyListeners();
        SnackBarService.instance
            .showSnackBar("welcome ${result.user!.email}", true);
        Navigator.pushReplacementNamed(context, MainWidget.routeName);
      });
    } catch (e) {
      status = AuthStatus.error;
      notifyListeners();
      user = null;
      SnackBarService.instance.showSnackBar("Error al autenticar", false);
    }
  }

  Future<void> registerWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    status = AuthStatus.authenticating;
    notifyListeners();
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((result) {
        user = result.user;
        status = AuthStatus.authenticated;
        notifyListeners();
        SnackBarService.instance.showSnackBar(
            "Usuario ${result.user!.email} registrado con exito, Inicia seción",
            true);
        Navigator.pop(context);
      });
    } catch (e) {
      status = AuthStatus.error;
      notifyListeners();
      user = null;
      SnackBarService.instance.showSnackBar("Error al registrarse", false);
    }
  }

  Future<void> logoutUser() async {
    try {
      /*
      await _auth.signOut().then((_) {
        status = AuthStatus.notAuthenticated;
        NavigationService.instance
            .navigateToReplacementName(LoginScreen.routeName);
        user = null;
      }); */

      await _auth.signOut();
      user = null;
      status = AuthStatus.notAuthenticated;
      await NavigationService.instance
          .navigateToReplacementName(LoginScreen.routeName);
      //SnackBarService.instance.showSnackBar("Sesión cerrada con éxito", true);
    } catch (e) {
      SnackBarService.instance.showSnackBar("Error al cerrar sesión", false);
    }
    notifyListeners();
  }
}
