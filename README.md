# Flutter Firestore Crud Page


One of the most common tasks in flutter is displaying a list of items, and providing ways to add, edit and delete the items. 

This repository demonstrates practices for integrating firestore with flutter with abstractions that allow the UI to be used with different firestore collections or data sources other than firestore if desired. 

To be as modular as possible, all the elements will be wrapped into a folder under `modules`. The term modules was used rather than pages, screens, features etc to allow for various types of components be they full screens, popups, or interstitial elements. Also the imports will use relative format `../../` to facilitate copying the folder into another project.  



## Instructions

1. Create your flutter project
2. Use the [flutterfire cli](https://firebase.flutter.dev/docs/cli/) to configure firebase on your app. 
   `flutterfire configure`
   
3. Add dependencies to pubspec.yaml
    ```
    firebase_core: ^1.6.0
    cloud_firestore: ^2.5.1 
    ```

4. Import the config and firebase in main.dart
   ```
   import 'firebase_options.dart';
   import 'package:firebase_core/firebase_core.dart';
   ``` 

5. Add initialize app to App definition
    ```
    void main() async {
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
        );
        runApp(MyApp());
    }
     ```
 


## Notes

**person.dart**
- Allows blank values
- Include an ID field which duplicates DocumentID for ease of use
- Prefer creating ID here vs using AutoID in Firestore
- If ID is not provided it creates one

**people_repo_firestore.dart**
- Encapsulates all Firestore dependencies, other files need not know about Firestore
- Returns a standard Stream<Person>
- delete and upsert functions can be passed into other widgets as callbacks, again so those classes don't need to know about firestore
- upsert() method can be used for updates or inserts

**people_list_screen.dart**
- Uses standard StreamBuilder which can be used with any repository
- Instantiates PeopleRepositoryFirestore in build
- List items are instances of PeopleCard

**people_card.dart**
- PersonCard requires a person and a deleteCallBack method
- Uses Dismissible to delete the item

**person_form_screen.dart**
- Works for add or edit
- Takes an optional Person object in the constructor
- Build method determines add or edit mode based on existence of Person
- Creates an empty person if in Add mode
- Form fields directly update Person object on change using onChanged()
