import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterScreen(),
    );
  }
}
class CounterScreen extends StatefulWidget {
  const CounterScreen ({super.key});

  @override
  State<CounterScreen > createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen > {
  var counter=0;
  void increment(){
setState(() {
  counter++;
});
  }
  void decrement(){
    setState(() {
      counter--;
    });
    
  }
  void refresh(){
      setState(() {
        counter=0;
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter App"),
        centerTitle: true,
        backgroundColor:  Colors.deepPurpleAccent,
     ),
     body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Your current count",
          style:TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],

          ) ,
          ),
          SizedBox(height: 10,),
          Text(
            '$counter',
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurpleAccent,
            ),
          ),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: decrement, 

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Icon(Icons.remove,size: 30,color: Colors.white,),
              
              ),
                        SizedBox(width: 20,),
ElevatedButton(onPressed: increment, 

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Icon(Icons.add,size: 30,color: Colors.white,),
              
              ),
              SizedBox(width: 20,),
              ElevatedButton(
                onPressed: refresh, 

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Icon(Icons.refresh,size: 30,color: Colors.white,),
              
              ),
            ],
          )
        ],
      ),
     ),
    );
  }
}