import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'EditScreen.dart';

class ViewProductScreen extends StatefulWidget {
  const ViewProductScreen({Key? key}) : super(key: key);

  @override
  State<ViewProductScreen> createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
    appBar: AppBar(
      foregroundColor: Colors.red.shade900,
      centerTitle: true,
      toolbarHeight: 70,
      toolbarOpacity: 0.5,
      shadowColor: Colors.orange.shade900,
      elevation: 5.0,
      backgroundColor: Colors.grey.shade100,
      title: Text("View Product"),
    ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Products").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
        {
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
                        title: Text(document["name"].toString()),
                        subtitle: Text(document["category"].toString()),
                        trailing: Text("Rs" + document["price"].toString()),

                        onTap: () async{
                           var id = document.id.toString();
                          // await FirebaseStorage.instance.ref(document["filename"].toString()).delete().then((value) async{
                          //   await FirebaseFirestore.instance.collection("Products").doc(id).delete().then((value){});
                          // });
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => EditScreen(
                                updatedid: id,
                              ),));
                        },
                        onLongPress: (){
                          // Navigator.of(context).push(
                          //     MaterialPageRoute(builder: (context) => EditScreen(),)
                          // );
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
