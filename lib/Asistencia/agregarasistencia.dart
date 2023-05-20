import 'package:dam_u4_proyecto2_19400554_fb/Servicios/firebase_servicios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class AgregarAsistencia extends StatefulWidget {
  const AgregarAsistencia({Key? key}) : super(key: key);

  @override
  State<AgregarAsistencia> createState() => _AgregarAsistenciaState();
}

List Departamentos = ["CV","LC","UVP","LIIA","LICBI","UD","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X"];

List Gasolina = ["Gasolina low cost","Gasolina normal","Gasolina premium","Diesel"];



final revisorC = TextEditingController();
final fechaC = TextEditingController();
final docenteC = TextEditingController();



String _Depa = Departamentos.first;

String _Gasolina = Gasolina.first;

class _AgregarAsistenciaState extends State<AgregarAsistencia> {
  List<String> docentes = [];
  String currentDateTime = '';
  String selectedDocente = "";

  @override
  void initState() {
    super.initState();
    getCurrentDateTime();
  }

  void getCurrentDateTime() {
    final now = DateTime.now();
    setState(() {
      currentDateTime = now.toString();
      obtenerDocentes();
    });
  }

  Future<void> obtenerDocentes() async {
    List<String> listaDocentes = await getDocentes();
    setState(() {
      docentes = listaDocentes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agregar Asistencia"),centerTitle: true, backgroundColor: Colors.orangeAccent),
      body: ListView(
          padding: EdgeInsets.all(30),
          children: [
            TextField(
                readOnly: true,
                controller: TextEditingController(text: currentDateTime),
                decoration: InputDecoration(
                  labelText: 'FECHA Y HORA ACTUAL',
                )),
            SizedBox(height: 20),
            TextField(decoration: InputDecoration(labelText: "REVISOR",
                icon: Icon(Icons.person,color: Colors.green)),controller: revisorC,),
            SizedBox(height: 10),
            Text("DOCENTES ACTUALES",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,),textAlign: TextAlign.center),
            SizedBox(height: 20),
            FutureBuilder<List<String>>(
              future: getDocentes(),
              builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                return Text(snapshot.data.toString(),textAlign: TextAlign.center,);
              },
            ),
            SizedBox(height: 20),
            TextField(decoration: InputDecoration(labelText: "ESCRIBE UN DOCENTE",
                icon: Icon(Icons.card_membership,color: Colors.green)),controller: docenteC,autofocus: true,),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () async {
              addAsistencia(currentDateTime.toString(), revisorC.text,
                  docenteC.text).then((_){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("ASISTENCIA AGREGADA"))
                );
                fechaC.text ="";
                revisorC.text="";
                docenteC.text="";
                Navigator.pop(context);
              });
            }, child: Text("Agregar",style: TextStyle( fontWeight: FontWeight.bold,fontSize: 16)),style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),)
          ]
      ),
    );
  }
}
