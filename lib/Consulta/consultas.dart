import 'package:dam_u4_proyecto2_19400554_fb/Servicios/firebase_servicios.dart';
import 'package:flutter/material.dart';

class ConsultasInicio extends StatefulWidget {
  const ConsultasInicio({Key? key}) : super(key: key);

  @override
  State<ConsultasInicio> createState() => _ConsultasInicioState();
}

final docenteC = TextEditingController();
final revisorC = TextEditingController();

class _ConsultasInicioState extends State<ConsultasInicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Consultas"),centerTitle: true, backgroundColor: Colors.orangeAccent),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          Text("Consulta de Asistencia:  \n\nListado de asistencia de un docente determinado",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold,),textAlign: TextAlign.center),
          SizedBox(height: 20),
          Text("DOCENTES ACTUALES",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,),textAlign: TextAlign.center),
          SizedBox(height: 20),
          FutureBuilder<List<String>>(
            future: getDocenteA(),
            builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
              return Text(snapshot.data.toString(),textAlign: TextAlign.center,);
            },
          ),
          SizedBox(height: 20),
          TextField(decoration: InputDecoration(labelText: "ESCRIBE UN DOCENTE PARA CONSULTAR SU ASISTENCIA",
              icon: Icon(Icons.person_search,color: Colors.green)),controller: docenteC,autofocus: true,),
          SizedBox(height: 20),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: getAsistenciaDocente(docenteC.text),
            builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text('\nFyH: ${snapshot.data![index]['fecha']} \n Revisado por : ${snapshot.data![index]['revisor']}',
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text('Loading...');
              }
            },
          ),
          ElevatedButton(onPressed: () async {
            setState(() {
              docenteC.text;
            });
          }, child: Text("Consultar",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),),
          Divider(height: 20,thickness: 2, color: Colors.green),
          Text("Consulta de Asistencia:  \n\nListado de asistencia de un revisor determinado",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold,),textAlign: TextAlign.center),
          SizedBox(height: 20),
          Text("REVISORES ACTUALES",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,),textAlign: TextAlign.center),
          SizedBox(height: 20),
          FutureBuilder<List<String>>(
            future: getRevisorA(),
            builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
              return Text(snapshot.data.toString(),textAlign: TextAlign.center,);
            },
          ),
          SizedBox(height: 20),
          TextField(decoration: InputDecoration(labelText: "ESCRIBE UN REVISOR PARA CONSULTAR SU ASISTENCIA",
              icon: Icon(Icons.person_search,color: Colors.green)),controller: revisorC,autofocus: true,),
          SizedBox(height: 20),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: getAsistenciaRevisor(revisorC.text),
            builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text('\nFyH: ${snapshot.data![index]['fecha']} \n Docente al que reviso : ${snapshot.data![index]['docente']}',
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text('Loading...');
              }
            },
          ),
          ElevatedButton(onPressed: () async {
            setState(() {
              docenteC.text;
            });
          }, child: Text("Consultar",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),),
          Divider(height: 20,thickness: 2, color: Colors.green),
        ],
      ),
    );
  }
}
