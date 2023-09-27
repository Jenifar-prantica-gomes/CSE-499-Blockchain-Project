class Customer_UserModel {
  String? uid;
  String? email;
  String? userName;

  Customer_UserModel({this.uid, this.email, this.userName});

  // receiving data from server
  factory Customer_UserModel.fromMap(map) {
    return Customer_UserModel(
      uid: map['uid'],
      email: map['email'],
      userName: map['userName'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'userName': userName,
    };
  }
}
// class UserModel {
//   String? uid;
//   String? email;
//   String? usernamer;
//
//   UserModel({this.email, this.uid, this.usernamer});
//
//   // receiving data from server
//   factory UserModel.fromMap(map) {
//     return UserModel(
//       uid: map['uid'],
//       usernamer: map['userName'],
//       email: map['email'],
//     );
//   }
//
//   //sending data to our server
//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'userName': usernamer,
//       'email': email,
//     };
//   }
// }
