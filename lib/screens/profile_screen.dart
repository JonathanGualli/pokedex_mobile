import 'package:flutter/material.dart';
import 'package:pokedex_mobile/providers/login_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var email = Provider.of<LoginProvider>(context).user!.email;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil de usuario"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            email!,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.cyan),
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
              onPressed: () async {
                await Provider.of<LoginProvider>(context, listen: false)
                    .logoutUser();
              },
              child: const Text("Cerrar sesión")),
        ],
      )),
    );
  }
}
