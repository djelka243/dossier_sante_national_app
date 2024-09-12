import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( elevation: 0,backgroundColor:  Color(0x00FFFFFF)),
      drawer: MenuLateral(),
    );
  }
  }
Widget MenuLateral(){
  return Container(
      padding: EdgeInsets.all(20.0),
    color: Colors.white,
   child:
     Column(
      // mainAxisAlignment: MainAxisAlignment.center,
       children: [
       DrawerHeader(
         curve: Curves.elasticIn,
         child: Text("Mon dossier santé", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),),
       Text("data2"),
       Text("data3"),
     ],)
  );
}
