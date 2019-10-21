import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/main.dart';
import 'package:peeps/models/stash.dart';
import 'package:peeps/screens/common/captions.dart';

class ReferenceFormView extends StatefulWidget {
  ReferenceFormView({Key key}) : super(key: key);

  _ReferenceFormViewState createState() => _ReferenceFormViewState();
}

class _ReferenceFormViewState extends State<ReferenceFormView> {
  final _titleController = TextEditingController();
  final _referenceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<ReferenceBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Reference Form"),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
       
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: "Title"
                  ),
                ),
                SizedBox(height: 10,),
                CustomCaptions(text: "Can be Link to the article or something",),
                TextFormField(
                  controller: _referenceController,
                  decoration: InputDecoration(
                    labelText: "Reference"
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          BlocProvider.of<ProfileBloc>(context).listen((state){
            if(state is ProfileLoaded){
              _bloc.add(CreateNewReferenceEvent(
                data: ReferenceModel(
                  id: "",
                  creator: state.data.email,
                  title: _titleController.text,
                  reference: _referenceController.text,
                  createdDate: DateTime.now(),
                )
              ));
            }
          });
        },
        child: Icon(Icons.check),
      ),
    );
  }
}