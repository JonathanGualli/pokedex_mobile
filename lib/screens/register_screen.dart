import 'package:flutter/material.dart';
import 'package:pokedex_mobile/services/snackbar_service.dart';
import 'package:pokedex_mobile/widgets/form_login_password.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const routeName = "/register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  double deviceHeight = 0;
  double deviceWidth = 0;

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF393E46),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            height: deviceHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                header(),
                const FormEmailPassword(mode: "register"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Column(
      children: [
        Center(
          child: Image.asset(
            "assets/pokebola.png",
            height: deviceWidth * 0.52,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          "POKEDEX",
          style: TextStyle(
              color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 80,
        ),
        const Text(
          "REGISTRARSE",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
