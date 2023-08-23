import 'package:flutter/material.dart';
import 'package:pokedex_mobile/screens/register_screen.dart';
import 'package:pokedex_mobile/services/snackbar_service.dart';
import 'package:pokedex_mobile/widgets/form_login_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                const FormEmailPassword(mode: "login"),
                registerButtom(context),
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
        )
      ],
    );
  }

  Widget registerButtom(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('No estás registrado?',
            style: TextStyle(color: Colors.white, fontSize: 14)),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, RegisterScreen.routeName);
          },
          child: const Text(
            'Crear Cuenta',
            style: TextStyle(
                color: Color(0xFFED2B2A),
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
