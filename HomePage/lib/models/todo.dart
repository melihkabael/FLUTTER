class Todo {
  int id;
  String title;
  bool isComplated;
  bool? isStar;
  bool? isEdit;
  Todo(
      {required this.id,
      required this.title,
      required this.isComplated,
      this.isStar = false, this.isEdit = false});

}
