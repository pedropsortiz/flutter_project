import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';

class Agenda extends StatefulWidget {
  const Agenda({super.key});

  @override
  State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  final EventController _eventController = EventController();
  String _selectedView = 'Day';

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
      case 'Day':
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
      case 'Week':
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
        leading: IconButton(
          icon: const Icon(Icons.account_circle, size: 30),
          onPressed: () {
            Navigator.pushNamed(context, '/home/profile');
          },
        ),
        actions: [
          DropdownButton<String>(
            value: _selectedView,
            icon: const Icon(Icons.calendar_view_day, color: Colors.white),
            dropdownColor: Colors.blue[900],
            items: <String>['Month', 'Week', 'Day'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: Colors.white)),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedView = newValue!;
              });
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

final List<CalendarEventData> _events = [
  CalendarEventData(
    date: DateTime.now(),
    title: "Project meeting",
    description: "Today is project meeting.",
    startTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 18, 30),
    endTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 22),
    color: Colors.blue,
  ),
  CalendarEventData(
    date: DateTime.now().add(Duration(days: 1)),
    startTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 18),
    endTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 19),
    title: "Wedding anniversary",
    description: "Attend uncle's wedding anniversary.",
    color: Colors.green,
  ),
  CalendarEventData(
    date: DateTime.now(),
    startTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 14),
    endTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 17),
    title: "Football Tournament",
    description: "Go to football tournament.",
    color: Colors.red,
  ),
  CalendarEventData(
    date: DateTime.now().add(Duration(days: 3)),
    startTime: DateTime(DateTime.now().add(Duration(days: 3)).year,
        DateTime.now().add(Duration(days: 3)).month, DateTime.now().add(Duration(days: 3)).day, 10),
    endTime: DateTime(DateTime.now().add(Duration(days: 3)).year,
        DateTime.now().add(Duration(days: 3)).month, DateTime.now().add(Duration(days: 3)).day, 14),
    title: "Sprint Meeting.",
    description: "Last day of project submission for last year.",
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
    title: "Team Meeting",
    description: "Team Meeting",
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
    title: "Chemistry Viva",
    description: "Today is Joe's birthday.",
    color: Colors.brown,
  ),
];
