import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/screens/common/circular_fab.dart';
import 'package:peeps/screens/common/custom_search.dart';
import 'package:vector_math/vector_math.dart' show radians, Vector3;

class SearchView extends StatefulWidget {
  SearchView({Key key}) : super(key: key);

  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<SearchGroupsBloc>(context);
    List datas = [];
    
    _dataFromState(){
      var currentState = _bloc.currentState;
      if(currentState is LoadedGroupsState){
        return currentState.data;
      }
    }

    datas = _dataFromState();

    _buildRequestButton(groupwork){
      return RaisedButton(
        onPressed: (){
          Map<String,dynamic> data = {
            "group_id":groupwork.id,
            "request_date":DateTime.now().toString(),
          };
          _bloc.dispatch(RequestGrouptEvent(data: data));
        },
        child: Text("Request"),
      );
    }

    Widget _listViewChild(groupwork){
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
            title: Text(groupwork.name),
            leading: _buildRequestButton(groupwork),
          ),
        ),
      );
    }

    _searchInput(String searchIn){
      _bloc.dispatch(SearchGroupsButtonClickedEvent(data: searchIn.toUpperCase()));
    }

    _showLoadingDialog(){
      showDialog(
        context: context,
        builder: (context){
          return SimpleDialog(
            children: <Widget>[
              Center(child: CircularProgressIndicator())
            ],
          );
        }
      );
    }


    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: BlocListener(
        bloc: _bloc,
        listener: (context,state){
          if(state is LoadingGroupsState){
            _showLoadingDialog();
          }
          if(state is LoadedGroupsState){
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
            textInputLabel: "Code",
          ),
        )
      ),
    );
    
  }
}

