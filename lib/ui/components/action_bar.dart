import 'package:flutter/material.dart';

const ACTION_BAR_HEIGHT = 70.0;

class ActionBar extends StatefulWidget {
  @override
  _ActionBarState createState() => _ActionBarState();
}

class _ActionBarState extends State<ActionBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ACTION_BAR_HEIGHT,
    );
  }
}
