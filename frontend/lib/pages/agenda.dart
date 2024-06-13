import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';

class Agenda extends StatefulWidget {
  const Agenda({super.key});

  @override
  State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  final EventController _eventController = EventController();
  String _selectedView = 'Dia';

  @override
  void initState() {
    super.initState();
    _eventController.addAll(_events);
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  Widget _getCalendarView() {
    switch (_selectedView) {
      case 'Dia':
        return DayView(
          controller: _eventController,
          onEventTap: (events, date) {
            Navigator.pushNamed(
              context,
              '/home/agenda/item',
              arguments: {
                "title": events[0].title,
                "description": events[0].description,
                "date": events[0].date,
                "startTime": events[0].startTime,
                "endTime": events[0].endTime,
                "color": events[0].color,
              },
            );
          },
        );
      case 'Semana':
        return WeekView(
          controller: _eventController,
          onEventTap: (events, date) {
            Navigator.pushNamed(
              context,
              '/home/agenda/item',
              arguments: {
                "title": events[0].title,
                "description": events[0].description,
                "date": events[0].date,
                "startTime": events[0].startTime,
                "endTime": events[0].endTime,
                "color": events[0].color,
              },
            );
          },
        );
      default:
        return MonthView(
          controller: _eventController,
          onEventTap: (events, date) {
            Navigator.pushNamed(
              context,
              '/home/agenda/item',
            );
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Agenda'),
        backgroundColor: Colors.blue[900],
        automaticallyImplyLeading: false,
        actions: [
          DropdownButton<String>(
            value: _selectedView,
            dropdownColor: Colors.blue[900],
            onChanged: (String? newValue) {
              setState(() {
                _selectedView = newValue!;
              });
            },
            items: <String>['Dia', 'Semana', 'Mês'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            }).toList(),
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, size: 30),
            onPressed: () {
              Navigator.pushNamed(context, '/home/profile');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _showLogoutDialog(context); // Abrir o popup de logout
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _getCalendarView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/home/agenda/add');
        },
        backgroundColor: Colors.blue[900],
        child: const Icon(Icons.add),
      ),
    );
  }
}

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Sair da Conta'),
        content: Text('Tem certeza que deseja sair da sua conta?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fechar o popup
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // Adicione a lógica para sair da conta aqui
              Navigator.of(context).pop(); // Fechar o popup
            },
            child: Text('Confirmar'),
          ),
        ],
      );
    },
  );
}

final List<CalendarEventData> _events = [
  CalendarEventData(
    date: DateTime.now(),
    title: "Reunião de Projeto",
    description: "Hoje é a reunião de projeto.",
    startTime: DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 18, 30),
    endTime: DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 22),
    color: Colors.blue,
  ),
  CalendarEventData(
    date: DateTime.now().add(Duration(days: 1)),
    startTime: DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 18),
    endTime: DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 19),
    title: "Aniversário de Casamento",
    description: "Participar do aniversário de casamento do tio.",
    color: Colors.green,
  ),
  CalendarEventData(
    date: DateTime.now(),
    startTime: DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 14),
    endTime: DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 17),
    title: "Torneio de Futebol",
    description: "Ir ao torneio de futebol.",
    color: Colors.red,
  ),
  CalendarEventData(
    date: DateTime.now().add(Duration(days: 3)),
    startTime: DateTime(
        DateTime.now().add(Duration(days: 3)).year,
        DateTime.now().add(Duration(days: 3)).month,
        DateTime.now().add(Duration(days: 3)).day,
        10),
    endTime: DateTime(
        DateTime.now().add(Duration(days: 3)).year,
        DateTime.now().add(Duration(days: 3)).month,
        DateTime.now().add(Duration(days: 3)).day,
        14),
    title: "Reunião de Sprint",
    description: "Último dia de entrega do projeto do ano passado.",
    color: Colors.orange,
  ),
  CalendarEventData(
    date: DateTime.now().subtract(Duration(days: 2)),
    startTime: DateTime(
        DateTime.now().subtract(Duration(days: 2)).year,
        DateTime.now().subtract(Duration(days: 2)).month,
        DateTime.now().subtract(Duration(days: 2)).day,
        14),
    endTime: DateTime(
        DateTime.now().subtract(Duration(days: 2)).year,
        DateTime.now().subtract(Duration(days: 2)).month,
        DateTime.now().subtract(Duration(days: 2)).day,
        16),
    title: "Reunião de Equipe",
    description: "Reunião de Equipe",
    color: Colors.purple,
  ),
  CalendarEventData(
    date: DateTime.now().subtract(Duration(days: 2)),
    startTime: DateTime(
        DateTime.now().subtract(Duration(days: 2)).year,
        DateTime.now().subtract(Duration(days: 2)).month,
        DateTime.now().subtract(Duration(days: 2)).day,
        10),
    endTime: DateTime(
        DateTime.now().subtract(Duration(days: 2)).year,
        DateTime.now().subtract(Duration(days: 2)).month,
        DateTime.now().subtract(Duration(days: 2)).day,
        12),
    title: "Viva de Química",
    description: "Hoje é o aniversário do Joe.",
    color: Colors.brown,
  ),
];
