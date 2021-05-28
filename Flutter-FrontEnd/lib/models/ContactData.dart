import 'package:flutter/foundation.dart';

class ContactData {
  String firstname;
  String lastname;
  String phone;
  String email;

  ContactData({
    @required this.firstname,
    @required this.lastname,
    @required this.phone,
    @required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      "FirstName": firstname,
      "LastName": lastname,
      "Phone": phone,
      "Email": email
    };
  }
}
