import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note.dart';

class CrudService {
  final _notes = FirebaseFirestore.instance.collection('notes');

  Future<void> createNote(String title, String content) async {
    await _notes.add({'title': title, 'content': content});
  }

  Future<List<Note>> getNotes() async {
    final snapshot = await _notes.get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Note(id: doc.id, title: data['title'], content: data['content']);
    }).toList();
  }

  Future<void> updateNote(String id, String title, String content) async {
    await _notes.doc(id).update({'title': title, 'content': content});
  }

  Future<void> deleteNote(String id) async {
    await _notes.doc(id).delete();
  }
}
