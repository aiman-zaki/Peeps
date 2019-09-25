import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/bloc/user/profile_form/profile_form_bloc.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/screens/common/common_profile_picture.dart';
import 'package:peeps/screens/common/custom_stack_background.dart';
import 'package:peeps/screens/common/custom_stack_front.dart';
import 'package:peeps/screens/common/withAvatar_dialog.dart';

class AccountView extends StatefulWidget{
  final UserModel data;
  
  const AccountView({
    this.data,
  });

  @override
  AccountViewState createState() => AccountViewState();
}


class AccountViewState extends State<AccountView> {
  bool edit = true;
  bool updatePicture = false;
  File _image;
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _programmeController = TextEditingController();

  Future _getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      updatePicture = true;
    });
  }


  @override
  void initState() {
    super.initState();
    _fnameController.text = widget.data.fname;
    _lnameController.text = widget.data.lname;
    _phoneController.text = widget.data.contactNo;
    _programmeController.text = widget.data.programmeCode;
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<ProfileFormBloc>(context);
    final _profileBloc = BlocProvider.of<ProfileBloc>(context);
    
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    
    _upload(){
      _bloc.dispatch(UploadProfilePictureEvent(image:_image,userId: widget.data.id));
    }

    _buildBlocListenerDialog({@required icon,@required children}){
      return DialogWithAvatar(
        avatarIcon: icon,
        title: "",
        width: 300,
        height: 180,
        children: children,
      );
    }
    
    _fabOnPressed(){
      if(edit == false){
        return (){
            Map<String,dynamic> data = {
              "fname":_fnameController.text,
              "lname":_lnameController.text,
              "contactNo":_phoneController.text,
              "programmeCode":_programmeController.text,
            };

            setState(() {
              _bloc.dispatch(UpdateProfileEvent(data: data));
              edit = true;
            });
        };
      } else {
        return null;
      }
    }

    Widget _fab(){
      return AnimatedOpacity(
        opacity: !edit ? 1.0 :0.0,
        duration: Duration(milliseconds: 200),
        child: FloatingActionButton(
          tooltip: "Update Profile",
          child: Icon(Icons.check),
          onPressed: _fabOnPressed()
        ),
      );
    }

    Widget _buildOtherSettingList(){
      return ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          ListTile(
            onTap: (){
              setState(() {
                edit = false;
              });
            },
            leading: Icon(Icons.edit),
            title: Text('Edit Profile'),
          ),            
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Privacy'),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            leading: Icon(Icons.fiber_smart_record),
            title: Text('Record | Achievement'),
            trailing: Icon(Icons.keyboard_arrow_right),
          )
        ],
      );
    }

    _readOnlyFormField({String labelText,String data,TextEditingController controller}){
      return TextField(
        controller: controller,
        readOnly: edit,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(9))
          )
        ),
      );
    }

    Widget _buildBody(){
      return Container(
        padding: EdgeInsets.all(9),
        width: width,
        child: Column(
          children: [
            Text(widget.data.email,style: TextStyle(fontSize: 20),), 
            SizedBox(height: 20,),
            _readOnlyFormField(data: widget.data.fname,labelText: "First Name",controller: _fnameController),
            SizedBox(height: 20,),
            _readOnlyFormField(data: widget.data.lname,labelText: "Last Name",controller: _lnameController),
            SizedBox(height: 20,),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: _readOnlyFormField(data: widget.data.contactNo,labelText: "Contact No",controller: _phoneController)),
                SizedBox(width: 10,),
                Expanded(
                  flex: 2,
                  child: _readOnlyFormField(data: widget.data.programmeCode, labelText: "Programme Code",controller: _programmeController)),
              ],
            ),
            SizedBox(height: 20,),
            _buildOtherSettingList(),
        ]),
      );
    }

    //TODO : Default Picture
    Widget _buildAvatar(){
      return CircleAvatar(
        backgroundColor: Colors.white,
        radius: 70,
        child: _image == null ?
          CustomNetworkProfilePicture(
            image: widget.data.picture,
            onTap: _getImage,
            child: Container(alignment: FractionalOffset.bottomCenter,child: Text(""),),
          ):
          InkWell(
            onTap: _getImage,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(120),
                image: DecorationImage(
                  image: new FileImage(_image),
                  fit: BoxFit.cover
                )
              ),
              child: Container(alignment: FractionalOffset.bottomCenter, child:Text(""))),
          ),  
      );
    }

    _buildFrontBody(){
      return Column(
        children: <Widget>[
        
          SizedBox(height: 10,),
          _buildAvatar(),
          FlatButton(
            onPressed: updatePicture == false ?
              null :
              _upload, 
            child: Text("Upload"),
          ),
          _buildBody(),
        ],  
      );
    }

    _buildBackgroundColor(){
      return Positioned(
        top: 20,
        child: CustomStackBackground(
          color: Colors.blue[600],
          width: width,
          height: height*0.8,
          child: Container(),
        ),
      );
    }

    return BlocListener(
      bloc: _bloc,
      listener: (context,state){
        if(state is UpdatingProfileState){
          showDialog(
            context: context,
            builder: (context){
              return _buildBlocListenerDialog(
              icon: Icon(Icons.check_circle_outline),
              children: [
                Center(child: CircularProgressIndicator(),)
              ]);
            }
          );
        }
        if(state is PopState){
          Navigator.pop(context);
        }
        if(state is UpdatedProfileState){
          showDialog(
            context: context,
            builder: (context){
              return _buildBlocListenerDialog(
                icon: Icon(Icons.check),
                children: [
                  Center(
                    child: Text("Updated",style: TextStyle(
                      fontSize: 18
                    ),),
                  ),
                ]);
            }
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 5.00,
          centerTitle: true,
          title: Text('Account'),
        ),
        floatingActionButton: _fab(),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[ 
              _buildFrontBody(),
            ],
          ),
        ),
      ),
    );    
  }
}