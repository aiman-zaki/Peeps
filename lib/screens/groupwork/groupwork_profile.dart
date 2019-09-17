import 'dart:io';
import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/bloc/groupwork/profile/group_profile_bloc.dart';

class GroupworkProfile extends StatefulWidget {
  final data;
  GroupworkProfile({Key key,this.data}) : super(key: key);

  _GroupworkProfileState createState() => _GroupworkProfileState();
}

class _GroupworkProfileState extends State<GroupworkProfile> {
  File _image;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _bloc =  BlocProvider.of<GroupProfileBloc>(context);
    

    _buildGroupAdminSetting(){
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(9),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red[400]),
          borderRadius: BorderRadius.circular(9)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(''),
          ],
        ),
      );
    }

    _buildProfileDetail(){
      return Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            Text("id: ${widget.data.id}",style: TextStyle(fontSize: 12),),
            Text(widget.data.name,style:  TextStyle(
              fontSize: 21
            ),),
            SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[800]),
                borderRadius: BorderRadius.circular(9)
            
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("creator : ${widget.data.creator}"),
                  SizedBox(height: 10,),
                  Text("supervisor: "),
                  SizedBox(height: 10,),
                  Text("description : ${widget.data.description}"),
                  SizedBox(height: 10,),
                  Text("course : ${widget.data.course}"),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(child: Text('Update')),
                  ),
                ],
              ),
            ),
          ],
        ),
      );   
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0.00,
        backgroundColor: Theme.of(context).backgroundColor,
    
      ),
      body: Container(
         padding: EdgeInsets.all(9),
         child: SingleChildScrollView(
           child: Stack(
             children: <Widget>[
               Positioned(
                 right: 20,
                 child: Container(
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(9),
                     color: Colors.green[700]
                   ),
                   padding: EdgeInsets.all(6),
   
                   child: Row(
                     children: <Widget>[
                       Icon(Icons.add),
                       Text("Follow",style: TextStyle(fontWeight: FontWeight.bold),),

                     ],
                   ),
                 ),
               ),
               Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Center(
                     child: Hero(
                       tag: 'dp',
                       child: CircleAvatar(
                         radius: 80,
                         backgroundColor: Colors.grey[850],
                         child: Image.network(
                           widget.data.profilePicturerUrl,
                           width: 120,
                         ),
                       ),
                     ),
                   ),
                  _buildProfileDetail(),
                  SizedBox(height: 10,),
                  Text('Administrator'),
                  _buildGroupAdminSetting(),
                 ],
               ),
             ],
           ),
         ),
      ),
    );
  }
}