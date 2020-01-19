import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/admin/bloc.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/screens/splash_page.dart';

class UsersListView extends StatefulWidget {
  UsersListView({Key key}) : super(key: key);

  @override
  _UsersListViewState createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<AdminUsersBloc>(context);
    
    _buildUsersList(List<UserModel> data){
      return Container(
          child: Column(
            children: <Widget>[
              Expanded(child: 
                ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context,index){
                    return Card(
                      child: ListTile(
                        title: Text(data[index].email),
                      ),
                    );
                  },
                ),)
            ],
          ),
        );
    }


    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: BlocBuilder(
        bloc: _bloc,
        builder: (context,state){
          if(state is InitialAdminUsersState){
            return SplashScreen();
          }
          if(state is LoadingAdminUsersState){
            return Center(child: CircularProgressIndicator());
          }
          if(state is LoadedAdminUsersState){
            return _buildUsersList(state.data);
          }
        },
      ),
     
    );
  }
}