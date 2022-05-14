import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:imageScanner/Main_page/home_screen.dart';
import 'package:imageScanner/Main_page/login_screen.dart';
import 'package:imageScanner/user/user_model.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  final userNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {


    //Username
    final userNameField = TextFormField(
      autofocus: false,
      controller: userNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value){
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("You missed a spot!Don't forget to add you username");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Atleast 3 characters");
        }
      },
      onSaved: (value){
        userNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle_outlined),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20,15),
          hintText: "Username",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          )
      ),
    );


    //Email
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Missed Here!Add your email.");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
            .hasMatch(value)) {
          return ("Hmmm....that doesn't look like an email address.");
        }
        return null;
      },
      onSaved: (value){
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20,15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          )
      ),
    );


    //Password
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator: (value){
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password Missing");
        }
        if (!regex.hasMatch(value)) {
          return ("Password Too short!!Nedd 6+ charcter");
        }
      },
      onSaved: (value){
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock_rounded),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20,15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          )
      ),
    );


    //confirm Password
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      validator: (value)
      {
        if(confirmPasswordEditingController.text != passwordEditingController.text)
          {
            return ("Password Mismatch");
          }
        return null;
      },

      onSaved: (value){
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock_rounded),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20,15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          )
      ),
    );


    //SignUp
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(40),
      color: Colors.teal,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20,15,15,15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: Text(
          "SignUp",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor:  Colors.blueGrey[200],
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white38,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: <Widget>[
                    SizedBox(
                        height: 250,
                        child: Image.asset("assets/First_page.png")
                    ),
                    userNameField,
                    SizedBox(
                      height: 12,
                    ),
                    emailField,
                    SizedBox(
                      height: 12,
                    ),
                    passwordField,
                    SizedBox(
                      height: 12,
                    ),
                    confirmPasswordField,
                    SizedBox(
                      height: 40,
                    ),
                    signUpButton,
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Already have an account?",style: TextStyle(fontSize: 16),),
                        GestureDetector(onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                        },
                            child:Text(" Log in",style: TextStyle(fontSize:20,fontWeight: FontWeight.w700,color: Colors.blue),
                            )
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate())
      {
        await _auth.createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailToFireStore()})
            .catchError((e){
              Fluttertoast.showToast(msg: e!.message);

        });
      }
  }

  postDetailToFireStore() async{
    //calling our firebase
    //calling our usermodel
    //sending these values

    FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.userName = userNameEditingController.text;

    await firebaseFirestore
    .collection("users")
    .doc(user.uid)
    .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account Created SuccessFully :)  !!! \n Login Again ");

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);


  }
}
