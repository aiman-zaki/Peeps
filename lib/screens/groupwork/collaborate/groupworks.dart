import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/resources/stash.dart';
import 'package:peeps/screens/groupwork/stash/references.dart';
import 'package:peeps/screens/splash_page.dart';

import '../public_profile.dart';


class CollaborateGroupworksView extends StatefulWidget {
  CollaborateGroupworksView({Key key}) : super(key: key);

  @override
  _CollaborateGroupworksViewState createState() => _CollaborateGroupworksViewState();
}

class _CollaborateGroupworksViewState extends State<CollaborateGroupworksView> {
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<CollaborateGroupworkBloc>(context);

    _buildGroupworksList(List<GroupworkModel> groupworks){
      return Container(
        child: ListView.builder(
          itemCount: groupworks.length,
          itemBuilder: (context,index){
            return Slidable(
              actionPane: SlidableScrollActionPane(),
              secondaryActions: <Widget>[
                IconSlideAction(
                  icon: Icons.assignment,
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => BlocProvider(
                          builder: (context) => ReferenceBloc(stashRepository: StashRepository(data: groupworks[index].id))
                          ..add(ReadPublicReferencesEvent()),
                          child: Scaffold(
                            appBar: AppBar(title: Text("Public References"),),
                            body: Container(
                              child: ReferencesView(isPublic: true,),
                            ),
                          ),
                          
                          
                        )
                  
                      )
                    );
                  },
                  caption: "Stash",
                )
              ],
              child: ListTile(
                title: Text(groupworks[index].name),
                onTap: (){
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider<ReferenceBloc>(builder: (context) => ReferenceBloc(stashRepository: StashRepository(data: groupworks[index].id)),)
                        ],
                        child: PublicGroupworkProfileView(data: groupworks[index],)),
                    )
                  );
                },
              ),
            );
          },
        ),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Groupworks"),
      ),
      body: Container(
        child: BlocBuilder(
          bloc: _bloc,
          builder: (context,state){
            if(state is InitialCollaborateGroupworksState){
              return SplashScreen();
            }
            if(state is LoadingCollaborateGroupworksState){
              return Center(child: CircularProgressIndicator(),);
            }
            if(state is LoadedCollaborateGroupworksState){
              return _buildGroupworksList(state.data);
            }
          },
        ),
      ),
    );
  }
}