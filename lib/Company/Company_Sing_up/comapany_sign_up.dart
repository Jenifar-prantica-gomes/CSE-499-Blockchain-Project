import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cse499_project/Company/approved_list_button/approved_list.dart';
import 'package:cse499_project/Company/company_model/user_company_model.dart';
import 'package:cse499_project/Company/profile_company_user/Profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Company_sign_up_page extends StatefulWidget {
  const Company_sign_up_page({Key? key}) : super(key: key);

  @override
  State<Company_sign_up_page> createState() => _Company_sign_up_pageState();
}

class _Company_sign_up_pageState extends State<Company_sign_up_page> {
  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  final _formkey = GlobalKey<FormState>();
  final EmailControllerCompanySign = TextEditingController();
  final UsernameControllerCompanySign = TextEditingController();
  final PasswordControllerCompanySign = TextEditingController();
  final RePasswordControllerCompanySign = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Company Sign',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                autofocus: false,
                controller: EmailControllerCompanySign,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter your Email";
                  }
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
                onSaved: (value) {
                  EmailControllerCompanySign.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                autofocus: false,
                controller: UsernameControllerCompanySign,
                keyboardType: TextInputType.name,
                validator: (value) {
                  RegExp regex = new RegExp(r'^.{3,}$');
                  if (value!.isEmpty) {
                    return "useername can not be empty";
                  }
                  if (!regex.hasMatch(value)) {
                    return "Enter Valid name(Min. 3 Character)";
                  }
                  return null;
                },
                onSaved: (value) {
                  UsernameControllerCompanySign.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                obscureText: true,
                controller: PasswordControllerCompanySign,
                validator: (value) {
                  RegExp regex = new RegExp(r'^.{6,}$');
                  if (value!.isEmpty) {
                    return ("Password is required for login");
                  }
                  if (!regex.hasMatch(value)) {
                    return ("Enter Valid Password(Min. 6 Character)");
                  }
                },
                onSaved: (value) {
                  PasswordControllerCompanySign.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                autofocus: false,
                obscureText: true,
                controller: RePasswordControllerCompanySign,
                validator: (value) {
                  if (RePasswordControllerCompanySign.text !=
                      PasswordControllerCompanySign.text) {
                    return "Password don't match";
                  }
                  return null;
                },
                onSaved: (value) {
                  RePasswordControllerCompanySign.text = value!;
                },
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: 'Re-Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  singUp(EmailControllerCompanySign.text,
                      PasswordControllerCompanySign.text);
                },
                child: Text('Sing In'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void singUp(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    //calling firestore
    //calling userModel
    //sending this value
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    //writing all the value
    userModel.email = user!.email;
    userModel.userName = UsernameControllerCompanySign.text;
    userModel.uid = user.uid;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "...Account created successfully...");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => Approved_list_button()),
        (route) => false);
  }
}
