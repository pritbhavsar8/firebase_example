import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_example/EditEmploye.dart';
import 'package:firebase_example/EditScreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewEmployeScreen extends StatefulWidget {
  const ViewEmployeScreen({Key? key}) : super(key: key);

  @override
  State<ViewEmployeScreen> createState() => _ViewEmployeScreenState();
}

class _ViewEmployeScreenState extends State<ViewEmployeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.red.shade900,
        centerTitle: true,
        toolbarHeight: 70,
        toolbarOpacity: 0.5,
        shadowColor: Colors.orange.shade900,
        elevation: 5.0,
        backgroundColor: Colors.grey.shade100,
        title: Text("View Employes"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Employes").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasData)
          {
            if(snapshot.data!.size<=0)
            {
              return Center(
                child: Text("No data"),
              );
            }
            else
            {
              return ListView(
                children: snapshot.data!.docs.map((document){
                  return ListTile(
                    leading: Image.network(document["fileurl"].toString()),
                    title: Text(document["Name"].toString()),
                    subtitle: Text(document["Department"].toString()),
                    trailing: Text( document["Description"].toString()),
                    onTap: () async{
                      var id = document.id.toString();
                      await FirebaseStorage.instance.ref(document["filename"].toString()).delete().then((value) async{
                      await FirebaseFirestore.instance.collection("Employes").doc(id).delete().then((value){});
                      });
                    },
                    onLongPress: () async{
                      var id = document.id.toString();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => EditEmploye(
                            updated:id,
                          ),)
                      );
                    },


                  );
                }).toList(),
              );
            }
          }
          else
          {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),

    );
  }
}
