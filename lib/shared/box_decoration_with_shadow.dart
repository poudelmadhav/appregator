import 'package:flutter/material.dart';

const BoxDecoration boxDecorationWithShadow = BoxDecoration(
  boxShadow: <BoxShadow>[
    BoxShadow(
        color: Colors.black54, blurRadius: 10.0, offset: Offset(0.0, 0.75))
  ],
  color: Colors.white,
);
