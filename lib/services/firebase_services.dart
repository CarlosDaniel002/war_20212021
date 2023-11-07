import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<Map<String, dynamic>>> getXP() async {
  try {
    List<Map<String, dynamic>> xp = [];

    QuerySnapshot queryExperience = await db.collection('experiences').get();

    queryExperience.docs.forEach((QueryDocumentSnapshot element) {
      xp.add(element.data() as Map<String, dynamic>);
    });

    return xp;
  } catch (e) {
    print("Error al obtener las experiencias: $e");
    return []; // Devuelve una lista vacía en caso de error en lugar de null
  }
}
