import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../providers/login_provider.dart';

class FormEmailPassword extends StatefulWidget {
  final String mode;
  const FormEmailPassword({super.key, required this.mode});

  @override
  State<FormEmailPassword> createState() => _FormEmailPasswordState();
}

class _FormEmailPasswordState extends State<FormEmailPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  double deviceHeight = 0;
  double deviceWidth = 0;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: double.infinity,
      height: deviceHeight * 0.4,
      child: Form(
        key: _formKey,
        onChanged: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: deviceHeight * 0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  emailTextField(),
                  passwordTextField(),
                ],
              ),
            ),
            loginButtom(context),
          ],
        ),
      ),
    );
  }

  Widget emailTextField() {
    return Center(
      child: SizedBox(
        width: deviceWidth * 0.7,
        child: TextFormField(
          autocorrect: false,
          style: const TextStyle(color: Colors.white),
          controller: _emailController,

          validator: (input) {
            if (input!.isEmpty) {
              return 'Ingrese su correo electrónico';
            }
            return null;
          },

          onSaved: (input) {
            setState(() {});
          }, //Función que se ejecutará luego de que el usuario haya enviado el form.

          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(50),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(50),
            ),
            prefixIcon: const Icon(Icons.email),
            contentPadding: const EdgeInsets.all(1),
            hintText: "Correo electrónico",
            hintStyle: const TextStyle(color: Color(0xFF999999)),
            filled: true,
            fillColor: Colors.black,
            prefixIconColor: Colors.white,
            errorBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xFFED2B2A), width: 2.5),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      ),
    );
  }

  Widget passwordTextField() {
    return Center(
      child: SizedBox(
        width: deviceWidth * 0.7,
        child: TextFormField(
          obscureText: true,
          autocorrect: false,
          controller: _passwordController,
          style: const TextStyle(color: Colors.white),
          validator: (input) {
            if (input!.isEmpty) {
              return 'Ingrese su contraseña';
            }
            return null;
          },

          onSaved: (input) {
            setState(() {});
          }, //Función que se ejecutará luego de que el usuario haya enviado el form.

          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(50),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(50),
            ),
            prefixIcon: const Icon(Icons.lock),
            contentPadding: const EdgeInsets.all(1),
            hintText: "Contraseña",
            hintStyle: const TextStyle(color: Color(0xFF999999)),
            filled: true,
            fillColor: Colors.black,
            prefixIconColor: Colors.white,
            errorBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xFFED2B2A), width: 2.5),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButtom(BuildContext context) {
    LoginProvider? auth;
    auth = Provider.of<LoginProvider>(context);

    return SizedBox(
      width: deviceWidth * 0.9,
      height: deviceHeight * 0.055,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  const MaterialStatePropertyAll(Color(0xFFED2B2A)),
              shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)))),
          onPressed: widget.mode == "login"
              ? auth.status == AuthStatus.authenticating
                  ? null
                  : () async {
                      if (_formKey.currentState!.validate()) {
                        await Provider.of<LoginProvider>(context, listen: false)
                            .loginWithEmailAndPassword(
                                context,
                                _emailController.text,
                                _passwordController.text);
                      }
                    }
              : () async {
                  if (_formKey.currentState!.validate()) {
                    await Provider.of<LoginProvider>(context, listen: false)
                        .registerWithEmailAndPassword(context,
                            _emailController.text, _passwordController.text);
                  }
                },
          child: auth.status == AuthStatus.authenticating
              ? LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.white, size: 30)
              : widget.mode == "login"
                  ? const Text(
                      'Ingresar',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  : const Text(
                      'Registrarse',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
    );
  }
}
