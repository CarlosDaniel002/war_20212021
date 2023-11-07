import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:war_20212021/services/Vivencia.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:audioplayers/audioplayers.dart';


class ListVivenciasScreen extends StatefulWidget {
  @override
  _ListVivenciasScreenState createState() => _ListVivenciasScreenState();
}

class _ListVivenciasScreenState extends State<ListVivenciasScreen> {
  List<Vivencia> vivencias = [];

  @override
  void initState() {
    super.initState();
    getVivencias();
  }

  Future<void> getVivencias() async {
    vivencias = await read();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de Vivencias'),
      ),
      body: ListView.builder(
        itemCount: vivencias.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(vivencias[index].title),
            subtitle: Text(vivencias[index].description),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsVivenciaScreen(vivencia: vivencias[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateEditVivenciaScreen(),
            ),
          ).then((value) => getVivencias());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// Vista para ver los detalles de una vivencia específica
class DetailsVivenciaScreen extends StatelessWidget {
  final Vivencia vivencia;

  DetailsVivenciaScreen({required this.vivencia});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Vivencia'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Título: ${vivencia.title}'),
          Text('Descripción: ${vivencia.description}'),
          // Mostrar otros detalles aquí (fecha, imagen, audio, etc.)
        ],
      ),
    );
  }
}

// Vista para crear una nueva vivencia
// Pantalla de Crear/Editar Vivencia
class CreateEditVivenciaScreen extends StatefulWidget {
  @override
  _CreateEditVivenciaScreenState createState() => _CreateEditVivenciaScreenState();
}

class _CreateEditVivenciaScreenState extends State<CreateEditVivenciaScreen> {
  // Declarar controladores de texto y otros elementos del formulario
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now(); // Para seleccionar la fecha
  final TextEditingController fotoController = TextEditingController();
  final TextEditingController audioController = TextEditingController();
  final AudioRecorder _audioRecorder = AudioRecorder();
  String _path = 'storage/emulated/0/Android/data/com.example.war_20209358/files/audio.wav';
  AudioPlayer _audioPlayer = AudioPlayer();

  void _onPressed() async {
    final hasPermission = await _audioRecorder.hasPermission();
    if (hasPermission) {
      final path = await _audioRecorder.start(RecordConfig(), path: _path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear/Editar Vivencia'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            // Campo para subir o tomar una foto
            ElevatedButton(
              onPressed: () async {
                final ImagePicker _picker = ImagePicker();
                final XFile? image = await _picker.pickImage(source: ImageSource.gallery); // Puedes usar también ImageSource.camera para tomar una foto
                if (image != null) {
                  // Aquí puedes guardar la ruta de la imagen en la base de datos o realizar otras operaciones
                  fotoController.text = image.path; // Guarda la ruta de la imagen en el controlador
                }
              },
              child: Text('Subir/Tomar Foto'),
            ),
            // Campo para grabar audio
            IconButton(
              icon: Icon(Icons.mic),
              onPressed: () async {
                final recorder = AudioRecorder();
                String path = await recorder.startRecording();
                // Aquí puedes guardar la ruta del audio en la base de datos o realizar otras operaciones
                audioController.text = path; // Guarda la ruta del audio en el controlador
              },
            ),
            // Botones para guardar la vivencia o cargar la foto/audio
            ElevatedButton(
              onPressed: () {
                // Lógica para guardar la vivencia
              },
              child: Text('Guardar Vivencia'),
            ),Agregar botones para guardar la vivencia
            ],
          ),
        ),
      ),
    );
  }
}

