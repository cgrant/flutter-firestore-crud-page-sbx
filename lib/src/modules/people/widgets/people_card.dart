import 'package:crud/src/modules/people/widgets/person_form_screen.dart';
import 'package:flutter/material.dart';

import '../models/person.dart';

class PersonCard extends StatelessWidget {
  final Person person;
  final Function deleteCallBack;

  const PersonCard(this.person, this.deleteCallBack);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(person.id!),
        background: Container(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: const [
                Icon(Icons.delete, color: Colors.black54),
                Text('Delete'),
              ],
            ),
          ),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Icon(Icons.delete, color: Colors.black54),
                Text('Delete'),
              ],
            ),
          ),
        ),
        onDismissed: (DismissDirection) => deleteCallBack(person.id),
        child: ListTile(
          title: Text(person.fname),
          trailing: IconButton(
            icon: const Icon(Icons.edit_outlined), // edit a movie
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PersonForm(person: person),
                ),
              );
            },
          ),
        ),
        confirmDismiss: (DismissDirection direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Delete Confirmation"),
                content:
                    const Text("Are you sure you want to delete this item?"),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Delete"),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ],
              );
            },
          );
        });
  }
}
