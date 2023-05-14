import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fintech_assignment/constant,.dart';
import 'package:fintech_assignment/model/user_model.dart';
import 'package:fintech_assignment/view/home_acreen.dart';
import 'package:fintech_assignment/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  final db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  String UserId = "";

  User? get user => _user;

  bool startQuiz = false;
  int currentQuestionIndex = 0;
  Timer? timer;
  int countdown = 15;
  int selectedOption = 5;
  int previousScore = 0;
  int totalScore = 0;
  String selectedString = '';

  void restartQuiz(BuildContext context) {
    currentQuestionIndex = 0;
    countdown = 15;
    totalScore = 0;
    selectedOption = 5;
    startTimer(context);
  }

  void startTimer(BuildContext context) {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (countdown == 0) {
        timer.cancel();
        nextQuestion(context);
      } else {
        countdown--;
        notifyListeners();
      }
    });
  }

  void nextQuestion(BuildContext context) {
    print("userId ${_user!.email}");
    print("userId ${_user!.uid}");

    for (int i = 0;
        i < questions[currentQuestionIndex]["options"].length;
        i++) {
      if (questions[currentQuestionIndex]["options"][i] == selectedString) {
        if (i == questions[currentQuestionIndex]["answer"]) {
          totalScore++;
          print("total score  $totalScore");
        }
      }
    }

    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      countdown = 15;
      selectedOption = 5;
      startTimer(context);
    } else {
      // Quiz ended
      update();
      startQuiz = false;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Quiz Ended'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('You have answered all the questions.'),
                Text("Your total Score is $totalScore")
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    notifyListeners();
  }

  createUser(UserModel user) async {
    await db.collection("users").add(user.toJson()).whenComplete(() {
      BuildToast("Sucessfully added");
    }).catchError((error, stackTree) {
      BuildToast(error);
    });
  }

  Future<void> signUp(String email, String password, context) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        _user = userCredential.user;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomePage();
        }));

        BuildToast("User registered: ${_user!.email}");
        UserModel userModel =
            UserModel(email: email, password: password, score: 0);

        createUser(userModel);

        notifyListeners();
      }
    } catch (e) {
      print('Signup Error: $e');
      BuildToast("Signup Error: $e");
    }
  }

  Future<void> login(String email, String password, context) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        _user = userCredential.user;
        print('User logged in: ${_user!.email}');
        BuildToast('User logged in: ${_user!.email}');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomePage();
        }));
        notifyListeners();
      }
    } catch (e) {
      print('Login Error: $e');
      BuildToast("Login Error: $e");
    }
  }

  void logout(context) {
    _auth.signOut();
    _user = null;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }));
    notifyListeners();
  }

  void serchId(String userEmail) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      // User found
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        print('User ID: ${doc.id}');
        print('Email: ${doc['email']}');
        print('score: ${doc['score']}');
        UserId = doc.id;
        previousScore = doc['score'];
        notifyListeners();
      }
    } else {
      // User not found
      print('User not found!');
    }
  }

  void Quiz(BuildContext context) {
    currentQuestionIndex = 0;
    countdown = 15;
    totalScore = 0;
    selectedOption = 5;
    startQuiz = true;
    startTimer(context);
    notifyListeners();
  }

  void update() async {
    print("userId == $UserId");
    DocumentReference userReference =
        FirebaseFirestore.instance.collection('users').doc(UserId);
    DocumentSnapshot documentSnapshot = await userReference.get();

    try {
      // ignore: empty_statements

      DocumentSnapshot documentSnapshot = await userReference.get();
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      if (documentSnapshot.exists) {
        previousScore = data['score'];
        print('Username: $previousScore');
        notifyListeners();
      } else {
        print('User document does not exist!');
      }

      await userReference.update({'score': totalScore});
      print('Username updated successfully!');
    } catch (e) {
      print('Error updating username: $e');
    }
  }

  void addTotal() {
    totalScore++;
  }

  void setOptionString(String str) {
    selectedString = str;
  }
}
