import 'package:flutter/material.dart';
import 'package:notes_offline/models/note_database.dart';
import 'package:notes_offline/pages/notes_page.dart';
import 'package:provider/provider.dart';

void main() async {
  // Initialize isar notes database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();
  runApp(ChangeNotifierProvider(
    create: (context) => NoteDatabase(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesPage(),
    );
  }
}
