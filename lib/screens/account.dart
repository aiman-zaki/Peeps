import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/screens/profile.dart';

class AccountView extends StatelessWidget {
  final UserModel data;
  const AccountView({Key key,@required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;

      Widget _buildOtherSettingList(){
        return ListView(
          shrinkWrap: true,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Update Profile'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),            
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Privacy'),
              trailing: Icon(Icons.keyboard_arrow_right),
            )
          ],
        );
      }

      _readOnlyFormField({String labelText,String data}){
        return TextField(
          controller: new TextEditingController(text: data),
          readOnly: true,
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
              Text(data.email,style: TextStyle(fontSize: 20),), 
              SizedBox(height: 20,),
              _readOnlyFormField(data: data.fname,labelText: "First Name"),
              SizedBox(height: 20,),
              _readOnlyFormField(data:data.lname,labelText: "Last Name"),
              SizedBox(height: 20,),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: _readOnlyFormField(data:data.contactNo,labelText: "Contact No")),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 2,
                    child: _readOnlyFormField(data:data.programmeCode, labelText: "Programme Code")),
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

    
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          elevation: 0.00,
          backgroundColor: Theme.of(context).backgroundColor,
          centerTitle: true,
          title: Text('Account'),
        ),
        body: Container(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 20,
                width: width,
                height: height*0.8,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  color: Colors.blue[600],
                  child: Text(""),
                ),
              ),
              Positioned(
                width: width,
                height: height,
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Card(
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
      );
      
    }
}