import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/groupwork/bloc.dart';
import 'package:peeps/screens/common/webviewexporer.dart';
import 'package:peeps/screens/groupwork/stash/reference_form.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReferencesView extends StatelessWidget {
  const ReferencesView({Key key}) : super(key: key);

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
              subtitle: data[index].reference.contains(new RegExp(r'(http.)'))
              ? InkWell(
                child: Text(data[index].reference),
                onTap: (){
                  Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => WebViewExplorer(url: data[index].reference,),
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
      floatingActionButton: FloatingActionButton(
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
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _bloc.add(LoadReferencesEvent());
        },
        child: BlocBuilder<ReferenceBloc,ReferenceState>(
          bloc: _bloc,
          builder: (context,state){
            if(state is InitialReferenceState){
              _bloc.add(LoadReferencesEvent());
              return Container();
            }
            if(state is LoadingReferenceState){
              return Center(child: CircularProgressIndicator(),);
            }
            if(state is LoadedReferenceState){
              return _buildReferencesList(state.data);
            }
          },
        ),
      ),
    );
  }
}