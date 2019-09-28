import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/screens/common/captions.dart';
import 'package:peeps/screens/common/common_profile_picture.dart';

import '../profile/groupwork_profile.dart';

class HubHeader extends StatelessWidget {
  final isAdmin;
  final groupData;

  const HubHeader({Key key, @required this.groupData, this.isAdmin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _groupProfileBloc = BlocProvider.of<GroupProfileBloc>(context);
    final _membersBloc = BlocProvider.of<MembersBloc>(context);
    final size = MediaQuery.of(context).size;

    return BlocListener(
      bloc: _groupProfileBloc,
      listener: (context,state){
        if(state is UpdatedAdminRoleState){
          _membersBloc.dispatch(LoadMembersEvent(groupId: groupData.id));
        }
        if(state is DeletedMemberState){
          _membersBloc.dispatch(LoadMembersEvent(groupId: groupData.id));
        }
      },
      child: Container(
        padding: EdgeInsets.all(18),
        width: size.width,
        height: 250,
        child: Center(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                  value: _groupProfileBloc,
                                  child: BlocProvider.value(
                                    value: _membersBloc,
                                    child: GroupworkProfile(
                                      isAdmin: isAdmin,
                                      data: groupData,
                                    ),
                                  )),
                              fullscreenDialog: true),
                        );
                      },
                      child: Hero(
                        tag: 'dp',
                        child: CircleAvatar(
                          radius: 60,
                          child: CustomNetworkProfilePicture(
                            heigth: 110.00,
                            width: 110.00,
                            image: groupData.profilePicturerUrl,
                            child: Container(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: Text(
                      groupData.name,
                      style: TextStyle(fontSize: 23),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomCaptions(
                    text: groupData.id,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
