class User {
  int? id;
  String? firstName, lastName, cnic, email, phoneNumber;

  User({this.id, this.firstName, this.lastName, this.email, this.cnic});
  Map<String, dynamic>? toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'email': email,
        'cnic': cnic
      };
  User.fromJson(Map<String, dynamic> response)
      : id = response['id'],
        firstName = response['firstName'],
        lastName = response['lastName'],
        phoneNumber = response['phoneNumber'],
        email = response['email'],
        cnic = response['cnic'];
}
