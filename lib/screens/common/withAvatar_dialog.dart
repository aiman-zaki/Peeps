import 'package:flutter/material.dart';
import 'package:peeps/screens/common/widget_conf.dart';


class DialogWithAvatar extends StatelessWidget {

   final Widget avatarIcon;

   final Widget title; 
   final String description;
   final Widget bottomLeft;
   final Widget bottomRight;
   final double width;
   final double height;
   final List<Widget> children;
  
  const DialogWithAvatar({Key key, @required this.avatarIcon,this.title, this.description, this.children, this.bottomLeft,this.bottomRight, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final List<Widget> body = [];


  if(title != null){
    body.add(
      Padding(
        padding: titlePadding,
        child: title
        
      )
    );
  }

  if(description != null){
    body.add(
      Padding(
        padding: descriptionPadding,
        child: Text(description),
      )
    );
  }

  if(children != null){
    body.add(
      Container(
        padding: EdgeInsets.only(left: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      )
    );
  } else {
    body.add(Expanded(child: Container(),));
  }


  if(bottomLeft != null || bottomRight != null){
    body.add(
      Container(
        padding: EdgeInsets.all(6),
        child: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.bottomLeft,
                child: bottomLeft == null ? FlatButton(child: Text("Cancel"), onPressed: (){Navigator.of(context).pop();},) : bottomLeft,
            ),
            Align(
                alignment: Alignment.bottomRight,
                child:  bottomRight == null ? Text('') :bottomRight,
            ),
  
          ],
        ),
      )
    );
  }

    Widget _buildBody(){
      return Container(
        width: width,
        height: height == null ? 210 : height,
        padding: EdgeInsets.only(
          top: 30,
          left: 10,
          right: 10,
        ),
        margin: EdgeInsets.only(top: 15),
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).cardColor,
          shape: BoxShape.rectangle,
        ),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: body,
          ),
      ),
      );
    }
    Widget _buildCircleTop(){
      return Positioned(
        right: 16,
        left: 16,
        child: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          radius: 20,
          child: avatarIcon,
        ),
      );
    }
    return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              _buildBody(),
              _buildCircleTop(),
            ],
          ),
        ),
    );
  }
}