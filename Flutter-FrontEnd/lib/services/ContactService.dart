import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/Contact.dart';
import '../models/ContactData.dart';

class ContactService {
  static const URL = '192.168.90.157:81';

  static const headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  Future<List<Contact>> getContacts() async {
    final response =
        await http.get(Uri.http(URL, '/api/contacts'), headers: headers);
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((model) => Contact.fromJson(model)).toList();
    } else {
      throw Exception("Failed to load contacts");
    }
  }

  Future<List<Contact>> getFavorites() async {
    final response = await http.get(Uri.http(URL, '/api/contacts/favorites'),
        headers: headers);
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((model) => Contact.fromJson(model)).toList();
    } else {
      throw Exception("Failed to load favorite contacts");
    }
  }

  Future<Contact> getContact(int contactID) async {
    final response = await http.get(Uri.http(URL, '/api/contacts/$contactID'),
        headers: headers);
    if (response.statusCode == 200 && jsonDecode(response.body).isNotEmpty) {
      return Contact.fromJson(jsonDecode(response.body)[0]);
    } else {
      throw Exception("Contact loading failed");
    }
  }

  Future<String> createContact(ContactData contact) async {
    final response = await http.post(Uri.http(URL, '/api/contacts'),
        headers: headers, body: json.encode(contact.toJson()));
    if (response.statusCode == 200) {
      return "Contact created successfully";
    } else {
      return "Error! Failed creation";
    }
  }

  Future<String> updateContact(int contactID, ContactData contact) async {
    final response = await http.put(Uri.http(URL, '/api/contacts/$contactID'),
        headers: headers, body: json.encode(contact.toJson()));
    if (response.statusCode == 200) {
      return "Contact updated successfully";
    } else {
      return "Error! Modification failed";
    }
  }

  Future<String> updateFavorite(int contactID) async {
    final response = await http.put(
        Uri.http(URL, '/api/contacts/favorite/$contactID'),
        headers: headers);
    if (response.statusCode == 200) {
      return "Contact updated successfully";
    } else {
      return "Error! Modification failed";
    }
  }

  Future<String> deleteContact(int contactID) async {
    final response =
        await http.delete(Uri.http(URL, '/api/contacts/$contactID'));
    if (response.statusCode == 200) {
      return "Contact successfully deleted";
    } else {
      return "Error! Deletion failed";
    }
  }
}
