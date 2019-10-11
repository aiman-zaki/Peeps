import 'package:flutter/material.dart';

class CustomForm extends StatefulWidget {
  final formKey;
  final Widget mandatoryForm;
  final Widget optionalForm;
  CustomForm({Key key, this.formKey, this.mandatoryForm, this.optionalForm,}) : super(key: key);
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {




  @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.all(9),
       child: Form(
         key: widget.formKey,
         child: ListView(
           children: <Widget>[

           ],
         ),
       ),
    );
  }
}