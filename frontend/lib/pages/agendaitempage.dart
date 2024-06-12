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
              'Data: ${_formatDate(arguments['date'])}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Hora de Início: ${_formatTime(arguments['startTime'])}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Hora de Término: ${_formatTime(arguments['endTime'])}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Divider(), // Linha divisória
            SizedBox(height: 20),
            Text(
              'Sugestões:', // Título para as sugestões
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: _buildSuggestionsList(), // Exibir lista de sugestões
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Adicione a lógica para editar o evento aqui
          print('Editar evento');
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.edit),
      ),
    );
  }

  // Método para formatar a data
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  // Método para formatar a hora
  String _formatTime(DateTime time) {
    return '${time.hour}:${time.minute}';
  }

  // Método para construir a lista de sugestões
  Widget _buildSuggestionsList() {
    // Aqui você pode implementar a lógica para buscar e exibir as sugestões do backend
    return ListView(
      children: [
        ListTile(
          title: Text('Sugestão 1'),
          subtitle: Text('Descrição da Sugestão 1'),
        ),
        ListTile(
          title: Text('Sugestão 2'),
          subtitle: Text('Descrição da Sugestão 2'),
        ),
        // Adicione mais sugestões conforme necessário
      ],
    );
  }
}
