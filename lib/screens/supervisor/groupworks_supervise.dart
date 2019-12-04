import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/bloc/supervisor/bloc.dart';
import 'package:peeps/bloc/supervisor/groupworks_supervise/groupworks_supervise_bloc.dart';
import 'package:peeps/models/groupwork.dart';
import 'package:peeps/resources/stash.dart';
import 'package:peeps/screens/common/common_profile_picture.dart';
import 'package:peeps/screens/groupwork/stash/references.dart';
import 'package:peeps/screens/splash_page.dart';

class GroupworksSuperviseView extends StatefulWidget {
  GroupworksSuperviseView({Key key}) : super(key: key);

  @override
  _GroupworksSuperviseViewState createState() => _GroupworksSuperviseViewState();
}

class _GroupworksSuperviseViewState extends State<GroupworksSuperviseView> {

  
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<GroupworksSuperviseBloc>(context);
    final _size = MediaQuery.of(context).size;

     Widget _buildAvatar(GroupworkModel groupwork){
      return Container(
        child: CustomNetworkProfilePicture(
          width: _size.width,
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

    _buildGroupworks(List<GroupworkModel> groupworks){
      return _buildGroupworksList(groupworks);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Groupworks Supervise"),
      ),
      body: Container(
        padding: EdgeInsets.all(6),
        child: BlocBuilder(
          bloc:_bloc,
          builder: (context,state){
            if(state is InitialGroupworksSuperviseState){
              return SplashScreen();
            }
            if(state is LoadingGroupworksSuperviseState){
              return Center(child: CircularProgressIndicator(),);
            }
            if(state is LoadedGroupworksSuperviseState){
              if(state.data.isEmpty){
                return Center(child: Text("No Data"),);
              }
              return _buildGroupworks(state.data);
            }
          },
        ),
      ),
    );
  }
}