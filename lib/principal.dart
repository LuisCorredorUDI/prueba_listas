import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:prueba_listas/clases/Mensaje.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  //en el emulador no se escribe localhost, se escribe: 10.0.2.2
  String localhostVar = 'http://10.0.2.2:3000/';

  // Lista para recibir los mensajes
  List<Mensaje> listaMensajes = [];

  @override
  void initState() {
    super.initState();
    traerMensajes();
  }

  Future<void> traerMensajes() async {
    final respuesta = await Dio().get(localhostVar + 'mensajes/');

    if (respuesta.statusCode == 200) {
      List<dynamic> data = respuesta.data;
      List<Map<String, dynamic>> dataList =
          List<Map<String, dynamic>>.from(data);

      setState(() {
        listaMensajes =
            dataList.map((elemento) => Mensaje.fromJson(elemento)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado'),
      ),
      body: ListView.builder(
        itemCount: listaMensajes.length,
        itemBuilder: (context, index) {
          final mensaje = listaMensajes[index];
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              title: Text(mensaje.nick),
              subtitle: Text(mensaje.mensaje),
              leading: CircleAvatar(
                child: Text(mensaje.id.toString()),
              ),
            ),
          );
        },
      ),
    );
  }
}
