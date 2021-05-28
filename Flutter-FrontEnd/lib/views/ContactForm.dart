import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import '../models/ContactData.dart';
import '../services/ContactService.dart';

class ContactForm extends StatefulWidget {
  final int contactID;
  ContactForm({this.contactID});
  _ContactFormState createState() => new _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final ContactService contactService = new ContactService();
  bool get isEditing => widget.contactID != null;

  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      contactService.getContact(widget.contactID).then((contact) {
        _firstnameController.text = contact.firstname;
        _lastnameController.text = contact.lastname;
        _phoneController.text = contact.phone;
        _emailController.text = contact.email;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(isEditing ? 'Edit' : 'Add contact',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600)),
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(isEditing ? Icons.save : Icons.person_add,
                  color: Colors.white),
              label: Text(isEditing ? "SAVE" : "ADD",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  final contact = ContactData(
                      firstname: _firstnameController.text,
                      lastname: _lastnameController.text,
                      phone: _phoneController.text,
                      email: _emailController.text);
                  if (isEditing) {
                    contactService
                        .updateContact(widget.contactID, contact)
                        .then((result) {
                      Navigator.of(context).pop(result);
                    });
                  } else {
                    contactService.createContact(contact).then((result) {
                      Navigator.of(context).pop(result);
                    });
                  }
                }
              },
            )
          ],
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 25,
                    ),
                    backgroundColor: Colors.blue,
                    radius: 60,
                  ),
                  SizedBox(height: 15),
                  _buildFirstName(),
                  SizedBox(height: 10),
                  _buildLastName(),
                  SizedBox(height: 10),
                  _buildPhoneNumber(),
                  SizedBox(height: 10),
                  _buildEmail(),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildFirstName() {
    return TextFormField(
      controller: _firstnameController,
      maxLength: 12,
      decoration: InputDecoration(
        hintText: 'Name',
        prefixIcon: Icon(Icons.person),
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Invalid name';
        }
        return null;
      },
    );
  }

  Widget _buildLastName() {
    return TextFormField(
      controller: _lastnameController,
      maxLength: 12,
      decoration: InputDecoration(
        hintText: 'Surname',
        prefixIcon: Icon(Icons.person),
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Invalid surname';
        }
        return null;
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      controller: _phoneController,
      maxLength: 10,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: 'Telephone number',
        prefixIcon: Icon(Icons.phone),
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Invalid telephone number';
        }
        return null;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      controller: _emailController,
      maxLength: 25,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email',
        prefixIcon: Icon(Icons.email),
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      validator: (String value) {
        final bool isValid = EmailValidator.validate(value);
        if (!isValid) {
          return 'Invalid email';
        }
        return null;
      },
    );
  }
}
