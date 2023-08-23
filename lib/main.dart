import 'package:flutter/material.dart';
import 'package:pokedex_mobile/providers/category_provider.dart';
import 'package:pokedex_mobile/providers/login_provider.dart';
import 'package:pokedex_mobile/providers/pokemon_provider.dart';
import 'package:pokedex_mobile/screens/category_screen.dart';
import 'package:pokedex_mobile/screens/login_screen.dart';
import 'package:pokedex_mobile/screens/pokemon_details.dart';
import 'package:pokedex_mobile/screens/pokemon_screen.dart';
import 'package:pokedex_mobile/screens/profile_screen.dart';
import 'package:pokedex_mobile/screens/register_screen.dart';
import 'package:pokedex_mobile/services/navigation_service.dart';
import 'package:pokedex_mobile/widgets/pokemon_favorite_list.dart';
import 'package:provider/provider.dart';

//Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  //evita que se ejecute la aplicacion cuadno dependemos de un servicio.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => PokemonProvier()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.instance.navigatorKey,

        title: 'Pokedex',
        //initialRoute: MainWidget.routeName,
        initialRoute: LoginScreen.routeName,

        routes: {
          MainWidget.routeName: (context) => const MainWidget(),
          PokemonDetailsScreen.routeName: (context) =>
              const PokemonDetailsScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          RegisterScreen.routeName: (context) => const RegisterScreen(),
        },
      ),
    );
  }
}

class MainWidget extends StatefulWidget {
  static const routeName = '/Home';

  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  int _selectIndex = 3;

  final List<Widget> _mainWidgets = const [
    CategoryScreen(),
    PokemonScreenWidget(),
    PokemonFavoriteListScreen(),
    ProfileScreen(),
  ];

  void _onTapItem(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mainWidgets[_selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Categorias"),
          BottomNavigationBarItem(icon: Icon(Icons.details), label: "Pokemons"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favoritos"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
        currentIndex: _selectIndex,
        onTap: _onTapItem,
      ),
    );
  }
}
