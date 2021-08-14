import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_with_flutter/constants.dart';
import 'package:hive_with_flutter/models/contact.dart';
import 'package:hive_with_flutter/screens/new_contact_form.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: Column(
        children: [
          Expanded(child: _buildListView()),
          NewContactForm(),
        ],
      ),
    );
  }

  Widget _buildListView() {
    //   final contactsBox = Hive.box(Constants.contactBoxName);
    return ValueListenableBuilder(
      valueListenable: Hive.box(Constants.contactBoxName).listenable(),
      builder: (context, Box _box, child) {
        return ListView.builder(
            itemCount: _box.length,
            itemBuilder: (context, index) {
              final contact = _box.getAt(index) as Contact;
              return ListTile(
                title: Text(contact.name),
                subtitle: Text(contact.age.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        _box.putAt(index,
                            Contact('${contact.name}*', contact.age + 1));
                      },
                      icon: Icon(Icons.refresh),
                    ),
                    IconButton(
                      onPressed: () {
                        _box.deleteAt(index);
                      },
                      icon: Icon(Icons.delete),
                    )
                  ],
                ),
              );
            });
      },
    );
  }
}
