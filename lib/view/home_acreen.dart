import 'dart:async';

import 'package:fintech_assignment/constant,.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/auth_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz app"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              authProvider.logout(context);
            },
            icon: Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: authProvider.startQuiz == false
          ? Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Score",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                      Text(
                        "${authProvider.previousScore}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      authProvider.Quiz(context);
                    },
                    child: Container(
                      color: Colors.blue,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Start Quiz",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Time Left: ${authProvider.countdown} seconds',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Q${authProvider.currentQuestionIndex + 1} ${questions[authProvider.currentQuestionIndex]["question"]}",
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 16),
                  for (int i = 0;
                      i <
                          questions[authProvider.currentQuestionIndex]
                                  ["options"]
                              .length;
                      i++) ...[
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                authProvider.selectedOption = i;
                                authProvider.setOptionString(questions[authProvider.currentQuestionIndex]
                                ["options"][i]);
                              });
                            },
                            child: Icon(i == authProvider.selectedOption
                                ? Icons.circle_rounded
                                : Icons.circle_outlined)),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            questions[authProvider.currentQuestionIndex]
                                ["options"][i],
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    )
                  ],
                  SizedBox(height: 16),
                  Consumer<AuthProvider>(builder: (context, val, child) {
                    return ElevatedButton(
                      onPressed: () {
                        val.nextQuestion(context);
                      },
                      child: Text('Next Question'),
                    );
                  }),
                  Consumer<AuthProvider>(builder: (context, val, child) {
                    return ElevatedButton(
                      onPressed: () {
                        val.restartQuiz(context);
                      },
                      child: Text('Restart quiz'),
                    );
                  }),
                ],
              ),
            ),
    );
  }
}
