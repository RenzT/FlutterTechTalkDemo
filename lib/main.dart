import 'package:flutter/material.dart';
//import 'package:listview_utils/listview_utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(title: 'ToDo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> todos = <String>[''];
  final List<String> finishedTodos = <String>[''];

  TextEditingController todoController = TextEditingController();

  void addItemToList() {
    setState(() {
      todos.insert(0, todoController.text);
    });
  }

  void clearText() {
    todoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: todos.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              // return the header
              return new Column(
                children: [Text('Current Todos:')],
              );
            }
            index -= 1;
            final item = todos[index];
            return Dismissible(
              key: Key(item),
              onDismissed: (direction) {
                if (direction == DismissDirection.startToEnd) {
                  finishedTodos.add(todos[index]);
                  setState(() {
                    todos.removeAt(index);
                  });
                  print(finishedTodos);
                } else {
                  setState(() {
                    todos.removeAt(index);
                  });
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('$item dismissed')));
                }
              },
              background: new Container(
                  padding: EdgeInsets.only(right: 20.0),
                  color: Colors.green,
                  child: new Align(
                    alignment: Alignment.centerLeft,
                    child: new Text('Add to Done',
                        textAlign: TextAlign.right,
                        style: new TextStyle(color: Colors.white)),
                  )),
              secondaryBackground: new Container(
                padding: EdgeInsets.only(right: 20.0),
                color: Colors.red,
                child: Align(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        " Delete",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  alignment: Alignment.centerRight,
                ),
              ),
              child: ListTile(title: Text('$item')),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => _buildPopupDialog(context),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Add an Item'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: todoController,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Add Item to ToDo List'),
          ),
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            addItemToList();
            clearText();
            Navigator.of(context).pop();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
