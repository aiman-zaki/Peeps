import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/bloc/groupwork/bloc.dart';
import 'package:peeps/bloc/user/profile/profile_bloc.dart';
import 'package:peeps/models/reply.dart';
import 'package:peeps/screens/common/captions.dart';
import 'package:peeps/screens/groupwork/collaborate/reply_form.dart';
import 'package:peeps/screens/splash_page.dart';

class DiscussionView extends StatefulWidget {
  DiscussionView({Key key}) : super(key: key);

  _DiscussionViewState createState() => _DiscussionViewState();
}

class _DiscussionViewState extends State<DiscussionView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _replyController = TextEditingController();
  bool bottomOpened = false;

  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<CollaborateDiscussionBloc>(context);
    PersistentBottomSheetController bottomSheetController;

    _showBottomSheet(context) {
      bottomOpened = true;
      bottomSheetController =
          _scaffoldKey.currentState.showBottomSheet((builder) {
        return Container(
          color: Theme.of(context).backgroundColor,
          height: 160,
          padding: EdgeInsets.all(9),
          child: Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  minLines: 5,
                  maxLines: 6,
                  controller: _replyController,
                )
              ],
            ),
          ),
        );
      });
      bottomSheetController.closed.then((value) {
        bottomOpened = false;
      });
    }

    _buildHeader(data) {
      return Flexible(
        flex: 1,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(9),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                        flex: 2,
                        child: Text(
                          data.title,
                          style: TextStyle(fontSize: 18),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Flexible(
                      flex: 3,
                      child: Text(
                        data.description,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: <Widget>[
                      CustomCaptions(
                        text: " by : ${data.by}",
                        color: Colors.blue[200],
                      ),
                      Text(" at : " +
                          DateFormat.yMd().add_Hms().format(data.createdDate))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    _buildDiscussion(data) {
      return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            return Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildHeader(data),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: data.replies.length,
                        itemBuilder: (context, index) {
                          return Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.25,
                            secondaryActions: <Widget>[
                              state.data.email == data.replies[index].by ?
                              IconSlideAction(
                                caption: 'Delete',
                                color: Colors.red[700],
                                icon: Icons.delete,
                                onTap: () {
                                  _bloc.add(DeleteReplyEvent(
                                      data: data.replies[index]));
                                  setState(() {
                                    data.replies.removeAt(index);
                                  });
                                },
                              )
                              :
                              Container(),
                            ],
                            child: Card(
                              child: ListTile(
                                title: Text(data.replies[index].reply),
                                subtitle: Column(
                                  children: <Widget>[
                                    SizedBox(height: 10,),
                                    Row(
                                      children: <Widget>[
                                        Text(" by : " + data.replies[index].by),
                                        Text(" at : " +
                                            DateFormat.yMd().add_Hms().format(
                                                data.replies[index].createdDate))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Discussion"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _bloc.add(LoadDiscussionEvent());
        },
        child: BlocBuilder(
          bloc: _bloc,
          builder: (context, state) {
            if (state is InitialCollaborateDiscussionState) {
              _bloc.add(LoadDiscussionEvent());
              return SplashScreen();
            }
            if (state is LoadingDiscussionState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LoadedDiscussionState) {
              return _buildDiscussion(state.data);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.reply),
          onPressed: () {
            if (bottomOpened) {
              _bloc.add(CreateNewReplyEvent(
                  data: ReplyModel(
                      id: "0",
                      createdDate: DateTime.now(),
                      by: "",
                      reply: _replyController.text)));
              Navigator.pop(context);
              _bloc.add(LoadDiscussionEvent());
            } else {
              _showBottomSheet(context);
            }
          }),
    );
  }
}
