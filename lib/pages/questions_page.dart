import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage>
    with TickerProviderStateMixin {
  String respuesta = '';
  final TextEditingController _preguntaController = TextEditingController();
  double rotationAngle = 0.0;
  AudioPlayer audioPlayer = AudioPlayer();
  int shakeCount = 0;
  double imageX = 0.0; // Posición X de la imagen
  double imageY = 0.0; // Posición Y de la imagen

  final List<String> respuestas = [
    'Sí',
    'No',
    'Tal vez',
    'Definitivamente',
    'No lo sé',
    'Pregunta de nuevo más tarde',
  ];
  late AnimationController _rotationController;
  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration:
          const Duration(seconds: 4), // Puedes ajustar la velocidad de rotación
      vsync: this,
    )..repeat();
    // AudioPlayer audioPlayer = AudioPlayer();
    // audioPlayer.setReleaseMode(ReleaseMode.loop);
    // audioPlayer.play(AssetSource('audios/fondo.mp3'));

    userAccelerometerEvents.listen(
      (UserAccelerometerEvent event) {
        final double x = event.x;
        final double y = event.y;
        final double z = event.z;

        

        // if (y.abs() > 1 ) {
        //   setState(() {

        //     imageX += x * 10;
        //     imageY += y * 10;

        //     // Limita la posición de la imagen para que no se salga de la pantalla
        //     imageX = imageX.clamp(0.0, MediaQuery.of(context).size.width - 200);
        //     imageY =
        //         imageY.clamp(0.0, MediaQuery.of(context).size.height - 200);

        //     shakeCount++;
        //     if ((shakeCount >= 2) && (_preguntaController.text.isNotEmpty)) {
        //       obtenerRespuesta();
        //       _rotationController.forward(from: 0.0);
        //       Navigator.pushNamed(context, '/answer', arguments: respuesta);
        //       _preguntaController.clear();
        //       shakeCount = 0;
        //     }
        //   });
        // }

          setState(() {
        // Ajusta estos valores según la sensibilidad que desees
        imageX += x * 100;
        imageY += y * 100;

        // Limita la posición de la imagen para que no se salga de la pantalla
        imageX = imageX.clamp(0.0, MediaQuery.of(context).size.width - 20);
        imageY = imageY.clamp(0.0, MediaQuery.of(context).size.height - 20);
      });
      },
      onError: (error) {
         showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text("Sensor no encontrado"),
                  content: Text(
                      "No se ha encontrado el sensor de aceleración en tu dispositivo"),
                );
              });
      },
      cancelOnError: true,
    );
  }

  @override
  void dispose() {
    _rotationController.dispose(); // Asegúrate de liberar los recursos
    audioPlayer.dispose();
    super.dispose();
  }

  void obtenerRespuesta() {
    setState(() {
      if (_preguntaController.text.isNotEmpty) {
        respuesta = respuestas[Random().nextInt(respuestas.length)];
      } else {
        respuesta = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Positioned(
              left: imageX,
              top: imageY,
              child: RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0).animate(_rotationController),
                  child: Image.asset('assets/images/bola8.png',
                      width: 200, height: 200)),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _preguntaController,
                decoration: const InputDecoration(
                  labelText: 'Haz una pregunta...',
                ),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                obtenerRespuesta();
                _rotationController.forward(from: 0.0);
                Navigator.pushNamed(context, '/answer', arguments: respuesta);
                _preguntaController.clear();
              },
              child: const Text('¡Obtener respuesta!'),
            ),
          ],
        ),
      ),
    );
  }
}
