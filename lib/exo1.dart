import 'package:flutter/material.dart';

class Exo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exo 1 - Afficher une image')),
      body: Center(
        child: Image.network(
          'https://picsum.photos/512/1024',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}