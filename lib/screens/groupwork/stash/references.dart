import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/groupwork/bloc.dart';
import 'package:peeps/enum/publicity_enum.dart';
import 'package:peeps/screens/common/webviewexporer.dart';
import 'package:peeps/screens/groupwork/stash/reference_form.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReferencesView extends StatelessWidget {
  final bool isPublic;
  const ReferencesView(
    { 
      Key key,
      @required this.isPublic,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<ReferenceBloc>(context);

    _buildReferencesList(data){
      if(data != null){
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context,index){
            return ListTile(
              title: Text(data[index].title),
              trailing: Text(getPublicityEnumString(data[index].publicity)),
              subtitle: data[index].reference.contains(new RegExp(r'(http.)'))
              ? InkWell(
                child: Text(data[index].reference),
                onTap: (){
                  Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => WebViewExplorer(url: data[index].reference,),
                      fullscreenDialog: true,
                    )
                  );
                },
              )
              : Text(data[index].reference),
            );
          },
        );
      } else {
        return Container(
          child: Text("No Data"),
        );
      }
    
    }


    return Scaffold(
      floatingActionButton: !isPublic ? FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => BlocProvider.value(
                value: _bloc,
                child: ReferenceFormView())
            )
          );
        },
        child: Icon(Icons.add),
      ) : Container(),
      body: RefreshIndicator(
        onRefresh: () async {
          !isPublic ? _bloc.add(ReadReferencesEvent()) : _bloc.add(ReadPublicReferencesEvent());
        },
        child: BlocBuilder<ReferenceBloc,ReferenceState>(
          bloc: _bloc,
          builder: (context,state){
            if(state is InitialReferenceState){
              if(!isPublic)
                _bloc.add(ReadReferencesEvent());
              else
                _bloc.add(ReadPublicReferencesEvent());
              return Container();
            }
            if(state is LoadingReferenceState){
              return Center(child: CircularProgressIndicator(),);
            }
            if(state is LoadedReferenceState){
              if(state.data.isEmpty){
                return Center(child: Text("No Data is presented"),);
              }
              return _buildReferencesList(state.data);
            }
          },
        ),
      ),
    );
  }
}