import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:todolist_mysql/screens/mydrawer.dart';
import 'package:todolist_mysql/screens/tododetay.dart';

import '../models/todo.dart';

class TodoListMysql extends StatefulWidget {
  const TodoListMysql({super.key});

  @override
  State<TodoListMysql> createState() => _TodoListMysqlState();
}

class _TodoListMysqlState extends State<TodoListMysql> {
  List<Todo> MysqlTodolist = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String title = "";
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  bool isObscure = false;
  bool isEdit = false;
  late Todo editableTodo;
  late MySqlConnection conn;
  final Text2 = TextEditingController();
  @override
  void initState() {
    mysqlconn();
    super.initState();
  }

  @override
  void dispose() {
    conn.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Mydrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isEdit ? Icons.save : Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          isEdit ? updateTodo() : addTodo();
          setState(() {
            isEdit = false;
          });
        },
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
                  controller: Text2,
                  obscureText: isObscure,
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
                  decoration: InputDecoration(
                    hintText: 'Başlık',
                    labelText: 'Başlık giriniz.',
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      child: Icon(
                          isObscure ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
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
                itemCount: MysqlTodolist.length,
                itemBuilder: (BuildContext context, int index) {
                  Todo item = MysqlTodolist[index];
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
                          updateTodo();
                          // MysqlTodolist = [];
                        });
                      },
                    ),
                    leading: item.isComplated
                        ? const Icon(Icons.check_box_outlined)
                        : const Icon(Icons.check_box_outline_blank),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isEdit = !isEdit;
                              editableTodo = item;
                              if (isEdit) {
                                Text2.text = item.title;
                              } else {
                                Text2.text = '';
                              }
                            });
                          },
                          child: InkWell(
                            child: Icon(Icons.edit,
                                color: isEdit && editableTodo == item
                                    ? Colors.blue
                                    : Colors.black),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              item.isStar = !item.isStar!;
                              updateStar(item.id, item.isStar!);
                            });
                          },
                          icon: Icon(
                            Icons.star,
                            color: item.isStar! ? Colors.amber : Colors.black45,
                          ),
                        ),
                        InkWell(
                            child: const Icon(Icons.close),
                            onTap: () async {
                              setState(() {
                                MysqlTodolist.removeAt(index);
                                deleteTodo(item.id);
                              });
                            }),
                        InkWell(
                          child: const Icon(Icons.more_vert),
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TodoDetail(todo: item)));
                            });
                          },
                        ),
                      ],
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

  void addTodo() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      alertSuccess("Kayıt Eklendi!");
      final conn = await MySqlConnection.connect(ConnectionSettings(
          host: '93.89.225.127',
          port: 3306,
          user: 'ideftp1_testus',
          db: 'ideftp1_testdb',
          password: '123456aA+-'));
      await conn.query('insert into todo (title, iscomplated) values (?, ?)',
          [title, false]);
      var results = await conn.query("select * from todo");
      setState(() {
        MysqlTodolist = [];
        for (var element in results) {
          MysqlTodolist.add(Todo(
              id: element["id"],
              title: element["title"],
              isComplated: element["iscomplated"] == 1 ? true : false));
        }
      });
      debugPrint(MysqlTodolist.toString());
      formKey.currentState!.reset();
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  Future updateTodo() async {
    alertSuccess("Kayıt Güncellendi!");
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '93.89.225.127',
        port: 3306,
        user: 'ideftp1_testus',
        db: 'ideftp1_testdb',
        password: '123456aA+-'));
    conn.query(
        "update todo set title =? where id=?", [Text2.text, editableTodo.id]);
    MysqlTodolist.map((e) => {
          if (e == editableTodo)
            {
              setState(() {
                e.title = Text2.text;
              })
            }
        }).toList();
    Text2.text = "";
  }

  void updateStar(int id, bool star) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '93.89.225.127',
        port: 3306,
        user: 'ideftp1_testus',
        db: 'ideftp1_testdb',
        password: '123456aA+-'));
    await conn.query('update todo set isstar=? where id=?', [star, id]);
  }

  void deleteTodo(int id) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '93.89.225.127',
        port: 3306,
        user: 'ideftp1_testus',
        db: 'ideftp1_testdb',
        password: '123456aA+-'));
    await conn.query('delete from todo where id = ?', [id]);
  }

  void mysqlconn() async {
    debugPrint("Bağlanmaya çalıştı");
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '93.89.225.127',
        port: 3306,
        user: 'ideftp1_testus',
        db: 'ideftp1_testdb',
        password: '123456aA+-'));
    var results = await conn.query("select * from todo");
    debugPrint(results.toString());

    setState(() {
      MysqlTodolist = [];
      for (var element in results) {
        MysqlTodolist.add(Todo(
            id: element["id"],
            title: element["title"],
            isComplated: element["iscomplated"] == 1 ? true : false));
      }
    });
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
