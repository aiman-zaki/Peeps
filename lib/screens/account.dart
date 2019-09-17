import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/bloc/user/profile_form/profile_form_bloc.dart';
import 'package:peeps/models/user.dart';
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
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _programmeController = TextEditingController();

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
        shrinkWrap: true,
        children: <Widget>[
          ListTile(
            onTap: (){
              setState(() {
                edit = false;
              });
            },
            leading: Icon(Icons.edit),
            title: Text('Update Profile'),
          ),            
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Privacy'),
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
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 20,),
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

    Widget _buildAvatar(){
      return CircleAvatar(
        backgroundColor: Colors.white,
        radius: 70,
        child: Image.asset("assets/images/male.png",width:600,height:100),
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
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          elevation: 5.00,
          backgroundColor: Theme.of(context).backgroundColor,
          centerTitle: true,
          title: Text('Account'),
        ),
        floatingActionButton: _fab(),
        body: Center(
          child: Container(
            padding: EdgeInsets.only(top:20),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 20,
                  width: width,
                  height: height*0.8,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    color: Colors.blue[600],
                    elevation: 0.00,
                    child: Text(""),
                  ),
                ),
                Positioned(
                  width: width,
                  height: height*0.85,
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Card(
                      elevation: 5.00,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      color: Colors.grey[900],
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10,),
                          _buildAvatar(),
                          _buildBody(),
                        ],  
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );    
  }
}