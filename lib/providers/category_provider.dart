import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:pokedex_mobile/databases/category_database.dart';
import 'package:pokedex_mobile/dtos/category_model.dart';

//Estado de categorias que voy a administrar en mi aplicación.
class CategoryProvider extends ChangeNotifier {
  // _ significa que la lista es privada la administración lo hará esta clase
  final List<CategoryModel> _categories = [];

  int get totalCategories => _categories.length;

  //si no se va a modificar, es mejor utilizar este unmodifiable para ahorrar recursos.
  UnmodifiableListView<CategoryModel> get categoriesGetter =>
      UnmodifiableListView(_categories);

  void addCategory(String name) {
    CategoryModel categoryModel =
        CategoryModel(_categories.length + 1, name, '');
    _categories.add(categoryModel);
    CategoryDatabase.instance.create(categoryModel);

    notifyListeners(); //cada que se hace un cambio interno, los que estan suscritos a este provedor, serán notificados
  }

  Future<void> initializeCategories() async {
    List<CategoryModel> categories =
        await CategoryDatabase.instance.readAllCategories();
    _categories.clear();
    _categories.addAll(categories);
    notifyListeners();
  }

  Future<void> deleCategory(int id) async {
    _categories.removeWhere((element) => element.id == id);
    await CategoryDatabase.instance.delete(id);
    notifyListeners();
  }

  void clearList() {
    _categories.clear();
    notifyListeners();
  }
}
