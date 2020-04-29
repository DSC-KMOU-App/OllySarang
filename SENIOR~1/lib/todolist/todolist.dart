import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seniorapp/todolist/new_todo.dart';
import 'package:seniorapp/todolist/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Todolist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin{
  List<Todo> list = new List<Todo>();
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    loadSharedPreferencesAndData();
    super.initState();
  }

  void loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: 60.0, left: 30.0, right: 30.0, bottom: 50.0),
              child: Text(
                '할 일',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 50.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 30.0, right: 30.0
              ),
              child: FloatingActionButton.extended(
                elevation: 5.0,
                backgroundColor: Colors.redAccent[200],
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.add),
                    Text('추가'),
                  ],
                ),
                onPressed: () =>goToNewItemView(),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: list.isEmpty ? emptyList() : buildListView(),
          ),
        ),
      ],
    );

  }

  Widget emptyList(){
    return SafeArea(
      child: Center(
          child:  Text(
            '없음',
            style: TextStyle(fontSize: 30),
          )
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context,int index){
        return buildListTile(list[index], index);
      },
    );
  }

  Widget buildListTile(Todo item, int index){
    return Card(
        child: ListTile(
          onTap: () => changeItemCompleteness(item),
          leading: Icon(item.completed
              ? Icons.check_box
              : Icons.check_box_outline_blank,
            key: Key('completed-icon-$index'),
          ),
          title: Text(
            item.title,
            key: Key('item-$index'),
            style: TextStyle(
                fontSize: 25,
                color: item.completed ? Colors.grey : Colors.black,
                decoration: item.completed ? TextDecoration.lineThrough : null
            ),
          ),
          trailing:Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ButtonTheme(
                    minWidth:8,
                    child:FlatButton(
                        child:Text("수정",style: TextStyle(fontSize: 15),),
                        onPressed: () => goToEditItemView(item)
                    )
                ),
                ButtonTheme(
                    minWidth:8,
                    child:FlatButton(
                        child:Text("삭제",style: TextStyle(fontSize: 15),),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text('삭제하시겠습니까?',style: TextStyle(fontSize: 30),),
                                  ],
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("취소",style: TextStyle(fontSize: 30)),
                                    onPressed: (){
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("확인",style: TextStyle(fontSize: 30)),
                                    onPressed: (){
                                      setState(() {
                                        removeItem(item);
                                        loadSharedPreferencesAndData();
                                        Navigator.pop(context);
                                      });
                                    },
                                  ),
                                ],
                              )
                          );
                        }
                    )
                ),
              ]
          ),
        ));
  }

  void goToNewItemView(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return NewTodoView();
    })).then((title){
      if(title != null) {
        addItem(Todo(title: title));
      }
    });
  }

  void addItem(Todo item){
    list.insert(0, item);
    saveData();
  }

  void goToEditItemView(item){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return NewTodoView(item: item);
    })).then((title){
      if(title != null) {
        editItem(item, title);
      }
    });
  }

  void editItem(Todo item ,String title){
    item.title = title;
    saveData();
  }

  void removeItem(Todo item){
    list.remove(item);
    saveData();
  }

  void loadData() {
    List<String> listString = sharedPreferences.getStringList('list');
    if(listString != null){
      list = listString.map(
              (item) => Todo.fromMap(json.decode(item))
      ).toList();
      setState((){});
    }
  }

  void saveData(){
    List<String> stringList = list.map(
            (item) => json.encode(item.toMap()
        )).toList();
    sharedPreferences.setStringList('list', stringList);
  }

  void changeItemCompleteness(Todo item){
    setState(() {
      item.completed = !item.completed;
    });
    saveData();
  }
}
