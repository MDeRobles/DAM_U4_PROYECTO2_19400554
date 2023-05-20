import 'package:dam_u4_proyecto2_19400554_fb/Servicios/firebase_servicios.dart';
import 'package:flutter/material.dart';

class AsignacionInicio extends StatefulWidget {
  const AsignacionInicio({Key? key}) : super(key: key);

  @override
  State<AsignacionInicio> createState() => _AsignacionInicioState();
}

class _AsignacionInicioState extends State<AsignacionInicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Asignacion"),centerTitle: true, backgroundColor: Colors.orangeAccent),
        body: FutureBuilder(
          future: getAsignacion(),
          builder: ((context,snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context,index){
                    return InkWell(
                        onTap: () {
                          showDialog(context: context, builder: (builder) {
                            return AlertDialog(
                              title: Text("ATENCION",textAlign: TextAlign.center,),
                              content: Text("¿QUÉ DESEA HACER CON EL DOCENTE ${snapshot.data?[index]['docente']}"+
                                  " PARA LA MATERIA \n${snapshot.data?[index]['materia']}?",
                                textAlign: TextAlign.center,),
                              actions: [
                                TextButton(onPressed: () async {
                                  Navigator.pop(context);
                                  await   Navigator.pushNamed(context, '/updateAsignacion',arguments: {
                                    "dID": snapshot.data?[index]['dID'],
                                    "salon": snapshot.data?[index]['salon'],
                                    "edificio": snapshot.data?[index]['edificio'],
                                    "horario":snapshot.data?[index]['horario'],
                                    "docente":snapshot.data?[index]['docente'],
                                    "materia":snapshot.data?[index]['materia']
                                  });
                                  setState(() {});
                                }, child: Text("ACTUALIZAR")),
                                TextButton(onPressed: () async {
                                  await deleteAsignacion(snapshot.data?[index]['dID']).then((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("DOCENTE ELIMINADO"))
                                    );
                                    setState(() {});
                                    Navigator.pop(context);
                                  });
                                }, child: const Text("BORRAR")),
                                TextButton(onPressed: () async {
                                  Navigator.pop(context);
                                }, child: const Text("NADA")),
                              ],
                            );
                          });
                        },
                        child:
                        Container(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              ListTile(
                                leading: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(Icons.access_time_filled,color: Colors.blue),
                                    SizedBox(height: 4.0),
                                    Text(snapshot.data?[index]['horario'],style: TextStyle(fontSize: 10),textAlign: TextAlign.center,),
                                  ],
                                ),
                                title: Text("Docente: "+snapshot.data?[index]['docente'],
                                  style: TextStyle(fontWeight: FontWeight.bold),),
                                subtitle: Text("Materia: "+snapshot.data?[index]['materia']),
                                trailing: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    SizedBox(height: 4.0),
                                    Icon(Icons.local_convenience_store_sharp,color: Colors.blue),
                                    Text(snapshot.data?[index]['edificio']+": "+snapshot.data?[index]['salon'],style: TextStyle(fontSize: 10),textAlign: TextAlign.center),

                                  ],
                                ),
                              ),
                              Divider(height: 20,thickness: 2, color: Colors.green),
                            ],
                          ),

                        )

                    );
                  }
              );
            }else{
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            await Navigator.pushNamed(context, '/addAsignacion');
            setState(() {});
          },
          child: Icon(Icons.add),backgroundColor: Colors.black,
        )
    );
  }
}
