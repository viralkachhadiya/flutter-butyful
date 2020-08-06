class User {
  String username;
  String password;
  String isadmin;
  List permission;

  User({this.username, this.password, this.isadmin, this.permission});

  Map tojson() {
    return {
      "username": this.username,
      "password": this.password,
    };
  }

  Map toJson() {
    return {
      "username": this.username,
      "password": this.password,
      "isadmin": isadmin,
      "Permission": permission
    };
  }
}
