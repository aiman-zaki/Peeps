import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/complaint.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/models/member.dart';
import 'package:peeps/screens/common/withAvatar_dialog.dart';


class MemberReportView extends StatefulWidget {
  final GroupworkModel groupwork;
  final MemberModel member;
  MemberReportView({Key key,
    @required this.groupwork,
    @required this.member}) : super(key: key);

  @override
  _MemberReportViewState createState() => _MemberReportViewState();
}

class _MemberReportViewState extends State<MemberReportView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _currentUser;
  String assignmentId;

  @override 
  void initState() {
    super.initState();
    _currentUser = (BlocProvider.of<ProfileBloc>(context).state as ProfileLoaded).data.email;
  }

  @override
  Widget build(BuildContext context) {
    final _assignmentBloc = BlocProvider.of<AssignmentBloc>(context);
    final _complaintBloc = BlocProvider.of<ComplaintBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Complaint"),
      ),
      body: BlocListener(
        bloc: _complaintBloc,
        listener: (context,state){
          if(state is MessageComplaintsState){
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
            ));
          }
        },
        child: Container(
          padding: EdgeInsets.all(9),
          child: Form(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    initialValue: widget.member.email,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Email"
                    ),
                  ),
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: "Title"
                    ),
                  ),
                  TextFormField(
                    minLines: 5,
                    maxLines: 5,
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: "Description"
                    ),
                  ),
                  BlocBuilder(
                    bloc: _assignmentBloc,
                    builder: (context,state){
                      if(state is LoadedAssignmentState){
                        return Row(
                          children: <Widget>[
                            DropdownButton(
                              items: state.data.map((assignment){
                                return DropdownMenuItem(
                                  child: Text(assignment.title),
                                  value: assignment.id,
                                );
                              }).toList(), 
                              value: assignmentId,
                              onChanged: (String value) {
                                setState(() {
                                  assignmentId = value;
                                });
                              },
                            ),
                          ],
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: (){
          showDialog(
            context: context,
            builder: (context){
              return DialogWithAvatar(
                height: 190,
                avatarIcon: Icon(Icons.check),
                title: Text("Confirmation"),
                description: "Are you sure want to file complaint? You supervisor can take action [mark deduction]",
                children: <Widget>[],
                bottomRight: FlatButton(
                  child: Text("Complaint"),
                  onPressed: (){
                    _complaintBloc.add(CreateComplaintEvent(data: 
                      ComplaintModel(
                        id: "",
                        title: _titleController.text,
                        description: _descriptionController.text,
                        who:widget.member.email,
                        createdDate: DateTime.now(),
                        resolvedDate: null,
                        by: _currentUser,
                        assignmentId: assignmentId,
                    )));
                    Navigator.of(context).pop();

                  },
                ),
              );
            }
          );
        },
      ),
    );
  }
}