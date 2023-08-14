import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_mobile/dtos/pokemon_model.dart'; // se crea un demonico

class PokemonProvier extends ChangeNotifier {
  // me conviene que la lista sea privada porque el unico que puede modificar la lista de pokemos es en esta clase,
  // no se puede permitir que otra clase altere la lista, porque pos no we.
  final List<Pokemon> _pokemons = [];

  int get totalPokemons => _pokemons.length;

  // como necesito obtener acceso de lectura a la lista pos utilizo este unmodifiableListView
  UnmodifiableListView<Pokemon> get pokemons => UnmodifiableListView(_pokemons);

  Pokemon getPokemon(int id) {
    /* for(int i=0; i<_pokemon.lenth; i++){
        if(_pokemon[i].id == id){
          return _pokemon[i];
        }
      }
    */
    return _pokemons.firstWhere((element) => element.id == id);
  }

  //!verifica si esque la lista de pokemones esta llena
  Future<bool> checkPokemons() async {
    if (_pokemons.isEmpty) {
      await _initPokemonsList();
      return true;
    }
    return false;
  }

  Future<void> _initPokemonsList() async {
    var client = http.Client();
    var response = await client.get(Uri.http('pokeapi.co', '/api/v2/pokemon'));
    //print("statusPokemos ${response.statusCode}"); //statuscode, representa el codigo de retorno del servidor http.
    /*
    20X -> OK
    3XX -> Redireccion
    4XX -> Error del cliente (cliente)
    5XX -> Errores de servidor 
    
    DART - JSON -> Map<String, Object>
    */

    var decodedResponde =
        jsonDecode(response.body); //transporta el body a un mapa
    var results = decodedResponde["results"] as List;
    for (var ri in results) {
      //-Map<String, Object>
      var url = ri['url'] as String;
      await addPokemonList(url);
    }
    notifyListeners();
  }

  Future<void> addPokemonList(String url) async {
    var client = http.Client();
    var response = await client.get(Uri.parse(url));
    var pokemonData = jsonDecode(response.body);
    print("Procesando: $url");

    /*
    var pokemon = Pokemon(
      id: pokemonData['id'],
      name: pokemonData['name'],
      imageUrl: pokemonData['sprites']['front_default'],
    )
    */

    _pokemons.add(Pokemon.fromJson(pokemonData));

    final pokemonDocument = <String, dynamic>{
      //'id': pokemonData['id'],
      "name": pokemonData['name'],
    };

    ///Guardamos en la base de datos
    var db = FirebaseFirestore.instance;
    /* 
    Future:
      -let value =  await future();
      future().then{
        (value) = {
          
        }
      } */
    /*  Agreagar documentos en la base con ids autogenerados 
    db.collection("pokemons").add(pokemonDocument).then(
          (value) => print("success"),
        ); 
  */

    //el metodo set me permite acutalizar para ese documento especifico un json.

    var setOptions = SetOptions(merge: true);
    db
        .collection("pokemons")
        .doc(pokemonData['id'].toString())
        .set(pokemonDocument, setOptions)
        .then((value) => print("sucess"));
  }

  Future<void> updatePokemonFavoriteStatus(int id, bool value) async {
    var db = FirebaseFirestore.instance;
    await db.collection('pokemons').doc(id.toString()).update({
      'isFavorite': value,
    });
  }
}
