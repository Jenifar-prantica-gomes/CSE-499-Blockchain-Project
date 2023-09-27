import 'package:cse499_project/Farmer/AddCrops_Verifiction/ADD_CROPS/Add_Crop.dart';
import 'package:cse499_project/Farmer/OTP/farmar_singUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Farmar_login extends StatefulWidget {
  const Farmar_login({Key? key}) : super(key: key);

  @override
  State<Farmar_login> createState() => _Farmar_loginState();
}

class _Farmar_loginState extends State<Farmar_login> {
  final _fireAuth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  final EmailControllerFarmerlogin = TextEditingController();
  final PasswordControllerFarmerlogin = TextEditingController();
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
                'Farmer Login',
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
                controller: EmailControllerFarmerlogin,
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
                  EmailControllerFarmerlogin.text = value!;
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
                controller: PasswordControllerFarmerlogin,
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
                  PasswordControllerFarmerlogin.text = value!;
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
                  singIn(EmailControllerFarmerlogin.text,
                      PasswordControllerFarmerlogin.text);
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
                              builder: (context) => Farmar_sing_up()));
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
  }

  void singIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _fireAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Farmer_AddCrops())),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
