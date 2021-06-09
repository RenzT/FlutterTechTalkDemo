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
  final List<String> names = <String>[];

  TextEditingController nameController = TextEditingController();

  void addItemToList() {
    setState(() {
      names.insert(0, nameController.text);
    });
  }

  void clearText() {
    nameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: names.length,
          itemBuilder: (context, index) {
            if (index == 0) {
            // return the header
            return new Column(
              children: [Text('Current Todos:')],
            );
        }
        index -= 1;
  final item = names[index];
  return Dismissible(
    key: Key(item),
    onDismissed: (direction) {
      if (direction == DismissDirection.startToEnd){
        print("Add to Done");
      } else {
      setState(() {
        names.removeAt(index);
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('$item dismissed')));
    }},
    background: Container(color: Colors.red),
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
            controller: nameController,
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
