import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/screens/common/tag.dart';
import 'package:peeps/screens/splash_page.dart';


class BulletinBoardView extends StatefulWidget {
  final bool isAdmin;
  BulletinBoardView({Key key,@required this.isAdmin}) : super(key: key);

  @override
  _BulletinBoardViewState createState() => _BulletinBoardViewState();
}

class _BulletinBoardViewState extends State<BulletinBoardView> {
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<AdminBulletinBoardBloc>(context);
    _buildBulletinBoard(data){
      if(data.isEmpty){
        return Center(child: Text("No News from the Admin"),);
      }
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context,index){
          return ExpandablePanel(
            tapBodyToCollapse: true,
            header: InkWell(
              onLongPress: widget.isAdmin? (){
                _bloc.add(DeleteBulletinEvent(data: data[index]));
              } : null,
              child: CustomTag(color: Colors.cyan[900],padding: EdgeInsets.all(9),text: Text(data[index].title,style: TextStyle(fontSize: 18))),
            ),
            expanded: Card(
              child: Container(
                padding: EdgeInsets.all(9),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data[index].body),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: <Widget>[
                        Expanded(child: Text(data[index].email)),
                        Expanded(child: Text(DateFormat.yMd().add_jm().format(data[index].createdDate).toString())),

                      ],),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: BlocBuilder(
        bloc: _bloc,
        builder: (context,state){
          if(state is InitialAdminBulletinBoardState){
            return SplashScreen();
          }
          if(state is LoadingAdminBulletinBoardState){
            return Center(child: CircularProgressIndicator(),);
          }
          if(state is LoadedAdminBulletinBoardState){
            return _buildBulletinBoard(state.data);
          }
        },
      ),
    );
  }
}