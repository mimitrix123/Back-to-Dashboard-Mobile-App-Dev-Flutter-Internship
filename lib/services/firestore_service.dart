import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> tasks(String uid) =>
      _db.collection('users').doc(uid).collection('tasks').orderBy('createdAt', descending: true).snapshots();

  Future<void> addTask(String uid, String title) =>
      _db.collection('users').doc(uid).collection('tasks').add({
        'title': title,
        'done': false,
        'createdAt': FieldValue.serverTimestamp(),
      });

  Future<void> updateTask(String uid, String taskId, bool done) =>
      _db.collection('users').doc(uid).collection('tasks').doc(taskId).update({'done': done});

  Future<void> deleteTask(String uid, String taskId) =>
      _db.collection('users').doc(uid).collection('tasks').doc(taskId).delete();
}
