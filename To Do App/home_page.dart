import 'package:flutter/material.dart';
import 'package:todo_app/utils/dialog_box.dart';
import 'package:todo_app/utils/todo_item.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/database/database.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller=TextEditingController();
  final _mybox=Hive.box('mybox');
  TodoDataBase db=TodoDataBase();
@override
void initState(){
if(_mybox.get("TODOLIST")==null){
  db.createData();
}else{
  db.loadData();
}
super.initState();
}

 // List TodoList=[
   // ["TODO",false],
     // ["TODO",false],
    //["TODO",false],
    //["TODO",false],
    //["TODO",false],
    //["TODO",false],
  //];
  void deleteTask(int index){
setState((){
  db.TodoList.removeAt(index);
});
db.updateData();
  }

  void checkboxChanged(bool? value, int index){
setState(() {
  db.TodoList[index][1]=!db.TodoList[index][1];
});
db.loadData();
  }

void saveNewTask() {

  setState(() {
    db.TodoList.add([_controller.text, false]);
  });

  db.updateData();

  _controller.clear();

  Navigator.of(context).pop();
}
void createNewTask(){
  showDialog(
    context: context,
     builder: (context) {
    return DialogBox(controller: _controller,
     onCancel:()=>Navigator.of(context).pop(),
     onSave:saveNewTask ,
      );
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 216, 136, 192),
      appBar: AppBar(
        title: Text('TODO',style: TextStyle(
          color: Colors.white,
        ),),
        backgroundColor: Colors.deepPurple[500],
        elevation: 10,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.deepPurpleAccent[400],
        child: Icon(Icons.add,color: Colors.white,),
        ),
      body: ListView.builder(
              itemCount:db.TodoList.length,
itemBuilder: (context , index){
  return TodoItem(
    isChecked: db.TodoList[index][1],
     onChanged: (value)=>checkboxChanged(value, index), 
     todoText: db.TodoList[index][0],
     onPressed: (context){
      deleteTask(index);
     },
     );
}),
      );
  }
}