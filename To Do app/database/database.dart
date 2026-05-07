import 'package:hive_flutter/hive_flutter.dart';

class TodoDataBase{
  List TodoList=[];
final _mybox=Hive.box('mybox');

void createData(){
  TodoList=[
        ["TODO",false],
      ["TODO",false],
    ["TODO",false],

  ];
}
void loadData(){
  TodoList=_mybox.get("TODOLIST");
}
void updateData(){
  _mybox.put("TODOLIST", TodoList);
}


}