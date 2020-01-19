import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/bulletin.dart';


class BulletinFormView extends StatefulWidget {
  BulletinFormView({Key key}) : super(key: key); 

  @override
  _BulletinFormViewState createState() => _BulletinFormViewState();
}

class _BulletinFormViewState extends State<BulletinFormView> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<AdminBulletinBoardBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Bulletin Form"),
      ),
      body: Container(
        padding: EdgeInsets.all(9),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title"
              ),
            ),
            TextFormField(
              minLines: 10,
              maxLines: 10,
              controller: bodyController,
              decoration: InputDecoration(
                labelText: "Body"
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          _bloc.add(CreateBulletinEvent(data: BulletinModel(
            id: null,
            title: titleController.text,
            body: bodyController.text,
            email: null,
            createdDate: DateTime.now(),
            updatedDate: DateTime.now(),
          )));
        },
      ),
    );
  }
}