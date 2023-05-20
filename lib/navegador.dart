import 'package:dam_u4_proyecto2_19400554_fb/Asignacion/asignacion.dart';
import 'package:dam_u4_proyecto2_19400554_fb/Asistencia/asistencia.dart';
import 'package:dam_u4_proyecto2_19400554_fb/Consulta/consultas.dart';
import 'package:flutter/material.dart';

class Navegador extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _Navegador();
  }
}

class _Navegador extends State<Navegador>{
  int _indice = 0;

  void _cambiarIndice(int indice){
    setState(() {
      _indice = indice;
    });
  }

  final List<Widget> _pagina = [
    AsignacionInicio(),
    ConsultasInicio(),
    AsistenciaInico(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pagina[_indice],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.assignment_turned_in_outlined), label: "Asignacion"),
          BottomNavigationBarItem(icon: Icon(Icons.content_paste_search), label: "Consultas"),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: "Asistencia")
        ],
        currentIndex: _indice,
        showUnselectedLabels: false,
        iconSize: 30,
        backgroundColor: Colors.orangeAccent,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        onTap: _cambiarIndice,

      ),
    );
  }

}
