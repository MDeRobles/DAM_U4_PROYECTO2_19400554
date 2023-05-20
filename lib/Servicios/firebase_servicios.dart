import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore BD = FirebaseFirestore.instance;

//--------------------------Asignacion--------------------------

//Funcion para obtener la informacion que esta en la BD
Future<List> getAsignacion() async{
  List asignacion = [];
  CollectionReference collectionReferenceVehiculo  = BD.collection('asignacion');
  //Consulta para obtener los datos de la coleccion
  QuerySnapshot queryAsignacion = await BD.collection('asignacion').get();
  for (var doc in queryAsignacion.docs){
    final Map<String,dynamic>data = doc.data() as Map<String,dynamic>;
    final asignaciones = {
      "salon":data['salon'],
      "edificio":data['edificio'],
      "horario":data['horario'],
      "docente":data['docente'],
      "materia":data['materia'],
      "dID":doc.id,
    };
    asignacion.add(asignaciones);
  }
  return asignacion;
}

//Funcion para agregar Vehiculo
Future<void> addAsignacion(String salon,String edificio,
    String horario,String docente, String materia) async {

  await  BD.collection('asignacion').add({"salon":salon,"edificio":edificio,"horario":horario,
    "docente":docente,"materia":materia});

}

//Funcion para actualizar Vehiculo
Future<void> updateAsignacion(String dID, String salon,String edificio,
    String horario,String docente, String materia) async{

  await BD.collection('asignacion').doc(dID).set({"salon":salon,"edificio":edificio,"horario":horario,
    "docente":docente,"materia":materia});
}

//Funcion para eliminar Asignacion
Future<void> deleteAsignacion(String dID) async {
  await BD.collection('asignacion').doc(dID).delete();
}

//--------------------------ASISTENCIA--------------------------
Future<List> getAsistencia() async{
  List asistencia = [];
  CollectionReference collectionReferenceVehiculo  = BD.collection('asistencia');
  //Consulta para obtener los datos de la coleccion
  QuerySnapshot queryAsistencia = await BD.collection('asistencia').get();
  for (var doc in queryAsistencia.docs){
    final Map<String,dynamic>data = doc.data() as Map<String,dynamic>;
    final asistencias = {
      "fecha":data['fecha'],
      "revisor":data['revisor'],
      "docente":data['docente'],
      "dID":doc.id,
    };
    asistencia.add(asistencias);
  }
  return asistencia;
}

//Funcion para agregar Vehiculo
Future<void> addAsistencia(String fecha,String revisor,String docente) async {
  await  BD.collection('asistencia').add({"fecha":fecha,"revisor":revisor,"docente":docente});
}

//Funcion para actualizar VehiculoS
Future<void> updateAsistencia(String dID,String fecha,String revisor,String docente) async{

  await BD.collection('asistencia').doc(dID).set({"fecha":fecha,"revisor":revisor,"docente":docente});
}

//Funcion para eliminar Asignacion
Future<void> deleteAsistencia(String dID) async {
  await BD.collection('asistencia').doc(dID).delete();
}


Future<List<String>> getDocentes() async {
  List<String> docentes = [];
  QuerySnapshot querySnapshot = await BD.collection("asignacion").get();
  for (var docSnapshot in querySnapshot.docs) {
    final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    docentes.add(data['docente']);
  }
  return docentes;
}


//Consulta 1
Future<List<Map<String, dynamic>>> getAsistenciaDocente(String docente) async {
  List<Map<String, dynamic>> bitacorafecha = [];
  QuerySnapshot querySnapshot = await BD.collection("asistencia").where("docente", isEqualTo: docente).get();
  for (var docSnapshot in querySnapshot.docs) {
    final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    bitacorafecha.add({'fecha': data['fecha'], 'revisor': data['revisor']});
  }
  return bitacorafecha;
}

Future<List<String>> getDocenteA() async {
  List<String> placas = [];
  QuerySnapshot querySnapshot = await BD.collection("asistencia").get();
  for (var docSnapshot in querySnapshot.docs) {
    final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    placas.add(data['docente']);
  }
  return placas;
}
//Consulta 2
Future<List<Map<String, dynamic>>> getAsistenciaRevisor(String docente) async {
  List<Map<String, dynamic>> bitacorafecha = [];
  QuerySnapshot querySnapshot = await BD.collection("asistencia").where("revisor", isEqualTo: docente).get();
  for (var docSnapshot in querySnapshot.docs) {
    final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    bitacorafecha.add({'fecha': data['fecha'], 'docente': data['docente']});
  }
  return bitacorafecha;
}

Future<List<String>> getRevisorA() async {
  List<String> placas = [];
  QuerySnapshot querySnapshot = await BD.collection("asistencia").get();
  for (var docSnapshot in querySnapshot.docs) {
    final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    placas.add(data['revisor']);
  }
  return placas;
}
