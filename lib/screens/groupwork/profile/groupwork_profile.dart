import 'dart:io';
import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/bloc/groupwork/profile/group_profile_bloc.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/resources/groupwork_repository.dart';
import 'package:peeps/resources/note_repository.dart';
import 'package:peeps/screens/common/captions.dart';
import 'package:peeps/screens/common/common_profile_picture.dart';
import 'package:peeps/screens/common/tag.dart';
import 'package:peeps/screens/groupwork/profile/admin.dart';
import 'package:peeps/screens/groupwork/profile/notes.dart';
import 'package:peeps/screens/groupwork/profile/requests.dart';

import 'drawer.dart';

enum Role {
  admin,
  normal,
}

class GroupworkProfile extends StatefulWidget {
  final GroupworkModel data;
  final isAdmin;
  GroupworkProfile({
    Key key,
    this.data,
    this.isAdmin,
  }) : super(key: key);

  _GroupworkProfileState createState() => _GroupworkProfileState();
}

class _GroupworkProfileState extends State<GroupworkProfile> {
  File _image;
  bool upload = false;
  bool readOnly = true;

  final _creatorController = TextEditingController();
  final _supervisorController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _courseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _supervisorController.text = widget.data.supervisor;
    _creatorController.text = widget.data.creator;
    _descriptionController.text = widget.data.description;
    _courseController.text = widget.data.course;
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<GroupProfileBloc>(context);
    final _membersBloc = BlocProvider.of<MembersBloc>(context);

    final size = MediaQuery.of(context).size;

    Future _getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
        upload = true;
      });
      _bloc.add(
          UploadGroupworkProfileImage(groupId: widget.data.id, image: _image));
    }

    _buildAdminFeatures() {
      if (widget.isAdmin) {
        return Expanded(
            flex: 1,
            child: FlatButton(child: Text("Assign"), onPressed: () {}));
      }
      return Container();
    }

    _readOnlyFormField(
        {String labelText, String data, TextEditingController controller}) {
      return TextField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(9)))),
      );
    }

    _buildGroupAdminSetting() {
      return Container(
        padding: EdgeInsets.all(9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    flex: 3,
                    child: Text(
                      'Administrator',
                      style: TextStyle(fontSize: 16),
                    )),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.data.members.length,
              itemBuilder: (context, index) {
                if (widget.data.members[index]['role'] == Role.admin.index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(9),
                    title: Text(widget.data.members[index]['email']),
                  );
                }
              },
            )
          ],
        ),
      );
    }

    

    _buildProfileDetail() {
      return Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              child: ClipPath(
                clipper: OvalTopBorderClipper(),
                child: Container(
                  child: SizedBox(
                    width: size.width,
                    child: FlatButton(
                        onPressed: () {
                          setState(() {
                            if (readOnly) {
                              readOnly = false;
                            } else {
                              readOnly = true;
                            }
                          });
                        },
                        child: Text('Update')),
                  ),
                  width: size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.blue[700],
                      Colors.blue[800],
                      Colors.blue[900],
                    ]),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  CustomTag(
                    padding: EdgeInsets.all(2),
                    color: Colors.blue,
                    text: Text(
                      widget.data.id,
                      style: TextStyle(fontSize: 12),
                    ),
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
                              controller: _supervisorController,
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
                    height: 80,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget _uploadButton() {
      return RaisedButton(
        color: Theme.of(context).buttonColor,
        onPressed: !upload
            ? null
            : () {
                _bloc.add(UploadGroupworkProfileImage(
                    groupId: widget.data.id, image: _image));
              },
        child: Text("Upload"),
      );
    }

    Widget _buildAvatar() {
      return Center(
        child: CircleAvatar(

          radius: 70,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
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
                                image: new FileImage(_image),
                                fit: BoxFit.cover)),
                        child: Container(
                            alignment: FractionalOffset.bottomCenter,
                            child: Text(""))),
                  ),
          ),
        ),
      );
    }

    _fabOnPressed() {
      Map<String, dynamic> data = {
        "group_id": widget.data.id,
        "supervisor": _supervisorController.text,
        "description": _descriptionController.text,
        "course": _courseController.text.toUpperCase(),
        "supervisor":_supervisorController.text,
      };

      _bloc.add(UpdateGroupworkProfileEvent(data: data));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Groupwork Profile"),
        elevation: 8.00,
      ),
      body: BlocListener(
        bloc: _bloc,
        listener: (context, state) {
          if (state is UploadingProfileImageState) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("Image is Uploading"),
              ),
            );
          }
          if (state is UploadedProfileImageState) {
            Scaffold.of(context).removeCurrentSnackBar();
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("Image is Uploaded"),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 80,
                    ),
                    Card(
                      elevation: 1.00,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 90,
                          ),
                          _buildProfileDetail(),
                        
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(top: 20), child: _buildAvatar()),
              ],
            ),
          ),
        ),
      ),
      endDrawer: GroupworkProfileDrawerView(data: widget.data,),
      floatingActionButton: readOnly
          ? null
          : FloatingActionButton(
              onPressed: _fabOnPressed,
              child: Icon(Icons.check),
            ),
    );
  }
}
