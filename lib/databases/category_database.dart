import 'package:path/path.dart';
import 'package:pokedex_mobile/dtos/category_model.dart';
import 'package:sqflite/sqflite.dart';

//Patron singleton
class CategoryDatabase {
  static final CategoryDatabase instance = CategoryDatabase
      ._init(); //patron estatico que me permite referenciar la propia clase

  static Database? _database;

  CategoryDatabase._init(); //Crea una instancia de la base de datos

  Future<Database> get database async {
    if (_database != null)
      return _database!; // se asegura de que la base de datos siempre va a retornar un valor
    _database = await _initDB('pokedex.db'); //Crear la base de datos
    return _database!;
  }

  Future<Database> _initDB(String file) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, file);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    //INTEGER
    //TEXT
    //BOLEAN
    //BLOB

    await db.execute('''
      CREATE TABLE $tableCategory(
        ${CategoryField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${CategoryField.name} TEXT NO NULL,
        ${CategoryField.image} TEXT NO NULL
        )
      ''');
  }

  Future<void> create(CategoryModel category) async {
    final db =
        await instance.database; //obtengo una referencia a mi baes de datos
    //el insert espera como
    //1er parametro --> Nombre de la tabla
    //2do parametro --> Map donde el key --> columna, value = valor
    //Categorymodel(1, nombre1, image1)
    //[id] = 1, [name] = nombre1, [image] = image1
    await db.insert(tableCategory, category.toJson()); //el json envia un mapa
  }

  Future<List<CategoryModel>> readAllCategories() async {
    final db = await instance.database;
    final results = await db.query(tableCategory);
    // results = List -->
    //  Map([id: 1, name: Nombre, image: Image1])
    //  Map([id: 1, name: Nombre, image: Image1])

    //el map transforma una lista de una objeto 1 a otro totalmente diferente
    // List(objeto1) -> List(objeto2)
    // List(integers) -> List(string)

    // En una lista de dart, al ser una lista se tiene alguans funciones asociadas.
    // List test = [1, 2, 3, 4, 5, 6];
    // test.firstWhere((element) => element>3);  //Retornar el primer elemento asociado a una condicion.
    return results
        .map((mapCategories) => CategoryModel.fromJson(mapCategories))
        .toList();
  }

  Future <void> delete(int id) async {
    final db = await instance.database;
    await db.delete(tableCategory, where: '${CategoryField.id} = ?', 
    whereArgs: [id]);
  }

//hay que cerrar la base de datos
  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
