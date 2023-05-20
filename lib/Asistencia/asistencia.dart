import 'package:dam_u4_proyecto2_19400554_fb/Servicios/firebase_servicios.dart';
import 'package:flutter/material.dart';

class AsistenciaInico extends StatefulWidget {
  const AsistenciaInico({Key? key}) : super(key: key);

  @override
  State<AsistenciaInico> createState() => _AsistenciaInicoState();
}

class _AsistenciaInicoState extends State<AsistenciaInico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Asistencia"),centerTitle: true, backgroundColor: Colors.orangeAccent),

        body: FutureBuilder(
          future: getAsistencia(),
          builder: ((context,snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context,index){
                    return InkWell(
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
                                    Text(snapshot.data?[index]['fecha'],style: TextStyle(fontSize: 10),textAlign: TextAlign.center,),
                                  ],
                                ),
                                title: Text("Revisor: "+snapshot.data?[index]['revisor'],
                                  style: TextStyle(fontWeight: FontWeight.bold),),
                                subtitle: Text("Docente: "+snapshot.data?[index]['docente']),
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
            await Navigator.pushNamed(context, '/addAsistencia');
            setState(() {});
          },
          child: Icon(Icons.add),backgroundColor: Colors.black,
        )

    );
  }
}
