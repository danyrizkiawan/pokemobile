import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'features/pokemon/presentation/pages/pokemon_list_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF2D2D2D),
        accentColor: Color(0xFF666666),
        cardColor: Colors.amber,
        scaffoldBackgroundColor: Color(0xFFF7F7F7),
        fontFamily: 'Poppins',
      ),
      home: SplashScreen(
        seconds: 5,
        navigateAfterSeconds: PokemonListPage(),
        useLoader: false,
        photoSize: 64,
        image: Image.asset('assets/images/logo_splash.png'),
        title: Text(
          'Pokédex',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 32.0,
            color: Color(0xFF2D2D2D),
          ),
        ),
        backgroundColor: Colors.amber,
      ),
    );
  }
}
