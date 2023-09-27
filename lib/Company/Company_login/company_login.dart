//import 'package:cse499_project/Company/Company_Sing_up/SingUpPage.dart';
import 'package:cse499_project/Company/Company_Sing_up/comapany_sign_up.dart';
import 'package:cse499_project/Company/approved_list_button/approved/approvedORdecline.dart';
import 'package:cse499_project/Company/approved_list_button/approved_list.dart';
import 'package:cse499_project/Company/profile_company_user/Profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Company_log_in_page extends StatefulWidget {
  const Company_log_in_page({Key? key}) : super(key: key);

  @override
  State<Company_log_in_page> createState() => _Company_log_in_pageState();
}

class _Company_log_in_pageState extends State<Company_log_in_page> {
  final _fireAuth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  final EmailControllerCompanylogin = TextEditingController();
  final PasswordControllerCompanylogin = TextEditingController();
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Company Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 32.0),
              TextFormField(
                autofocus: false,
                keyboardType: TextInputType.emailAddress,
                controller: EmailControllerCompanylogin,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Your Email';
                  }
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return ("Please Enter a valid email");
                  }
                  return null;
                },
                onSaved: (value) {
                  EmailControllerCompanylogin.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  hintText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                autofocus: false,
                controller: PasswordControllerCompanylogin,
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
                  PasswordControllerCompanylogin.text = value!;
                },
                textInputAction: TextInputAction.done,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key),
                  hintText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  singIn(EmailControllerCompanylogin.text,
                      PasswordControllerCompanylogin.text);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => Approved_list_button()));
                },
                child: Text('Login'),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Do not have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Company_sign_up_page()));
                    },
                    child: Text(
                      "Sing Up",
                      style: TextStyle(
                          color: Colors.cyan, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  } //login function

  void singIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _fireAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Approved_list_button())),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
