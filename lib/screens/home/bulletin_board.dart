import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
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
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context,index){
          return Card(child: 
            ListTile(
              onLongPress: widget.isAdmin? (){
                _bloc.add(DeleteBulletinEvent(data: data[index]));
              } : null,
              title: Text(data[index].title),),);
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