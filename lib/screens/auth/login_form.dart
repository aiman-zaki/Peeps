import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/bloc/user/login/login_bloc.dart';
import 'package:peeps/bloc/user/login/login_state.dart';
import 'package:peeps/resources/auth_repository.dart';
import 'package:peeps/resources/users_repository.dart';
import 'package:peeps/screens/common/common_profile_picture.dart';
import 'register_form.dart';
import 'package:peeps/resources/common_repo.dart';
class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String _validateEmail(String value){
    Pattern pattern = (r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    RegExp regex = new RegExp(pattern);
    if(value.isEmpty){
      return 'Please Enter your email';
    } else {
      if(!regex.hasMatch(value))
        return 'Enter valind email';
      else
        return null;
    }
  
  }

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);
    var size = MediaQuery.of(context).size;
    _onLoginButtonPressed() {
      _loginBloc.add(LoginButtonPressed(
        email: _usernameController.text,
        password: _passwordController.text,
      ));
    }

    _buildBody(state) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          autovalidate: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _usernameController,
                validator: ((value){
                  return _validateEmail(value);
                }),
                decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                elevation: 12.00,
       
                padding: EdgeInsets.all(15),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                onPressed: state is LoginLoading? null : _onLoginButtonPressed,
                child: Text("Login"),
              ),
              SizedBox(
                height: 25,
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => 
                        BlocProvider.value(value:_loginBloc,
                          child: BlocProvider(
                            create: (context) => RegisterBloc(loginBloc: _loginBloc,repository: AuthRepository()),
                            child: RegisterForm())),fullscreenDialog: true));
                    },
                    child: Text("Register new account")))
            ],
          ),
        ),
      );
    }
    

    _buildHeader(state) {
      return Positioned(
        width: size.width,
        top: 20.00,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CustomNetworkProfilePicture(
              width: size.width * 0.8,
              heigth: 120,
              image: "${domain}static/logo",
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Welcome back peeps!",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Login back to Your Account."),
            SizedBox(
              height: 25,
            ),
            _buildBody(state),
          ],
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
        child: BlocBuilder<LoginBloc,LoginState>(
          builder: (bloc,state){
          return SingleChildScrollView(
            child: Container(
              height: size.height*0.90,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    width: size.width,
                    bottom: 0,
                    child: ClipPath(
                      clipper: WaveClipperOne(reverse: true),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0,0),
                              blurRadius: 10.0,
                                color: Theme.of(context).accentColor,
                            )
                          ]
                        ),
                        height: 80,
                      
                        child: Container(),
                      ),
                    ),
                  ),
                  _buildHeader(state),
                ],
              ),
            ),
          );
        }
      )
    );
  }
}
