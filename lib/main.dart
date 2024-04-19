import 'package:flutter/material.dart';
import 'package:notes_offline/models/note_database.dart';
import 'package:notes_offline/pages/notes_page.dart';
import 'package:notes_offline/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  // Initialize isar notes database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();
  runApp(MultiProvider(
    providers: [
      // Notes Provider
      ChangeNotifierProvider(create: (context) => NoteDatabase()),
      // Theme Provider
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
      home: NotesPage(),
    );
  }
}
