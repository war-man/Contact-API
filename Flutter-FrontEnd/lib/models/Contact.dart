class Contact {
  final int id;
  final String firstname;
  final String lastname;
  final String phone;
  final String email;
  final bool favorite;
  final bool deleted;

  Contact(
      {this.id,
      this.firstname,
      this.lastname,
      this.phone,
      this.email,
      this.favorite,
      this.deleted});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
        id: json['ContactId'],
        firstname: json['FirstName'],
        lastname: json['LastName'],
        phone: json['Phone'],
        email: json['Email'],
        favorite: json['IsFavorite'],
        deleted: json['IsDeleted']);
  }
}
