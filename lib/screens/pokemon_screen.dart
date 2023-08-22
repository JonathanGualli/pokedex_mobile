import 'package:flutter/material.dart';
import 'package:pokedex_mobile/providers/pokemon_provider.dart';
import 'package:pokedex_mobile/widgets/pokemon_list.dart';
import 'package:provider/provider.dart';

class PokemonScreenWidget extends StatefulWidget {
  const PokemonScreenWidget({super.key});

  @override
  State<PokemonScreenWidget> createState() => _PokemonScreenWidgetState();
}

class _PokemonScreenWidgetState extends State<PokemonScreenWidget> {
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    //FutureBuilder nos permite hacer llamadas a metodos que son asincronicos pero permite obtener
    //una logica de su estado.

    //el parametro future espera al metodo asincorino al cual se va a llamar.
    // el snapshot me indica el estado del objeto.

    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isSearch = !isSearch;
              print(isSearch);
            });
          },
          icon: const Icon(Icons.search),
        ),
      ], title: !isSearch ? const Text("Pokemons") : const Text("Search ...")),
      body: FutureBuilder(
          future: Provider.of<PokemonProvier>(context, listen: false)
              .checkPokemons(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // cuando la llamada al metodo async se ejecuta;
              return const PokemonList();
            } else {
              //cuando la llamada al metodo async se inicia (en proceso);
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
