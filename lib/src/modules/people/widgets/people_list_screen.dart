import 'package:crud/src/modules/people/models/person.dart';
import 'package:flutter/material.dart';
import '../repositories/people_repo_firestore.dart';
import 'people_card.dart';
import 'person_form_screen.dart';

class PeopleList extends StatefulWidget {
  const PeopleList({Key? key}) : super(key: key);

  @override
  State<PeopleList> createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> {
  @override
  Widget build(BuildContext context) {
    PeopleRepositoryFirestore peopleRepo = PeopleRepositoryFirestore();

    return Scaffold(
      appBar: AppBar(title: const Text("People")),
      body: StreamBuilder<List<Person>>(
          stream: peopleRepo.getAll(),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<Person>> snapshot,
          ) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: snapshot.data!
                  .map(
                    ((Person person) => PersonCard(person, peopleRepo.delete)),
                  )
                  .toList(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PersonForm()),
          );
        },
      ),
    );
  }
}
