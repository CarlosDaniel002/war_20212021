import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Vivencia {
  final String title;
  final DateTime date;
  final String description;
  final String photoUrl;
  final String audioUrl;

  Vivencia({
    required this.title,
    required this.date,
    required this.description,
    required this.photoUrl,
    required this.audioUrl,
  });
}


Future<void> create(Vivencia vivencia) async {
  try {
    // Subir la foto a Firebase Storage y obtener la URL
    final String photoUrl = await uploadFileToStorage(vivencia.photoUrl);

    // Subir el audio a Firebase Storage y obtener la URL
    final String audioUrl = await uploadFileToStorage(vivencia.audioUrl);

    // Crear una nueva vivencia con las URLs de la foto y el audio
    await FirebaseFirestore.instance.collection('vivencias').add({
      'title': vivencia.title,
      'date': vivencia.date,
      'description': vivencia.description,
      'photoUrl': photoUrl,
      'audioUrl': audioUrl,
    });
  } catch (e) {
    print('Error al registrar la vivencia: $e');
  }
}

Future<List<Vivencia>> read() async {
  List<Vivencia> vivencias = [];
  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('vivencias').get();

    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      var data = document.data() as Map<String, dynamic>;
      Vivencia vivencia = Vivencia(
        title: data['title'],
        date: data['date'].toDate(),
        description: data['description'],
        photoUrl: data['photoUrl'],
        audioUrl: data['audioUrl'],
      );
      vivencias.add(vivencia);
    }
  } catch (e) {
    print('Error al leer vivencias: $e');
  }
  return vivencias;
}

Future<void> update(String vivenciaId, Vivencia vivencia) async {
  try {
    await FirebaseFirestore.instance
        .collection('vivencias')
        .doc(vivenciaId)
        .update({
      'title': vivencia.title,
      'date': vivencia.date,
      'description': vivencia.description,
      'photoUrl': vivencia.photoUrl,
      'audioUrl': vivencia.audioUrl,
    });
  } catch (e) {
    print('Error al actualizar la vivencia: $e');
  }
}

Future<void> delete(String vivenciaId) async {
  try {
    await FirebaseFirestore.instance.collection('vivencias').doc(vivenciaId).delete();
  } catch (e) {
    print('Error al eliminar la vivencia: $e');
  }
}

Future<String> uploadFileToStorage(String fileUrl) async {
  try {
    final Reference storageReference =
        FirebaseStorage.instance.ref().child('uploads/${DateTime.now()}.jpg');

    final UploadTask uploadTask = storageReference.putFile(File(fileUrl));

    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  } catch (e) {
    print('Error al subir el archivo a Firebase Storage: $e');
    return '';
  }
}
