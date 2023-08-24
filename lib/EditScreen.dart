import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class EditScreen extends StatefulWidget
{
  var updatedid="";
  EditScreen({required this.updatedid});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen>
{
  ImagePicker picker = ImagePicker();
  var selected = "electronic";
  TextEditingController _name = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _description = TextEditingController();

  File? selectedfile;
  bool isloading=false;
  var oldfilename="";
  var oldfileurl="";

  getdata() async
  {
    await FirebaseFirestore.instance.collection("Products").doc(widget.updatedid).get().then((document){
      setState(() {
        _name.text = document["name"].toString();
        _price.text = document["price"].toString();
        _description.text = document["description"].toString();
        selected = document["category"].toString();
        oldfilename = document["filename"].toString();
        oldfileurl = document["fileurl"].toString();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }


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
        title: Text("Edit Product"),
      ),
      body:  (isloading)?Center(child: CircularProgressIndicator(),):SingleChildScrollView(
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.all(15.0),
          padding: EdgeInsets.all(15.0),
          color: Color(0xfffff3e0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: (selectedfile==null)?(oldfileurl=="")?Image.asset("img/No-Image.png",width: 70.0,height: 70.0,)
                    :Image.network(oldfileurl,width: 70.0,height: 70.0,):
                Image.file(selectedfile!,width: 100.0,),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async{
                      XFile? photo = await picker.pickImage(source: ImageSource.camera);
                      setState(() {
                        selectedfile = File(photo!.path);
                      });
                    },
                    icon: Icon(Icons.camera_alt,size: 40.0,color: Colors.blue),
                  ),
                  SizedBox(width: 10.0,),
                  ElevatedButton(
                    onPressed: () async{
                      XFile? photo = await picker.pickImage(source: ImageSource.gallery
                      );
                      setState(() {
                        selectedfile = File(photo!.path);
                      });
                    },
                    child: Image.asset("img/gallery.png",width: 40.0,height: 40.0,),
                  )
                ],
              ),
              SizedBox(height: 10.0,),
              Text("Title:",style:TextStyle(
                  fontWeight: FontWeight.bold
              )),
              SizedBox(
                width: 300.0,
                child: TextField(
                  controller: _name,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.0),
                          borderSide: BorderSide(
                              color: Colors.grey
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.0),
                          borderSide: BorderSide(
                              color: Colors.black
                          )
                      )
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
              Text("Description:",style:TextStyle(
                  fontWeight: FontWeight.bold
              )),
              SizedBox(
                width: 300.0,
                child: TextField(
                  controller: _description,
                  keyboardType: TextInputType.text,
                  maxLines: 2,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11.0),
                      borderSide: BorderSide(
                          color: Colors.black
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
              Text("Price",style:TextStyle(
                  fontWeight: FontWeight.bold
              )),
              SizedBox(
                width: 300.0,
                child: TextField(
                  controller: _price,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.0),
                          borderSide: BorderSide(
                              color: Colors.black
                          )
                      )
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
              Text("Category"),
              DropdownButton(
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold
                ),
                dropdownColor: Colors.orangeAccent.shade200,
                value: selected,
                onChanged: (val){
                  setState(() {
                    selected=val!;
                  });
                },
                items: [
                  DropdownMenuItem(
                    child: Text("Electronic"),
                    value: "electronic",
                  ),
                  DropdownMenuItem(
                    child: Text("Beauty"),
                    value: "beauty",
                  ),
                  DropdownMenuItem(
                    child: Text("Grocery"),
                    value: "grocery",
                  ),
                  DropdownMenuItem(
                    child: Text("Pharmacy"),
                    value: "pharmacy",
                  ),
                ],
              ),
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 310.0,
                    child: ElevatedButton(
                      onPressed: () async{
                        var title  = _name.text.toString();
                        var description  = _description.text.toString();
                        var price  = _price.text.toString();
                        var category = selected;


                        if(selectedfile==null)
                          {
                            // Data update
                            await FirebaseFirestore.instance.collection("Products").doc(widget.updatedid).update({
                              "name":title,
                              "description":description,
                              "price":price,
                              "category":category,
                            }).then((value){
                              Navigator.of(context).pop();
                            });
                          }
                        else
                          {
                            setState(() {
                              isloading=true;
                            });
                            await FirebaseStorage.instance.ref(oldfilename).delete().then((value) async{
                              var uuid = Uuid();
                              var filename = uuid.v4();

                              await FirebaseStorage.instance.ref(filename).putFile(selectedfile!)
                                  .whenComplete((){}).then((filedata) async{
                                await filedata.ref.getDownloadURL().then((fileurl) async{
                                  await FirebaseFirestore.instance.collection("Products").doc(widget.updatedid).update({
                                    "name":title,
                                    "description":description,
                                    "price":price,
                                    "category":category,
                                    "filename":filename,
                                    "fileurl":fileurl
                                  }).then((value){
                                    setState(() {
                                      isloading=false;
                                    });
                                    Navigator.of(context).pop();
                                  });
                                });
                              });
                            });
                          }


                        },
                      child: Text("Update"),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    ),
    );
  }
}
