import 'package:dam_u4_proyecto2_19400554_fb/Servicios/firebase_servicios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class AgregarAsignacion extends StatefulWidget {
  const AgregarAsignacion({Key? key}) : super(key: key);

  @override
  State<AgregarAsignacion> createState() => _AgregarAsignacionState();
}

List Departamentos = ["CV","LC","UVP","LIIA","LICBI","UD","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X"];

List Gasolina = ["Gasolina low cost","Gasolina normal","Gasolina premium","Diesel"];


final salonC = TextEditingController();
final edificioC = TextEditingController();
final horarioC = TextEditingController();
final docenteC = TextEditingController();
final materiaC = TextEditingController();


String _Depa = Departamentos.first;

String _Gasolina = Gasolina.first;



class _AgregarAsignacionState extends State<AgregarAsignacion> {

  String selectedValue = '';
  List<String> secondComboValues = [];

  Map<String, List<String>> comboData = {
    'CV': ['CV1', 'CV2', 'CV3'],
    'LC': ['TSO', 'CISCO1', 'CISCO2'],
    'LICBI': ['L1', 'L2', 'L3'],
    'UVP': ['UVP1', 'UVP2', 'UVP3'],
    'UD': ['UD1', 'UD2', 'UD3'],
    'A': ['A1', 'A2', 'A3'],
    'B': ['B1', 'B2', 'B3'],
    'C': ['C1', 'C2', 'C3'],
    'D': ['D1', 'D2', 'D3'],
    'E': ['D1', 'D2', 'D3'],
    'F': ['F1', 'F2', 'F3'],
    'G': ['G1', 'G2', 'G3'],
    'H': ['H1', 'H2', 'H3'],
    'I': ['I1', 'I2', 'I3'],
    'J': ['J1', 'J2', 'J3'],
    'K': ['K1', 'K2', 'K3'],
    'L': ['L1', 'L2', 'L3'],
    'M': ['M1', 'M2', 'M3'],
    'N': ['N1', 'N2', 'N3'],
    'O': ['O1', 'O2', 'O3'],
    'P': ['P1', 'P2', 'P3'],
    'Q': ['Q1', 'Q2', 'Q3'],
    'R': ['R1', 'R2', 'R3'],
    'S': ['S1', 'S2', 'S3'],
    'T': ['T1', 'T2', 'T3'],
    'U': ['U1', 'U2', 'U3'],
    'V': ['V1', 'V2', 'V3'],
    'W': ['W1', 'W2', 'W3'],
    'X': ['X1', 'X2', 'X3'],

  };

  @override
  void initState() {
    super.initState();
    selectedValue = comboData.keys.first;
    secondComboValues = comboData[selectedValue]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agregar Asignacion"),centerTitle: true, backgroundColor: Colors.orangeAccent),
      body: ListView(
          padding: EdgeInsets.all(30),
          children: [
            SizedBox(height: 25),
            SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: "ELIGE UN EDIFICIO",border: OutlineInputBorder()),
                  icon: Icon(Icons.local_convenience_store_outlined,color: Colors.green),
                  value: selectedValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                      secondComboValues = comboData[selectedValue]!;
                    });
                  },
                  items: comboData.keys.map((String key) {
                    return DropdownMenuItem<String>(
                      value: key,
                      child: Text(key),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: "ELIGE UN SALON",border: OutlineInputBorder()),
                  value: secondComboValues.isNotEmpty ? secondComboValues[0] : null,
                  icon: Icon(Icons.local_convenience_store_outlined,color: Colors.green),
                  onChanged: (String? newValue) {
                    setState(() {
                      secondComboValues = [newValue!];
                    });
                  },
                  items: secondComboValues.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "DOCENTE",
                icon: Icon(Icons.person,color: Colors.green)),controller: docenteC,),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "MATERIA",
                icon: Icon(Icons.book,color: Colors.green)),controller: materiaC,),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "HORARIO",
                icon: Icon(Icons.calendar_month_outlined,color: Colors.green)),onTap: (){
              showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              ).then((selectedTime) {
                if (selectedTime != null) {
                  final formattedTime =
                  DateFormat('HH:mm').format(DateTime(2000, 1, 1, selectedTime.hour, selectedTime.minute));
                  horarioC.text = formattedTime;
                }
              });
            },controller: horarioC,),
            SizedBox(height: 25),
            ElevatedButton(onPressed: () async {
              addAsignacion(secondComboValues.toString(),selectedValue.toString(), horarioC.text,
                  docenteC.text, materiaC.text).then((_){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("DOCENTE AGREGADO"))
                );
                salonC.text ="";
                horarioC.text="";
                docenteC.text="";
                materiaC.text="";
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
