import 'package:daily_amajo/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:daily_amajo/services/auth.dart';
import 'package:daily_amajo/widgets/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String registerUserName = '';
  String registerEmail = '';
  String registerPassword = '';
  String registerPasswordValidate = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.amber[100],
            appBar: AppBar(
              backgroundColor: Colors.amber[400],
              elevation: 0.0,
              title: Text("Register"),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.settings_input_antenna),
                  label: Text("Sign in"),
                  onPressed: () {
                    //refers to stateful widget
                    widget.toggleView();
                  },
                )
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: "User Name"),
                        validator: (val) =>
                            val.isEmpty ? "User Name" : null,
                        onChanged: (val) {
                          setState(() => registerUserName = val);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: "Email"),
                        validator: (val) =>
                            val.isEmpty ? "Enter an email" : null,
                        onChanged: (val) {
                          setState(() => registerEmail = val);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: "Password"),
                        obscureText: true,
                        validator: (val) => val.length < 8
                            ? "Needs to be more than 8 characters"
                            : null,
                        onChanged: (val) {
                          setState(() => registerPassword = val);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: "Password Check"),
                        obscureText: true,
                        validator: (val) =>
                            val != registerPassword ? "Does not sync!" : null,
                        onChanged: (val) {
                          setState(() => registerPasswordValidate = val);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        color: Colors.blue,
                        child: Text("Register"),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result =
                                await _auth.registerWithEmailAndPassword(
                                    registerUserName, registerEmail, registerPassword);
                            if (result == null) {
                              setState(() {
                                error = "there was an error";
                                loading = true;
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                )),
          );
  }
}
