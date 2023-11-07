//Carlos Daniel Taveras Liranzo
//2021-2021
import 'package:flutter/material.dart';

class contact extends StatefulWidget {
  const contact({super.key});

  @override
  State<contact> createState() => _contactState();
}

class _contactState extends State<contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contactame')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 2, style: BorderStyle.solid)),
              child: Image.asset('CarlosDaniel.png'),
            ),
            SizedBox(height: 16.0),
            Text('Carlos Daniel Taveras Liranzo', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black, fontWeight: FontWeight.bold)),
            SizedBox(height: 16.0),
            Text('2021-2021', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black, fontWeight: FontWeight.bold)),
            SizedBox(height: 16.0),
            Text('La guerra es un fracaso de la humanidad. La guerra es el resultado de la incapacidad de las personas para resolver sus diferencias de forma pacífica. Es la expresión de la violencia, el odio y la destrucción. La guerra siempre es una pérdida para todos, incluso para los vencedores. Deja un rastro de dolor, sufrimiento y destrucción que tarda mucho tiempo en curarse. Por ello, es importante trabajar por la paz y la resolución pacífica de los conflictos. Debemos construir un mundo en el que la guerra sea algo imposible.', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black, fontWeight: FontWeight.bold)),
          ],) 
        ),
    );
  }
}
