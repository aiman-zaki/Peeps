import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/enum/publicity_enum.dart';
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
  Publicity _publicityValue = Publicity.private;

  _generatePublicityDropdown(){
    List<DropdownMenuItem<Publicity>> dropdowns = [];
    for(int i = Publicity.private.index; i <= Publicity.public.index; i++){
        dropdowns.add(
          DropdownMenuItem(
            child: Text(getPublicityEnumString(Publicity.values.elementAt(i))),
            value: Publicity.values.elementAt(i),
          )
        );
    }
    return dropdowns;
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<ReferenceBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Reference Form"),
      ),
      body: BlocListener(
        bloc: _bloc,
        listener: (context,state){
          if(state is MessageReferenceState){
            return Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.message),));
          }
        },
        child: SingleChildScrollView(
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
                  ),

                  DropdownButton<Publicity>(
                    value: _publicityValue,
                    items: _generatePublicityDropdown(),
                    onChanged: (Publicity value){
                      setState(() {
                        _publicityValue = value;                      
                      });                    
                    },
                  )
                ],
              ),
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
                  publicity: _publicityValue
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