class ApiUser {
  String? id;
  String? firstName;
  String? lastName;
  String? email;

  ApiUser({
    required this.id, required this.firstName, required this.lastName, required this.email,
});

  ApiUser.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
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

abstract class UserApiResult {}

class UserApiResultSuccess extends UserApiResult {
  final ApiUsersList apiUsersList;
  UserApiResultSuccess(this.apiUsersList);
}

class UserApiResultFailure extends UserApiResult {
  final String error;
  UserApiResultFailure(this.error);
}

class UserApiResultLoading extends UserApiResult {
  UserApiResultLoading();
}