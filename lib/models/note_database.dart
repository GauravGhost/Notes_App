import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:notes_offline/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier{
  static late Isar isar;

  // Initialize the database
  static Future<void> initialize() async {
    final dir = await getApplicationCacheDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  // List of notes
  final List<Note> currentNotes = [];

  // Create a note
  Future<void> addNote(String text) async {
    final newNote = Note()..text = text;
    // save to db
    await isar.writeTxn(() => isar.notes.put(newNote));
    // re-read from db
    fetchNotes();
  }

  // Read a note from db
  Future<void> fetchNotes() async {
    List<Note> fetchNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchNotes);
    notifyListeners();
  }

  // Update a note
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  // Delete a note
  Future<void> deleteNote(int id) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      await isar.writeTxn(() => isar.notes.delete(id));
      await fetchNotes();
    }
  }
}
