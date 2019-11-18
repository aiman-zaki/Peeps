import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/resources/stash.dart';
import 'package:peeps/screens/common/common_profile_picture.dart';
import 'package:peeps/screens/groupwork/stash/references.dart';
import 'package:peeps/screens/splash_page.dart';

class CollaborateGroupworksView extends StatefulWidget {
  CollaborateGroupworksView({Key key}) : super(key: key);

  @override
  _CollaborateGroupworksViewState createState() => _CollaborateGroupworksViewState();
}

class _CollaborateGroupworksViewState extends State<CollaborateGroupworksView> {
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<CollaborateGroupworkBloc>(context);
      final size = MediaQuery.of(context).size;
      Widget _buildAvatar(GroupworkModel groupwork){
      return Container(
        padding: EdgeInsets.all(2.00),
        child: CustomNetworkProfilePicture(
          width: size.width,
          bottomRadius: 0,
          topRadius: 10,
          image: groupwork.profilePicturerUrl,
          child: Center(child: Text(groupwork.name),),
        ),
      );
    }

    Widget _buildGroupworksList(List<GroupworkModel> data){
      return Container(
   
        child: GridView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index){
            return Card(
              child: Slidable(
                direction: Axis.vertical,
                actionPane: SlidableBehindActionPane(),
                secondaryActions: <Widget>[
                      IconSlideAction(
                        icon: Icons.assignment,
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => BlocProvider(
                                builder: (context) => ReferenceBloc(stashRepository: StashRepository(data: data[index].id))
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
                child: Container(
                  
                  child: Column(
                    children: <Widget>[
                      _buildAvatar(data[index])
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }

    _buildGroupworkszList(List<GroupworkModel> groupworks){
      return Container(
        child: ListView.builder(
          itemCount: groupworks.length,
          itemBuilder: (context,index){
            return Card(
              child: Slidable(
                direction: Axis.vertical,
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
                    /*Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => MultiBlocProvider(
                          providers: [
                            BlocProvider<ReferenceBloc>(builder: (context) => ReferenceBloc(stashRepository: StashRepository(data: groupworks[index].id)),)
                          ],
                          child: PublicGroupworkProfileView(data: groupworks[index],)),
                      )
                    );*/
                  },
                ),
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