import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/screens/common/custom_search.dart';

class InviteMembersView extends StatefulWidget {
  InviteMembersView({Key key}) : super(key: key);

  _InviteMembersViewState createState() => _InviteMembersViewState();
}

class _InviteMembersViewState extends State<InviteMembersView> {
 
@override
Widget build(BuildContext context) {
  final _membersBloc = BlocProvider.of<MembersBloc>(context);
  List datas = [];

  List _dataFromState(){
    var currentState = _membersBloc.currentState;
    if(currentState is LoadedSearchedUserResult){
        return currentState.data;
    } else {
      return [];
    }
  }

  datas = _dataFromState();
  
  Widget _listViewChild(data){
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(Icons.access_alarm)),
        trailing: Icon(Icons.add),
        title: Text(data.email),
      ),
    );
  }

  _searchInput(String searchIn){
    _membersBloc.dispatch(SearchButtonClicked(search: searchIn));    
  }

  _showLoadingDialog(){
    showDialog(
      context: context,
      builder: (context){
        return SimpleDialog(
          children: <Widget>[
            Center(child: CircularProgressIndicator(),),
          ],
        );
      }
    );
  }

  return Scaffold(
    appBar: AppBar(
      title: Text("Invite Members"),
    ),
    backgroundColor: Theme.of(context).backgroundColor,
    body: BlocListener(
      bloc: _membersBloc,
      listener: (context,state){
        if(state is LoadingSearchedResult)
          _showLoadingDialog();
        if(state is LoadedSearchedUserResult){
            Navigator.pop(context);
            setState(() {
              
            });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomSearch(
            searchInput: _searchInput,
            data: datas,
            listViewChild: _listViewChild,
            textInputLabel: "Email/Name",
          ),
        ),
      ),
    );
  }
}