import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
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
  final _fnameController = TextEditingController();

  @override
  void initState() {
    _bloc = BlocProvider.of<ProfileBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    Widget _buildBody(UserModel data){
       _fnameController.text = data.fname;
      return Container(
        padding: EdgeInsets.all(9),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9)
                    )
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9)
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    Widget _buildAvatar(){
      return CircleAvatar(
        backgroundColor: Colors.white,
        radius: 50,
        child: Image.asset("assets/images/male.png",width:600,height:100),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).backgroundColor,
        title:  Text("Profile")
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 30),
                Container(
                  child: _buildAvatar(),
                ),
                SizedBox(height: 30),
                Container(
                  child: BlocBuilder<ProfileBloc,ProfileState>(
                    bloc: _bloc,
                    builder: (BuildContext context, ProfileState state){
                      if(state is InitialProfileState){
                        return CircularProgressIndicator();
                      }
                      if(state is ProfileLoading){
                        return CircularProgressIndicator();
                      }
                      if(state is ProfileLoaded){
                        return _buildBody(state.data);
                      }
                    },

                  ),
                )
              ],
            ),
          ],
        )
      ),
    );
  }
}