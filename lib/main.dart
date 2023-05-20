import 'package:dam_u4_proyecto2_19400554_fb/Asignacion/actualizarasignacion.dart';
import 'package:dam_u4_proyecto2_19400554_fb/Asignacion/agregarasignacion.dart';
import 'package:dam_u4_proyecto2_19400554_fb/Asignacion/combo.dart';
import 'package:dam_u4_proyecto2_19400554_fb/Asistencia/agregarasistencia.dart';
import 'package:dam_u4_proyecto2_19400554_fb/Asistencia/asistencia.dart';
import 'package:dam_u4_proyecto2_19400554_fb/navegador.dart';
import 'package:flutter/material.dart';

//Importaciones Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Navegador(),
      routes: {
        '/addAsignacion':(context) => const AgregarAsignacion(),
        '/updateAsignacion':(context) => const ActualizarAsignacion(),
        '/addAsistencia':(context) => const AgregarAsistencia(),
      },
    );
  }
}
