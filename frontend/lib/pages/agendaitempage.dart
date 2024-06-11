import 'package:flutter/material.dart';

class AgendaItemPage extends StatefulWidget {
  const AgendaItemPage({Key? key});

  @override
  State<AgendaItemPage> createState() => _AgendaItemPageState();
}

class _AgendaItemPageState extends State<AgendaItemPage> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Evento'),
        backgroundColor: arguments['color'], // Definindo a cor do evento como cor de fundo do app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Evento: ${arguments['title']}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Descrição: ${arguments['description']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Data: ${arguments['date']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Hora de Início: ${arguments['startTime']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Hora de Término: ${arguments['endTime']}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
