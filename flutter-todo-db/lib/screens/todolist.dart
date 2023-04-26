import 'package:flutter/material.dart';
import 'package:myapp/models/todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String title = "";
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  List<Todo> todolist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          addTodo();
          /* setState(() {
            _autovalidateMode=AutovalidateMode.disabled;
          });*/
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: const <Widget>[],
        ),
      ),
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text("TodoList"),
        actions: const [
          Icon(Icons.settings),
          SizedBox(
            width: 5,
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              color: Colors.grey[300],
              child: Form(
                autovalidateMode: _autovalidateMode,
                key: formKey,
                child: TextFormField(
                  onSaved: (newValue) {
                    title = newValue!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Boş geçilemez';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      hintText: 'Başlık', labelText: 'Başlık giriniz.'),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.topCenter,
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  height: 5,
                  color: Colors.transparent,
                ),
                itemCount: todolist.length,
                itemBuilder: (BuildContext context, int index) {
                  Todo item = todolist[index];
                  return ListTile(
                    tileColor:
                        item.isComplated ? Colors.green[100] : Colors.red[100],
                    title: Text(
                      "#${item.id} - ${item.title}",
                      style: TextStyle(
                        decoration: item.isComplated
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    subtitle: InkWell(
                      child: const Text("Tıkla ve görevi tamamla!"),
                      onTap: () {
                        setState(() {
                          item.isComplated = !item.isComplated;
                        });
                      },
                    ),
                    leading: const Icon(Icons.list),
                    trailing: InkWell(
                      child: const Icon(Icons.close),
                      onTap: () {
                        setState(() {
                          todolist.remove(item);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void addTodo() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      alertSuccess("Kayıt Eklendi!");
      setState(() {
        todolist.add(Todo(
            id: todolist.isNotEmpty ? todolist.last.id + 1 : 1,
            title: title,
            isComplated: false));
      });
      debugPrint(todolist.toString());
      formKey.currentState!.reset();
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  void alertSuccess(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Kapat"),
                ),
              ],
              content: SizedBox(
                height: 100,
                child: Column(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 72,
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: Text(message)),
                  ],
                ),
              ),
            ));
  }
}
