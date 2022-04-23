import 'package:flutter/material.dart';

import '../models/person.dart';
import '../repositories/people_repo_firestore.dart';

class PersonForm extends StatefulWidget {
  Person? person;

  PersonForm({this.person});

  @override
  _PersonFormState createState() => _PersonFormState();
}

class _PersonFormState extends State<PersonForm> {
  final _formKey = GlobalKey<FormState>(); // for form validation purposes

  @override
  Widget build(BuildContext context) {
    PeopleRepositoryFirestore peopleRepo = PeopleRepositoryFirestore();

    bool isEdit = true;
    if (widget.person == null) {
      widget.person = Person();
      isEdit = false;
    }

    return Scaffold(
        appBar: AppBar(
            title: isEdit
                ? const Text('Edit a person')
                : const Text('Add a person')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      // FIRST NAME
                      decoration: const InputDecoration(hintText: 'First Name'),
                      initialValue: isEdit ? widget.person!.fname : '',
                      onChanged: (val) => widget.person!.fname = val,
                      validator: (value) {
                        return value!.isEmpty ? 'Name can\'t be empty !' : null;
                      },
                    ),
                    TextFormField(
                      // LAST NAME
                      decoration: const InputDecoration(
                        hintText: 'Last Name',
                      ),
                      initialValue: isEdit ? widget.person!.lname : '',
                      onChanged: (val) => widget.person!.lname = val,
                    ),
                    Row(
                      children: [
                        Padding(
                          // BUTTON
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton.icon(
                            icon: Icon(isEdit ? Icons.edit : Icons.add),
                            label:
                                isEdit ? const Text('Save') : const Text('Add'),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                peopleRepo.upsert(widget.person!);

                                // Show Snackbar then go back to list screen
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                      content: Text(isEdit
                                          ? 'Edited Successfully !'
                                          : 'Added Successfully !'),
                                      duration: const Duration(seconds: 1),
                                    ))
                                    .closed
                                    .then((data) => Navigator.pop(context));
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton.icon(
                            icon: const Icon(Icons.cancel),
                            label: const Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
