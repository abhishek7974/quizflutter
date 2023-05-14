import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

BuildToast(String str) {
  return Fluttertoast.showToast(
      msg: str,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}


final List questions = [
    {
      "question": "The greatest of the numbers 123, 27, 650, 2342, 40000 is",
      "options": [
        "4000",
        "2342",
        "27",
        "650",
      ],
      "answer": 0,
    },
    {
      "question":
          "The greatest of the numbers 1000, 10000, 10, 1000000, 100000 is",
      "options": [
        "1000",
        "10000",
        "1000000",
        "100000",
      ],
      "answer": 0,
    },
    {
      "question": "The smallest of the numbers 1000, 50000, 111, 3222, 225 is",
      "options": [
        "111",
        "225",
        "1000",
        "3222",
      ],
      "answer": 0,
    },
    {
      "question":
          "The smallest of the numbers 2325, 2352, 2235, 2253, 2523, 2532 is",
      "options": [
        "2235",
        "2253",
        "2325",
        "2532",
      ],
      "answer": 0,
    },
    {
      "question":
          "Using the digits 1, 2, 3, 4 without repetition, the greatest 4-digit number that can be made is",
      "options": [
        "4321",
        "4312",
        "4213",
        "4231",
      ],
      "answer": 0,
    },
    {
      "question":
          " Using the digits 1, 5, 7, 2 without repetition, the greatest 4-digit number that can be made is",
      "options": [
        "7521",
        "7512",
        "7215",
        "7251",
      ],
      "answer": 0,
    },
    {
      "question":
          "Using the digits 3, 5, 7, 0 without repetition the greatest 4-digit number that can be made is",
      "options": [
        "7530",
        "7503",
        "7350",
        "7305",
      ],
      "answer": 0,
    },
    {
      "question":
          "The smallest 4-digit number that can be made using the digits 1,8,5,3 without repetition is",
      "options": [
        "1583",
        "1538",
        "1385",
        "1358",
      ],
      "answer": 0,
    },
    {
      "question":
          "The smallest 4-digit number that can be made using the digits 5,3,6,4 without repetition is",
      "options": [
        "3546",
        "3564",
        "3456",
        "3465",
      ],
      "answer": 0,
    },
    {
      "question":
          "The smallest 4-digit number that can be made using the digits 5,3,6,4 without repetition is",
      "options": [
        "3546",
        "3564",
        "3456",
        "3465",
      ],
      "answer": 0,
    },
    {
      "question":
          "The smallest 4-digit number that can be made using the digits 6, 5, 0, 4 without repetition is",
      "options": [
        "4560",
        "4056",
        "4065",
        "4506",
      ],
      "answer": 0,
    },
  ];