import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cinemapedia_flutter_app/providers/movies_provider.dart';
import 'package:cinemapedia_flutter_app/screens/screens.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
          lazy: false,
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        primaryColor: Colors.indigo,
        appBarTheme: const AppBarTheme(
          color: Colors.indigo,
        ),
      ),
      routes: {
        'home': (__) => const HomeScreen(),
        'details': (__) => const DetailsScreen()
      },
      initialRoute: 'home',
    );
  }
}
