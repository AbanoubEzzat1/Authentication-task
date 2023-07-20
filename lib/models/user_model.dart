class UserModel {
  String? userName;
  String? userEmail;
  String? userPassword;
  String? uId;

  UserModel({this.userName, this.userEmail, this.userPassword, this.uId});

  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    userName = json['userEmail'];
    userName = json['userPassword'];
    uId = json['uId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'userEmail': userEmail,
      'userPassword': userPassword,
      'uId': uId,
    };
  }
}
