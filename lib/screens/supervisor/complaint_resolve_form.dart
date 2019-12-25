import 'package:flutter/material.dart';
import 'package:peeps/enum/action_complaint_enum.dart';
import 'package:peeps/models/complaint.dart';


class ComplaintResolveFormView extends StatefulWidget {
  ComplaintResolveFormView({Key key,@required this.complaint}) : super(key: key);

  final ComplaintModel complaint;

  @override
  _ComplaintResolveFormViewState createState() => _ComplaintResolveFormViewState();
}

class _ComplaintResolveFormViewState extends State<ComplaintResolveFormView> {
  bool consult = false;
  bool deduction = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complaint Detail"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(9),
          child: Column(
            children: <Widget>[
              TextFormField(initialValue: widget.complaint.by,decoration: InputDecoration(labelText: "By"),readOnly: true,),
              SizedBox(height: 10,),
              TextFormField(initialValue: widget.complaint.who,decoration: InputDecoration(labelText: "Who"),readOnly: true,),
              SizedBox(height: 10,),
              TextFormField(initialValue: widget.complaint.title,decoration: InputDecoration(labelText: "Title"),readOnly: true,),
              TextFormField(minLines:5,maxLines:5,initialValue: widget.complaint.description,decoration: InputDecoration(labelText: "Description"),readOnly: true,),
              SizedBox(height: 10,),
              Row(
                children: <Widget>[
                  Expanded(child: Text("${getActionComplaintEnumString(ActionComplaint.consult)}"),),
                  Expanded(child: Checkbox(value: consult, onChanged: (bool value) {
                    setState(() {
                      consult = value;
                    });
                  },),),
                  Expanded(child: Text("${getActionComplaintEnumString(ActionComplaint.deduction)}"),),
                  Expanded(child: Checkbox(value: deduction, onChanged: (bool value) {
                    setState(() {
                      deduction = value;
                    });
                  },),),
                ],
              ),
              deduction ? 
              TextFormField(decoration: InputDecoration(labelText: "Marks Deducted"),) :
              Container(),
          ]),
        ),
      ),
    );
  }
}