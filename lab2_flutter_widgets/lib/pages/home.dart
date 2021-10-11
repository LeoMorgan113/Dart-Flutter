import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _userToDo = '';
  List todoList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    todoList.addAll(["Buy milk", "Wash dish", "Fill bottle"]);
  }
  void _menuOpen(){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context){
        return Scaffold(
          appBar: AppBar(
            title:  Text('Menu'),),
          body: Row(
            children: [
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
                  child: Text('Back to Main')),
              Padding(padding: EdgeInsets.only(left: 15)),
              Text('Our simple menu'),
            ],
          )
        );
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        title: Text('ToDos'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: [
            IconButton(onPressed: _menuOpen, icon: Icon(Icons.menu_book_outlined))
        ],
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (BuildContext context, int index){
            return Dismissible(
                key: Key(todoList[index]),
                child: Card(
                  child: ListTile(
                    title: Text(todoList[index]),
                    trailing: IconButton(
                        onPressed: (){
                          setState(() {
                            todoList.removeAt(index);
                          });},
                        icon: Icon(Icons.delete_sweep, color: Colors.deepOrange)
                    ),
                  ),
                ),
                onDismissed: (direction){
                  // if(direction == DismissDirection.endToStart)
                  setState(() {
                    todoList.removeAt(index);
                  });
                },
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          showDialog(context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  title: Text("Add todo item"),
                  content: TextField(
                    onChanged: (String value){
                      _userToDo = value;
                    },
                  ),
                  actions: [
                    ElevatedButton(onPressed: (){
                      setState(() {
                        todoList.add(_userToDo);
                      });
                      Navigator.of(context).pop();
                    }, child: Text('Add todo'),),
                  ],
                );
              });
        },
        child: Icon(
            Icons.add,
            color: Colors.deepOrange,
        ),
      ),
    );
  }
}
