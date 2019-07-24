import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';

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

    _onLoginButtonPressed() {
      _loginBloc.dispatch(LoginButtonPressed(
        email: _usernameController.text,
        password: _passwordController.text,
      ));
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
      child: BlocBuilder<LoginEvent, LoginState>(
        bloc: _loginBloc,
        builder: (
          BuildContext context,
          LoginState state,
        ) {
          return Card(
            borderOnForeground: true,
            child: Padding(
              padding: EdgeInsets.all(9.0),
              child: Form(
                child: ListView(
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.black12,
                      child: new Image.asset("assets/images/logo.png",width:600,height:100),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        ),
        
                      controller: _usernameController,
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                       ),
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    SizedBox(height: 30),
                    InkWell(
                    
                      onTap: state is! LoginLoading ? _onLoginButtonPressed : null,
                      child: new Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent[500],
                          border: Border.all(color: Colors.white,width: 2.0),
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: new Center(child: Text("Login"),),
                      ),
                    ),
    
                    Container(
                      child: state is LoginLoading
                          ? new CircularProgressIndicator()
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}