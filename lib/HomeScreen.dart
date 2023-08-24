import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AddEmployeScreen.dart';
import 'AddProductScreen.dart';
import 'ViewEmployeScreen.dart';
import 'ViewProductScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: Drawer(
        backgroundColor: Colors.orange.shade100,
        child: Column(
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 300.0,
                margin: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Color(0xfffff3e0),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 15,),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).pop;
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => AddProductScreen(),)
                        );
                      },
                      child: Text("Add Product"),
                    ),
                    SizedBox(height: 15,),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).pop;
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ViewProductScreen(),)
                        );
                      },
                      child: Text("View Product"),
                    ),
                    SizedBox(height: 15,),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).pop;
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => AddEmployeScreen(),)
                        );
                      },
                      child: Text("Add Employe"),
                    ),
                    SizedBox(height: 15,),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).pop;
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ViewEmployeScreen(),)
                        );
                      },
                      child: Text("View Employe"),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
