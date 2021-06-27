import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  // const ToDoList({ Key? key }) : super(key: key);

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("To-Do App"),
      ),
      body: (todoList.length == 0)
          ? centeredText()
          : Container(
              decoration: BoxDecoration(color: Colors.blue[50]),
              child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(
                      todoList[i],
                      style: TextStyle(color: Colors.blue[900]),
                    ),
                    trailing: Container(
                      width: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            onTap: () {
                              setState(() {});
                              newItem(context, setState, todoList,
                                  edit: true, index: i);
                            },
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onTap: () {
                              setState(() {
                                todoList.removeAt(i);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
          newItem(context, setState, todoList);
        },
        child: Text(
          "+",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}

void newItem(BuildContext context, Function setState, List todoList,
    {bool edit = false, int index}) {
  String value = '';

  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: edit ? Text("Edit your item") : Text("Add new item"),
      content: TextFormField(
        initialValue: edit ? todoList[index] : '',
        decoration: InputDecoration(
          labelText: edit ? 'Edit list item' : 'Type new list item',
        ),
        onChanged: (val) {
          value = val;
        },
      ),
      actions: [
        TextButton(
          child: edit ? Text('Update') : Text('Add'),
          onPressed: () {
            reRender() {
              if (edit) {
                todoList.setAll(index, [value]);
                todoList.join(', ');
              } else {
                todoList.add(value);
              }
            }

            setState(reRender);

            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
    barrierDismissible: false,
  );
}

Widget centeredText() {
  return Center(
    child: Text(
      "No Item On List!",
      style: TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    ),
  );
}
