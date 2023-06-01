class ApiUser {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;

  ApiUser({
    required this.id, required this.firstName, required this.lastName, required this.email, required this.password
});

  ApiUser.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    // password = json['password'];
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      // 'password': password,
    };
  }
}

class ApiUsersList {
  final List<ApiUser> apiUsers = [];

  ApiUsersList.fromJson(List<dynamic>jsonItems) {
    for (var jsonItem in jsonItems) {
      apiUsers.add(ApiUser.fromJson(jsonItem));
    }
  }
}
