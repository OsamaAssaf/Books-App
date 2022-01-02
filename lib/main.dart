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
        primarySwatch: Colors.deepPurple,
        backgroundColor: Colors.white,
        cardColor: Colors.grey[400],
        textTheme: const TextTheme(
          headline1: TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
          headline2: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
          bodyText1: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
          bodyText2: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.deepPurple[500],
        primarySwatch: Colors.deepPurple,
        backgroundColor: Colors.grey[900],
        cardColor: Colors.grey[600],
        textTheme: const TextTheme(
          headline1: TextStyle(
              color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
          headline2: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
          bodyText2: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
      home: const Home(),
    );
  }
}
