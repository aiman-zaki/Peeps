import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/bloc/user/register/register_bloc.dart';
import 'package:peeps/screens/common/custom_wave_clip.dart';
import 'package:peeps/screens/common/withAvatar_dialog.dart';


class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  File _image;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordContorller = TextEditingController();

  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<RegisterBloc>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    _buildFooterWave(){
      return ClipPath(
        clipper: CustomWaveClipper(),
        child: Container(
          height: 50,
          width: double.infinity,
          color: Colors.black,
          child: Text("as"),
        ),
      );
    }

    _buildShowLoadingWithText(String message){
      showDialog(
      
        context: context,
        builder: (context){
          return Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                CircularProgressIndicator(),
              ],
            ),
          );
        }
      );
    }

    _buildShowDialog(){
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          return Container(
            child: BlocBuilder(
              bloc: _bloc,
              builder: (context,state){
                if(state is InitialRegisterState){
                  return DialogWithAvatar(
                    title: "Registration",
                    description: "Are you sure to continue ? ",
                    children: <Widget>[
                      SizedBox(height: 15,)
                    ],
                    avatarIcon: Icon(Icons.check),
                    width: 300,
                    height: 180,
                    bottomLeft: FlatButton(
                      child: Text("Cancel"),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                    bottomRight: FlatButton(
                      onPressed: (){
                        _bloc.dispatch(RegisterButtonClickedEvent(
                          email: _emailController.text,
                          password: _passwordController.text,
                          image: _image));

                      },
                      child: Text("Confirm"),
                    ),
                  );
                }
                if(state is RegisteringUserState){
                  return Center(child: CircularProgressIndicator());
                }
                if(state is RegisteredUserState){
                  return Text("Registered");
                }
                if(state is UploadingProfileImageState){
                  return Center(child: CircularProgressIndicator(),);
                }
                if(state is UploadedProfileImageState){
                  return Text("Uploadedd");
                }
                if(state is CompletedRegisterState){
                  return DialogWithAvatar(
                    avatarIcon: Icon(Icons.account_circle),
                    title: "Update Your Profile Now?",
                    width: 300,
                    height: 180,
                    children: <Widget>[
                      SizedBox(height: 10,)
                    ],
                    bottomLeft: FlatButton(
                      child: Text("Proceed to Home"),
                      onPressed: (){
                       setState(() {
                          Navigator.pushReplacementNamed(context, '/');
                       });
                      },
                    ),
                    bottomRight: FlatButton(
                      child: Text("Yes!"),
                      onPressed: (){
                   
                      },
                    ),
                  );
                }
              },
            ),
          );
        }
      );
    }
    
    _snackbar(){
      return SnackBar(
        backgroundColor: Colors.red,
        content: Text("Password Not Match"),
      );
    }

    _buildLoginButton(){
      return Container(
        padding: EdgeInsets.all(8),
        width: width,
        child: RaisedButton(
          padding: EdgeInsets.all(15),
  
     
          onPressed: (){
            _passwordController.text == _confirmPasswordContorller.text ?
            _buildShowDialog() :
            Scaffold.of(context).showSnackBar(_snackbar());
          },
          child: Center(child: Text("Get Started")),
        )
      );
    }

    _buildBody(){
      return [
        Container(
          child: Column(
            children: <Widget>[
              Text("Welcome To Peeps !",style: TextStyle(fontSize: 25),)
            ],
          ),
        ),
        SizedBox(height: 10,),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.teal)
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.teal)
                    ),
                    labelText: "Password"
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _confirmPasswordContorller,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.blue[900])
                    ),
                    labelText: "Confirm Password"
                  ),
                ),
                SizedBox(height: 30,),
                
       
              ],
            ),
          ),
        ),
      ];
    }

    _buildAvatar(){
      return CircleAvatar(
        backgroundColor: Colors.grey[900],
        radius: 75,
        child: _image == null ? FlatButton(onPressed:_getImage,child: Text("Upload Image"),) 
          : InkWell(
            onTap: _getImage,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(120),
                image: DecorationImage(
                  image: new FileImage(_image),
                  fit: BoxFit.cover
                )
              ),
            child: Container()
            ),
          ),  
        );
    }

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.00,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height*0.90,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                child: ClipPath(
                  clipper: TriangleClipper(),
                  child: Container(
                    width: width,
                    height: 90,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: _buildAvatar(),
              ),
              Positioned(
                width: width,
                top: 160,
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Column(
                    children: _buildBody()
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                child: _buildLoginButton()),
              
            ],
          ),
        ),
      ),
    );
  }
}