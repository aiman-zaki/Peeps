import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/bloc/profile_bloc.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/screens/common.dart';
import 'package:peeps/screens/splash_page.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key key}) : super(key: key);

  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _formKey = GlobalKey();
  ProfileBloc _bloc;
  @override
  void initState() {
    _bloc = BlocProvider.of<ProfileBloc>(context);
    super.initState();
  }

  Widget _profileForm(UserModel data){

   return Builder(
     builder: (context) => Form(
       key: _formKey,
       child: Column(
         children: <Widget>[
           Text(data.fname),
           Text(data.lname)
         ],
       )
     ),
   );
  }

  Widget _buildAvatar(){
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 70,
      child: Image.asset("assets/images/male.png",width:600,height:100),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Hero(tag:'profiletag',child: Material(child:Text("Profile"),type: MaterialType.transparency,),),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
              child: _buildAvatar(),
            ),
            
            Container(
              child: BlocBuilder<ProfileEvent,ProfileState>(
                bloc: _bloc,
                builder: (BuildContext context, ProfileState state){
                  if(state is InitialProfileState){
                    _bloc.dispatch(LoadProfile());
                    return CircularProgressIndicator();
                  }
                  if(state is ProfileLoading){
                    return CircularProgressIndicator();
                  }
                  if(state is ProfileLoaded){
                    return _profileForm(state.data);
                  }
                },

              ),
            )
          ],
        )
      ),
    );
  }
}