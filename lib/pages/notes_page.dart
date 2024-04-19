import 'package:flutter/material.dart';
import 'package:notes_offline/components/drawer.dart';
import 'package:notes_offline/components/note_tile.dart';
import 'package:notes_offline/models/note.dart';
import 'package:notes_offline/models/note_database.dart';
import 'package:notes_offline/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    readNote(context);
  }

  // create a note
  void createNote(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        content: TextField(controller: textController),
        actions: [
          MaterialButton(
            onPressed: () {
              // add to db
              context.read<NoteDatabase>().addNote(textController.text);
              // clear the text field and pop the dialog
              textController.clear();
              Navigator.pop(context);
            },
            child: const Text("Create"),
          )
        ],
      ),
    );
  }

  // Read the note
  void readNote(BuildContext context) {
    context.read<NoteDatabase>().fetchNotes();
  }

  void updateNote(BuildContext context, Note note) {
    // pre fill the current note
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("Update Note"),
        content: TextField(controller: textController),
        actions: [
          MaterialButton(
            onPressed: () {
              // add to db
              context
                  .read<NoteDatabase>()
                  .updateNote(note.id, textController.text);
              // clear the text field and pop the dialog
              textController.clear();
              Navigator.pop(context);
            },
            child: const Text("Update"),
          )
        ],
      ),
    );
  }

  void deleteNote(BuildContext context, int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();
    List<Note> currentNotes = noteDatabase.currentNotes;
    final isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () =>
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme(),
                icon: isDarkMode
                    ? const Icon(Icons.light_mode)
                    : const Icon(Icons.dark_mode)),
          )
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () => createNote(context),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              "Notes",
              style: GoogleFonts.dmSerifText(
                  fontSize: 48,
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
          ),

          // List Of Notes
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                // get individual notes
                final note = currentNotes[index];
                return NoteTile(
                  text: note.text,
                  onPressedDelete: () => deleteNote(context, note.id),
                  onPressedUpdate: () => updateNote(context, note),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
