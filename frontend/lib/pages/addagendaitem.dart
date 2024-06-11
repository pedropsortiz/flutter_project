import 'package:flutter/material.dart';

class AddAgendaItemPage extends StatefulWidget {
  const AddAgendaItemPage({super.key});

  @override
  State<AddAgendaItemPage> createState() => _AddAgendaItemPageState();
}

class _AddAgendaItemPageState extends State<AddAgendaItemPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  Color _selectedColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Evento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Data'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a data';
                  }
                  return null;
                },
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      _dateController.text =
                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                    });
                  }
                },
              ),
              TextFormField(
                controller: _startTimeController,
                decoration: InputDecoration(labelText: 'Hora de Início'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a hora de início';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _endTimeController,
                decoration: InputDecoration(labelText: 'Hora de Término'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a hora de término';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Cor do Evento:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              DropdownButton<Color>(
                value: _selectedColor,
                items: <Color>[Colors.blue, Colors.green, Colors.red, Colors.orange, Colors.purple, Colors.brown]
                    .map((Color color) {
                  return DropdownMenuItem<Color>(
                    value: color,
                    child: Container(
                      width: 100,
                      height: 20,
                      color: color,
                    ),
                  );
                }).toList(),
                onChanged: (Color? newColor) {
                  setState(() {
                    _selectedColor = newColor!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Adicionar lógica para salvar o evento
                    print('Evento adicionado');
                    Navigator.pop(context);
                  }
                },
                child: Text('Adicionar Evento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
