import 'package:flutter/material.dart';
import 'exo1.dart'; 
import 'exo2.dart';
import 'exo4.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TP Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MenuPage(),
    );
  }
}


class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu')),
      body: ListView(
        children: [
          Card(
            elevation: 5,
            child: ListTile(
              title: Text('Exercice 1'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Exo1()),
                );
              },
            ),
          ),
          Card(
            elevation: 5,
            child: ListTile(
              title: Text('Exercice 2'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Exo2()),
                );
              },
            ),
          ),
          Card(
            elevation: 5,
            child: ListTile(
              title: Text('Exercice 4'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DisplayTileWidget()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}