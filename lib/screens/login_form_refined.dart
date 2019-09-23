import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/resources/users_repository.dart';
import 'package:peeps/screens/common/common_profile_picture.dart';
import 'package:peeps/screens/register_form.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);
    var size = MediaQuery.of(context).size;
    _onLoginButtonPressed() {
      _loginBloc.dispatch(LoginButtonPressed(
        email: _usernameController.text,
        password: _passwordController.text,
      ));
    }

    _buildBody(){
      return Column(
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: "email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
          )
        ],
      );
    }

    _buildHeader(){
      return Positioned(
        child: Container(
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CustomNetworkProfilePicture(
                width: size.width*0.8,
                heigth: 120,
                bottomRadius: 0,
                image: "http://192.168.43.112:5000/static/logo",
              ),
              SizedBox(height: 10,),
              Text("Welcome back peeps!",style: TextStyle(fontSize: 24),),
              SizedBox(height: 10,),
              Text("Login back to Your Account."),
              SizedBox(height: 50,),
              _buildBody(),
            ],
          ),
        ),
      );
    }

    return BlocListener(
      bloc: _loginBloc,
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
      
            _buildHeader(),
          ],
        ),
      ) 
    );
  }
}