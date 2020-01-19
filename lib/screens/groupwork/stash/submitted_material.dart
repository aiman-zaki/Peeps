import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/screens/common/webviewexporer.dart';
import 'package:flutter/services.dart';

class SubmittedMaterialView extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  SubmittedMaterialView({Key key,@required this.scaffoldKey}) : super(key: key);

  @override
  _SubmittedMaterialViewState createState() => _SubmittedMaterialViewState();
}

class _SubmittedMaterialViewState extends State<SubmittedMaterialView> {
  @override
  Widget build(BuildContext context) {
    final _assignmentBloc = BlocProvider.of<AssignmentBloc>(context);

    _buildMaterialSubmitted(data){
      print(data);
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context,index){
          if(data[index].assignmentLink != null){
            return Card(
              child: ListTile(
                title: Text(data[index].title),
                trailing: Text(DateFormat.yMd().add_jm().format(data[index].submittedDate)),
                subtitle: data[index].assignmentLink.contains(new RegExp(r'(http.)'))
                ? InkWell(
                  child: Text("click to view or hold to copy : ${data[index].assignmentLink}"),
                  onLongPress: (){
                    Clipboard.setData(new ClipboardData(text: data[index].assignmentLink));
                    widget.scaffoldKey.currentState.showSnackBar(new SnackBar(
                      content: Text("Copied to clipboard"),
                    ));
                  },
                  onTap: (){
                    Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => WebViewExplorer(url: data[index].assignmentLink,),
                        fullscreenDialog: true,
                      )
                    );
                  },
                )
                : Text(data[index].assignmentLink),
              ),
            );
          }
          return Container();
        },
      );
    }
    
    return BlocBuilder(
      bloc: _assignmentBloc,
      builder: (context,state){
        if(state is LoadingAssignmentState){
          return Center(child: CircularProgressIndicator(),);
        }
        if(state is LoadedAssignmentState){
          return _buildMaterialSubmitted(state.data);
        }
      },
    );
  }
}