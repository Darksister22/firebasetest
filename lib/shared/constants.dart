import 'package:flutter/material.dart';

var inputDecor = InputDecoration(
  labelStyle: const TextStyle(color: Colors.pink, fontSize: 20),
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.white, width: 10),
    borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.pink, width: 2),
    borderRadius: BorderRadius.circular(10),
  ),
);
