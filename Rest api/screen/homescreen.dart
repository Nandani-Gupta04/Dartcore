
import 'package:flutter/material.dart';
import 'package:my_app/model/user.dart';
import 'package:my_app/services/user_services.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<User> users = [];
  @override
  void initState(){
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 236, 130, 213),
        title: const Text(
          'Rest API Call',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          //final color=user.gender=='male'?Colors.purple:Colors.blueAccent;
          return ListTile(
            title: Text(user.fullName),
            subtitle: Text(user.location.country),
            //tileColor: color,
          );
        },
      ),

      
    );
  }
  Future<void> fetchUsers() async{
  final response= await UserServices.fetchUsers();
  setState(() {
        users = response;
      });
  }
}
