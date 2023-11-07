//Carlos Daniel Taveras Liranzo (2021-2021)
import 'package:war_20212021/screen/contact.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:war_20212021/screen/inicio.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Tools',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(0, 178, 227,0)),
      ),
      initialRoute: '/inicio',
      routes: {
        '/inicio':(context) => ListVivenciasScreen(),
        '/contact':(context) => contact()
      },
    );
  }
}