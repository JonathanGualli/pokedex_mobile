import 'package:flutter/material.dart';

class Pokemon {
  int id;
  String name;
  String imageURL;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageURL,
  });

  //factory permite indicar que el metodo que se hace luego de factory será un constructor
  //Factory indica que el metodo que viene a continuación va a ser usado como constructor dentro del objeto.

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      imageURL: json['sprites']['front_default'],
    );
  }

  factory Pokemon.fromFirestoreJson(Map<String, dynamic> json) => Pokemon(
        id: json['id'],
        name: json['name'],
        imageURL: json['imageURL'],
      );

  Map<String, Object?> toJson() =>
      {'id': id, 'name': name, 'imageURL': imageURL};
}
