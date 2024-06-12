import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _treatmentForm = 0;
  int _responseStyle = 0;
  int _elaborationLevel = 0;
  String _preferredLanguage = 'pt-BR';

  void _savePreferences() {
    // Implemente a lógica para salvar as preferências do usuário aqui
    print('Preferências salvas!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Perfil'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Forma de tratamento preferida:',
              style: TextStyle(fontSize: 18),
            ),
            DropdownButton<int>(
              value: _treatmentForm,
              items: [
                DropdownMenuItem<int>(
                  value: 0,
                  child: Text('Informal'),
                ),
                DropdownMenuItem<int>(
                  value: 1,
                  child: Text('Formal'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _treatmentForm = value!;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Estilo de resposta preferido:',
              style: TextStyle(fontSize: 18),
            ),
            DropdownButton<int>(
              value: _responseStyle,
              items: [
                DropdownMenuItem<int>(
                  value: 0,
                  child: Text('Conciso'),
                ),
                DropdownMenuItem<int>(
                  value: 1,
                  child: Text('Detalhado'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _responseStyle = value!;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Nível de elaboração nas respostas:',
              style: TextStyle(fontSize: 18),
            ),
            DropdownButton<int>(
              value: _elaborationLevel,
              items: [
                DropdownMenuItem<int>(
                  value: 0,
                  child: Text('Básico'),
                ),
                DropdownMenuItem<int>(
                  value: 1,
                  child: Text('Intermediário'),
                ),
                DropdownMenuItem<int>(
                  value: 2,
                  child: Text('Avançado'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _elaborationLevel = value!;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Língua preferida para as respostas:',
              style: TextStyle(fontSize: 18),
            ),
            DropdownButton<String>(
              value: _preferredLanguage,
              items: [
                DropdownMenuItem<String>(
                  value: 'pt-BR',
                  child: Text('Português (Brasil)'),
                ),
                DropdownMenuItem<String>(
                  value: 'en-US',
                  child: Text('English (United States)'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _preferredLanguage = value!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _savePreferences,
              child: Text('Salvar Preferências'),
            ),
          ],
        ),
      ),
    );
  }
}
