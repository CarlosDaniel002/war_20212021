import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:war_20212021/services/Vivencia.dart';
import 'package:image_picker/image_picker.dart';
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
    floatingActionButton: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [ 
        FloatingActionButton(
          onPressed: () {
          Navigator.pushNamed(context, '/contact');
          },
          child: Icon(Icons.person), // Cambia el icono según tu necesidad
        ),
        SizedBox(height: 16), // Espacio entre los botones
        FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateEditVivenciaScreen(),
              ),
            ).then((value) => getVivencias());
          },
          child: Icon(Icons.add), // Icono para el segundo botón flotante
        ),
      ],
    )
    
    );
  }
}

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
          Text('Descripción: ${vivencia.date}'),
          Text('Descripción: ${vivencia.photoUrl}'),
          Text('Descripción: ${vivencia.audioUrl}')
        ],
      ),
    );
  }
}

class CreateEditVivenciaScreen extends StatefulWidget {
  @override
  _CreateEditVivenciaScreenState createState() => _CreateEditVivenciaScreenState();
}

class _CreateEditVivenciaScreenState extends State<CreateEditVivenciaScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  String _imagePath ='';
  String _audioPath = 'storage/emulated/0/Android/data/com.example.war_20209358/files/audio.wav';

void _startRecording() async {
  final hasPermission = await _audioRecorder.hasPermission();
  if (hasPermission) {
    _audioPath = 'storage/emulated/0/Android/data/com.example.war_20209358/files/audio.wav';  // Asigna la ruta inicial aquí
    await _audioRecorder.start(RecordConfig(), path: _audioPath);
  }
}


  void _stopRecording() async {
    if (await _audioRecorder.isRecording()) {
      await _audioRecorder.stop();
    }
  }

  void _playAudio() async {
    if (_audioPath.isNotEmpty) {
      await _audioPlayer.play("storage/emulated/0/Android/data/" "com.example.war_20209358/files/audio.wav" as Source);
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
              ElevatedButton(
                onPressed: () async {
                  final image = await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      _imagePath = image.path; // Guarda la ruta de la imagen en la variable
                    });
                  }
                },
                child: Text('Subir/Tomar Foto'),
              ),
              ElevatedButton(
                onPressed: _startRecording,
                child: Text('Iniciar Grabación de Audio'),
              ),
              ElevatedButton(
                onPressed: _stopRecording,
                child: Text('Detener Grabación de Audio'),
              ),
              ElevatedButton(
                onPressed: _playAudio,
                child: Text('Reproducir Audio'),
              ),
              ElevatedButton(
                onPressed: () {
                  create(
                    Vivencia(
                      title: titleController.text, 
                      date: DateTime.now(), 
                      description: descriptionController.text,  
                      photoUrl: _imagePath, 
                      audioUrl: _audioPath)
                  );
                },
                child: Text('Guardar Vivencia'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
