import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_with_flutter/constants.dart';
import 'package:hive_with_flutter/models/contact.dart';

class NewContactForm extends StatefulWidget {
  const NewContactForm({Key? key}) : super(key: key);

  @override
  _NewContactFormState createState() => _NewContactFormState();
}

class _NewContactFormState extends State<NewContactForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _age = '';

  /// add contact to hive db
  void addContact(Contact contact) {
    print('name is ${contact.name} , age is ${contact.age} ');
    final contactBox = Hive.box(Constants.contactBoxName);
    contactBox.add(contact);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    onChanged: (val) {
                      setState(() {
                        _name = val;
                      });
                    },
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Age'),
                      onChanged: (value) {
                        setState(() {
                          _age = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
                onPressed: () {
                  //   _formKey.currentState.save();
                  final newContact =
                      Contact(_name.toString(), int.parse(_age.toString()));
                  addContact(newContact);
                },
                child: Text('Add new Contact'))
          ],
        ));
  }
}
