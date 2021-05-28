import 'package:flutter/material.dart';

import '../views/ContactDetail.dart';
import '../views/ContactsList.dart';
import '../views/ContactForm.dart';

class AppRouter {
  static const MAIN = '/';
  static const ADD = '/add';
  static const DETAIL = '/detail/';
  static const EDIT = '/edit/';

  // ignore: missing_return
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouter.MAIN:
        return MaterialPageRoute(builder: (_) => ContactsList());
      case AppRouter.ADD:
        return MaterialPageRoute(builder: (_) => ContactForm());
      case AppRouter.DETAIL:
        return MaterialPageRoute(builder: (_) {
          final data = settings.arguments as ContactDetail;
          return ContactDetail(
              contactID: data.contactID, favorite: data.favorite);
        });
      case AppRouter.EDIT:
        return MaterialPageRoute(builder: (_) {
          final data = settings.arguments as ContactForm;
          return ContactForm(contactID: data.contactID);
        });
    }
  }
}
