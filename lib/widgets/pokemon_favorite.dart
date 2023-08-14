import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_mobile/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

class PokemonFavorite extends StatefulWidget {
  final int id;

  const PokemonFavorite({super.key, required this.id});

  @override
  State<PokemonFavorite> createState() => _PokemonFavoriteState();
}

class _PokemonFavoriteState extends State<PokemonFavorite> {
  late Stream<DocumentSnapshot> _documentStream;

  void initState() {
    var db = FirebaseFirestore.instance;
    _documentStream =
        db.collection('pokemons').doc(widget.id.toString()).snapshots();
    super.initState();
  }

  _markFavofiteStatus(int id, bool value) {
    Provider.of<PokemonProvier>(context, listen: false)
        .updatePokemonFavoriteStatus(id, value);
  }

  Widget renderFavoriteIcon(bool state) {
    if (state) {
      return IconButton(
        onPressed: () => _markFavofiteStatus(widget.id, false),
        icon: const Icon(Icons.favorite),
      );
    } else {
      return IconButton(
        onPressed: () => _markFavofiteStatus(widget.id, true),
        icon: const Icon(Icons.favorite_border),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _documentStream,
        //cada vez que se actualize se ejecutara este builder
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          var data =
              snapshot.data!; //data contiene un mapa Map<String, dynamic>
          print("Data ${data["name"]}");
          /* 
          1. sila data tiene el campo favorito 
          2. si el campo favorito es true -> pintar el icono A
          3. Caso contrario pintar icono B
           */

          bool flagFavorite = false;
          try {
            if (data["isFavorite"] == true) {
              flagFavorite = true;
            }
          } on StateError {
            print('state error');
          }

          return renderFavoriteIcon(flagFavorite);
        });
/*     return IconButton(
      icon: const Icon(Icons.favorite_outline),
      onPressed: () => _markFavofiteStatus(widget.id, true),
    ); */
  }

  /*
  
  */
}
