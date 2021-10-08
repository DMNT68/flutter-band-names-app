import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:band_names/models/band.dart';

class HomePage extends StatelessWidget {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 25),
    Band(id: '2', name: 'Megadeth', votes: 30),
    Band(id: '3', name: 'Foo Fighters', votes: 25),
    Band(id: '4', name: 'Nirvana', votes: 20),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Band Names', style: TextStyle(color: Colors.black87),),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => _bandTile(bands[i])
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        elevation: 1,
        onPressed: ()=> addNewBand(context),
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('direction: $direction');
        print('id: ${band.id}');
        // TODD: llamar borrado en el server
      },
      background: Container(
        padding: const EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete Band', style: TextStyle(color: Colors.white),)
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0,2).toUpperCase()),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text('${band.votes}', style: const TextStyle(fontSize: 20),),
        onTap: (){
          print(band.name);
        },
      ),
    );
  }

  addNewBand (BuildContext context) {

    final textController = TextEditingController();

    // if(Platform.isAndroid) {
    //   showDialog(
    //     context: context, 
    //     builder: (context) {
    //       return AlertDialog(
    //         title: const Text('New band name:'),
    //         content: TextField(
    //           controller: textController,
    //         ),
    //         actions: [
    //           MaterialButton(
    //             child: const Text('Add'),
    //             elevation: 5,
    //             textColor: Colors.blue,
    //             onPressed: ()=>addBandToList(textController.text, context)
    //           )
    //         ],
    //       );
    //     },
    //   );
    // } 

    showCupertinoDialog(
      context: context, 
      builder: (_) =>  CupertinoAlertDialog(
        title: const Text('New band name'),
        content: CupertinoTextField(
          controller: textController,
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Add'),
            onPressed: ()=>addBandToList(textController.text, context)
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Dismiss'),
            onPressed: () => Navigator.pop(context)
          )
        ],
      ),
    );
   
  }

  void addBandToList (String name, BuildContext context) {
    if(name.length > 1) {
      bands.add(Band(id: DateTime.now().toString(), name: name, votes: 0));
    }
    Navigator.pop(context);
  }
}

