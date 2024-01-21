import 'package:flutter/material.dart';
import 'package:google_books/db/db_helper.dart';
import 'package:google_books/screens/home.dart';
import 'package:google_books/services/book_provider.dart';
import 'package:google_books/services/themes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => BookProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => Themes(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = context.watch<Themes>().themeMode;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        primaryColor: Colors.deepPurple[500],
        cardColor: Colors.grey[400],
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
          bodyLarge: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
          bodyMedium: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple).copyWith(
          background: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.deepPurple[500],
        cardColor: Colors.grey[600],
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
            .copyWith(background: Colors.grey[900]),
      ),
      home: const Home(),
    );
  }
}
