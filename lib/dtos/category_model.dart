const String tableCategory = "category";

//si se tiene varias tablas, se puee crear una por modelo.

class CategoryField {
  static const String id = "_id";
  static const String name = "name";
  static const String image = 'image';
  static const String json = 'json';
}

class CategoryModel {
  int id;
  String name;
  String image;

  CategoryModel(this.id, this.name, this.image);

  static CategoryModel fromJson(Map<String, Object?> json) => CategoryModel(
        //captura un objeto tipo json que se representa como un mapa, con clave valor.
        json[CategoryField.id]
            as int, //tengo que obtener del json el id, y se le hace un cast int.
        json[CategoryField.name] as String,
        json[CategoryField.image] as String,
      );

  Map<String, Object?> toJson() => {
        CategoryField.id: id,
        CategoryField.name: name,
        CategoryField.image: image
      };
}
