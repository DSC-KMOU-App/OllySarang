import 'package:flutter/material.dart';
import 'package:ollysarang/todolist/todo.dart';

class NewTodoView extends StatefulWidget {
  final Todo item;

  NewTodoView({ this.item });

  @override
  _NewTodoViewState createState() => _NewTodoViewState();
}

class _NewTodoViewState extends State<NewTodoView> {
  TextEditingController titleController;

  @override
  void initState() {
    super.initState();
    titleController = new TextEditingController(
        text: widget.item != null ? widget.item.title : null
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Enter what to do",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 25.0,),
              TextField(
                style: TextStyle(fontSize: 30),
                controller: titleController,
                autofocus: true,
                onSubmitted: (value) => submit(),
              ),
              SizedBox(height: 50.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    color: Theme.of(context).primaryColor,
                    child: Container(
                      height: 50,
                      width: 100,
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              fontSize: 30,
                              color: Theme.of(context).primaryTextTheme.title.color
                          ),
                        ),
                      ),
                    ),
                    onPressed: (){
                      setState(() {
                        titleController.clear();
                        Navigator.pop(context);
                      });
                    },
                  ),
                  SizedBox(width: 50,),
                  FlatButton(
                    color: Theme.of(context).primaryColor,
                    child: Container(
                      height: 50,
                      width: 100,
                      child: Center(
                        child: Text(
                          'Save',
                          style: TextStyle(
                              fontSize: 30,
                              color: Theme.of(context).primaryTextTheme.title.color
                          ),
                        ),
                      ),
                    ),
                    onPressed: () => submit(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void submit(){
    Navigator.of(context).pop(titleController.text);
  }
}
