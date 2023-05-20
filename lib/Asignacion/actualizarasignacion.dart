import 'package:dam_u4_proyecto2_19400554_fb/Servicios/firebase_servicios.dart';
import 'package:flutter/material.dart';

class ActualizarAsignacion extends StatefulWidget {
  const ActualizarAsignacion({Key? key}) : super(key: key);

  @override
  State<ActualizarAsignacion> createState() => _ActualizarAsignacionState();
}


class _ActualizarAsignacionState extends State<ActualizarAsignacion> {



  TextEditingController edificioC = TextEditingController(text: "");
  TextEditingController salonC = TextEditingController(text: "");
  TextEditingController docenteC = TextEditingController(text: "");
  TextEditingController materiaC = TextEditingController(text: "");
  TextEditingController horarioC = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {



    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    edificioC.text = arguments['edificio'];
    salonC.text = arguments['salon'];
    docenteC.text = arguments['docente'];
    materiaC.text = arguments['materia'];
    horarioC.text = arguments['horario'];



    return Scaffold(
        appBar: AppBar(title: Text("ACTUALIZAR ASIGNACION",style: TextStyle(fontWeight: FontWeight.bold)),centerTitle: true,backgroundColor: Colors.orangeAccent),
        body: ListView(
          padding: EdgeInsets.all(30),
          children: [
            TextField(decoration: InputDecoration(labelText: "EDIFICIO",
                icon: Icon(Icons.local_convenience_store,color: Colors.green)),controller: edificioC,),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "SALON",
                icon: Icon(Icons.local_convenience_store_outlined,color: Colors.green)),controller: salonC,),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "DOCENTE",
                icon: Icon(Icons.person,color: Colors.green)),controller: docenteC,),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "MATERIA",
                icon: Icon(Icons.book,color: Colors.green)),controller: materiaC,),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "HORARIO",
                icon: Icon(Icons.access_time_filled_rounded,color: Colors.green)),controller: horarioC,),

            ElevatedButton(onPressed: () async {
              await updateAsignacion(arguments['dID'], edificioC.text, salonC.text, docenteC.text,
                  materiaC.text, horarioC.text).then((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("ASIGNACION ACTUALIZADA"))
                );
                Navigator.pop(context);
              });
            }, child: Text("Actualizar",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),)
          ],


        ));
  }
}
