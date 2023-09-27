class Farmer_UserModel {
  String? uid;
  String? email;
  String? userName;

  Farmer_UserModel({this.uid, this.email, this.userName});

  // receiving data from server
  factory Farmer_UserModel.fromMap(map) {
    return Farmer_UserModel(
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
