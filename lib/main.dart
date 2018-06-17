import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Input Boxes",
      theme: ThemeData(
        primarySwatch: Colors.indigo
      ),
      home: InputBox(),
    );
  }
}

class InputBox extends StatefulWidget
{
  @override
  State createState() => InputBoxState();
}

class InputBoxState extends State<InputBox>
{
  bool loggedIn = false;
  String _email, _username, _password;

  final formKey = GlobalKey<FormState>();
  final mainKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //KEYS ARE VERY IMPORTANT
      key: mainKey,
      appBar: AppBar(title: Text("Form Example :D"),),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: loggedIn == false ? Form(
          //ANOTHER KEY
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: "Email:"
                ),
                validator: (str) =>
                !str.contains("@") ? "Not a valid email, check it out" : null,
                onSaved: (str) => _email = str,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(
                    labelText: "Username:"
                ),
                validator: (str) =>
                str.length < 5 ? "You must to use 5 character for min" : null,
                onSaved: (str) => _username = str,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(
                    labelText: "Password:"
                ),
                validator: (str) =>
                str.length < 7 ? "Not a valid password" : null,
                onSaved: (str) => _password = str,
                obscureText: true,
              ),
              RaisedButton(
                child: Text("Submit"),
                onPressed: onPresed,
              ),
            ],
          ),
        ): Center(
          child: Column(
            children: <Widget>[
              Text("Welcome $_username ! Do you feeling lucky?"),
              RaisedButton(
                child: Text("Log out"),
                onPressed: (){
                  setState(() {
                    loggedIn = false;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void onPresed()
  {
    var form = formKey.currentState;
    if(form.validate())
    {
      form.save();
      setState(() {
        loggedIn = true;
      });

      var snackbar = SnackBar(
        content: Text("Username: $_username, Email: $_email, Password: $_password"),
        duration: Duration(milliseconds: 5000),
      );

      mainKey.currentState.showSnackBar(snackbar);

    }
  }

}