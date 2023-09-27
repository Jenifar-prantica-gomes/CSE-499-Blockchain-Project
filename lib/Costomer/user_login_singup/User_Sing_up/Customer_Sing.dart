import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cse499_project/Costomer/user_login_singup/model.dart';
import 'package:cse499_project/Costomer/user_scanner_button/Scanner_button_user_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Customer_SingUpPage extends StatefulWidget {
  const Customer_SingUpPage({Key? key}) : super(key: key);

  @override
  State<Customer_SingUpPage> createState() => _Customer_SingUpPageState();
}

class _Customer_SingUpPageState extends State<Customer_SingUpPage> {
  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  final _formkey = GlobalKey<FormState>();
  final EmailControllerCustomerSign = TextEditingController();
  final UsernameControllerCustomerSign = TextEditingController();
  final PasswordControllerCustomerSign = TextEditingController();
  final RePasswordControllerCustomerSign = TextEditingController();
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
                'Customer Sign',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                autofocus: false,
                controller: EmailControllerCustomerSign,
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
                  EmailControllerCustomerSign.text = value!;
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
                controller: UsernameControllerCustomerSign,
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
                  UsernameControllerCustomerSign.text = value!;
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
                controller: PasswordControllerCustomerSign,
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
                  PasswordControllerCustomerSign.text = value!;
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
                controller: RePasswordControllerCustomerSign,
                validator: (value) {
                  if (RePasswordControllerCustomerSign.text !=
                      PasswordControllerCustomerSign.text) {
                    return "Password don't match";
                  }
                  return null;
                },
                onSaved: (value) {
                  RePasswordControllerCustomerSign.text = value!;
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
                  singUp(EmailControllerCustomerSign.text,
                      PasswordControllerCustomerSign.text);
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
    Customer_UserModel userModel = Customer_UserModel();
    //writing all the value
    userModel.email = user!.email;
    userModel.userName = UsernameControllerCustomerSign.text;
    userModel.uid = user.uid;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "...Account created successfully...");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => Customer_Scanner_button()),
        (route) => false);
  }
}
