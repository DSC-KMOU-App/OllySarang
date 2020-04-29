import 'package:flutter/material.dart';
import 'package:ollysarang/todolist/todolist.dart';


class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Page3StatefulWidget();

  }
}

class Page3StatefulWidget extends StatefulWidget {
  @override
  _Page3StatefulWidgetState createState() => _Page3StatefulWidgetState();
}

class _Page3StatefulWidgetState extends State<Page3StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Todolist();
  }
}