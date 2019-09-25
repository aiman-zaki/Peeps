import 'dart:io';
import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/bloc/groupwork/profile/group_profile_bloc.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/screens/common/common_profile_picture.dart';

class GroupworkProfile extends StatefulWidget {
  final GroupworkModel data;
  GroupworkProfile({Key key, this.data}) : super(key: key);

  _GroupworkProfileState createState() => _GroupworkProfileState();
}

class _GroupworkProfileState extends State<GroupworkProfile> {
  File _image;
  bool upload = false;
  final _creatorController = TextEditingController();
  final _supervisorController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _courseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _creatorController.text = widget.data.creator;
    _descriptionController.text = widget.data.description;
    _courseController.text = widget.data.course;
  }

  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      upload = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<GroupProfileBloc>(context);
    final edit = true;
    final size = MediaQuery.of(context).size;

    _readOnlyFormField(
        {String labelText, String data, TextEditingController controller}) {
      return TextField(
        controller: controller,
        readOnly: edit,
        decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(9)))),
      );
    }

    _buildGroupAdminSetting() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(9),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.red[400]),
            borderRadius: BorderRadius.circular(9)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(''),
          ],
        ),
      );
    }

    _buildProfileDetail() {
      return Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            Text(
              "id: ${widget.data.id}",
              style: TextStyle(fontSize: 12),
            ),
            Text(
              widget.data.name,
              style: TextStyle(fontSize: 21),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: _readOnlyFormField(
                        labelText: "Creator",
                        data: widget.data.creator,
                        controller: _creatorController)),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    flex: 2,
                    child: _readOnlyFormField(
                        labelText: "Supervisor",
                        data: widget.data.creator)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _readOnlyFormField(
                labelText: "Description",
                data: widget.data.description,
                controller: _descriptionController),
            SizedBox(
              height: 10,
            ),
            _readOnlyFormField(
                labelText: "Course",
                data: widget.data.course,
                controller: _courseController),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(onPressed: () {}, child: Text('Update')),
            ),
          ],
        ),
      );
    }

    Widget _uploadButton() {
      return FlatButton(
        onPressed: !upload
            ? null
            : () {
                _bloc.dispatch(UploadGroupworkProfileImage(
                    groupId: widget.data.id, image: _image));
              },
        child: Text("Upload"),
      );
    }

    Widget _buildAvatar() {
      return Center(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 70,
          child: _image == null
              ? CustomNetworkProfilePicture(
                  image: widget.data.profilePicturerUrl,
                  onTap: _getImage,
                  child: Container(
                    alignment: FractionalOffset.bottomCenter,
                    child: Text(""),
                  ),
                )
              : InkWell(
                  onTap: _getImage,
                  child: Container(
                      width: 190,
                      height: 190,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(120),
                          image: DecorationImage(
                              image: new FileImage(_image), fit: BoxFit.cover)),
                      child: Container(
                          alignment: FractionalOffset.bottomCenter,
                          child: Text(""))),
                ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.00,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 0,
                child: ClipPath(
                    clipper: WaveClipperTwo(),
                    child: Container(
                      width: size.width,
                      height: 100,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.purple[900],
                            Colors.purple[800],
                            Colors.purple[700], 
                      ])),
                    ))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildAvatar(),
                  Center(child: _uploadButton()),
                  _buildProfileDetail(),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Administrator'),
                  _buildGroupAdminSetting(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
