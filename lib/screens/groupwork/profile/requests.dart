import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/bloc/groupwork/request/request_bloc.dart';

class GroupRequest extends StatefulWidget {
  final groupId;
  GroupRequest({
    Key key,
    @required this.groupId,
    }) : super(key: key);

  _GroupRequestState createState() => _GroupRequestState();
}

class _GroupRequestState extends State<GroupRequest> {
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<RequestBloc>(context);

    _buildRequest(request){
      return Card(
        child: ListTile(
          title: Text(request.email),
          trailing: RaisedButton(
            child: Text("Confirm"),
            onPressed: (){
              request.answer = true;
              _bloc.add(AnswerButtonClicked(data: request.toJson(), groupId: widget.groupId));
            },
          ),
        ),
      );
    }

    _buildRequestsList(requests){
      return Container(
        child: ListView.builder(
          itemCount: requests.length,
          itemBuilder: (context,index){
            return _buildRequest(requests[index]);
          },
        ),

      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Request"),
      ),
      body: BlocBuilder<RequestBloc,RequestState>(
        bloc: _bloc,
        builder: (context,state){
          if(state is InitialRequestState){
            _bloc.add(LoadRequestsEvent(data: {
              "group_id":widget.groupId,
            }));
            return Container();
          }
          if(state is LoadingRequestsState){
            return Center(child: CircularProgressIndicator(),);
          }
          if(state is LoadedRequestsState){
            return _buildRequestsList(state.data);
          }
        },
      ),
    );
  }
}