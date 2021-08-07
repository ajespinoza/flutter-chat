import 'package:flutter/material.dart';

class Labels extends StatelessWidget {

  final String titulo;
  final String subtitulo;
  final String ruta;

  const Labels({
    required this.titulo,
    required this.subtitulo,
    required this.ruta,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(subtitulo, style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),),
          SizedBox(height: 10,),
          GestureDetector(
            onTap: (){
              Navigator.pushReplacementNamed(context, ruta);
            },
            child: Text(titulo, style: TextStyle(color: Colors.blue.shade600, fontSize: 18, fontWeight: FontWeight.bold))
          ),

        ],
      ),      
    );
  }
}

