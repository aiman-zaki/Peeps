import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:peeps/bloc/groupwork/bloc.dart';
import 'package:peeps/bloc/user/bloc.dart';
import 'package:peeps/bloc/user/profile/profile_bloc.dart';
import 'package:peeps/enum/approval_enum.dart';
import 'package:peeps/models/task.dart';
import 'package:peeps/screens/common/tag.dart';
import 'package:peeps/screens/common/webviewexporer.dart';
import 'package:peeps/screens/common/withAvatar_dialog.dart';
import 'package:peeps/screens/groupwork/kanban/task_review_form.dart';
import 'package:peeps/screens/splash_page.dart';


class TaskReviewView extends StatefulWidget {
  final TaskModel tasks;
  final bool isLeader;
  TaskReviewView({Key key,@required this.tasks,@required this.isLeader}) : super(key: key);
  _TaskReviewViewState createState() => _TaskReviewViewState();
}

class _TaskReviewViewState extends State<TaskReviewView> {
  final _suggestionController = TextEditingController();
  final _itemController = TextEditingController();
  bool isAssignedTo = false;
  String _email = "";

  @override
  void initState() {
    super.initState();
    _email = (BlocProvider.of<ProfileBloc>(context).state as ProfileLoaded).data.email;
    if(widget.tasks.assignTo == _email)
      isAssignedTo = true;
  }


  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<TaskItemsReviewsBloc>(context);
    

    _buildReviewsAssignedToOnlyFunctions(){
      if(widget.tasks.assignTo == _email){

      }
    }
    
    _buildItems(List<TaskItemsModel> items){
      return Expanded(
        flex: 1,
        child: Card(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context,index){
              return ListTile(
                title: items[index].item.contains(new RegExp(r'(http.)'))
              ? InkWell(
                child: Text(items[index].item),
                onTap: (){
                  Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => WebViewExplorer(url: items[index].item,),
                      fullscreenDialog: true,
                    )
                  );
                },
              )
              : Text(items[index].item),
              );
            },
          ),
        ),
      );
    }

    _buildReviews(List<TaskReviewsModel> reviews){
      return Expanded(
        flex: 2,
        child: Card(
          child: ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context,index){
              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                actions: isAssignedTo ?
                  [IconSlideAction(
                    icon: Icons.check,
                    color: Colors.green,
                    onTap: (){
                      reviews[index].approval = Approval.approved;
                      _bloc.add(UpdateReviewsApprovalEvent(
                        data: reviews[index]
                      ));
                    },
                  ),
                  IconSlideAction(
                    icon: FontAwesomeIcons.eraser,
                    color: Colors.red,
                    onTap: (){
                      reviews[index].approval = Approval.deny;
                      _bloc.add(UpdateReviewsApprovalEvent(
                      data: reviews[index]
                      ));
                    },
                  )] : [] ,
                child: ListTile(
                  title: Text(reviews[index].review),
                  trailing: CustomTag(padding:EdgeInsets.all(3), color: Colors.pink,text: Text("${getApprovalEnumString(reviews[index].approval)}"),),
                  
                ),
              );
            },
            
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Task Review"),
        actions: <Widget>[
          widget.isLeader ?
          InkWell(
            child: Icon(Icons.check_box),
            onTap: (){
              showDialog(
                context: context,
                builder: (context){
                  return DialogWithAvatar(
                    height: 200,
                    avatarIcon: Icon(Icons.check_box),
                    title: Text("You accept solution submitted?",style: TextStyle(fontSize: 22),),
                    description: "",
                    children: <Widget>[],
                    bottomRight: FlatButton(
                      onPressed: (){
                        _bloc.add(AcceptTaskSolutionsEvent(data: {
                          "by":_email,
                        }));
                        Navigator.of(context).pop();
                      },
                      child: Text("Confirm"),
                    ),
                  );
                }
              );
            },
          ) : Container(),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(9),
        child: BlocBuilder(
          bloc: _bloc,
          builder: (context,state){
            if(state is InitialTaskItemsReviewsState){
              return SplashScreen();
            }
            if(state is LoadingTasksItemsReviewsState){
              return Container(child: CircularProgressIndicator(),);
            }
            if(state is LoadedTasksItemsReviewsState){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomTag(text: Text("Material Submitted",style: TextStyle(fontSize: 22),),color: Colors.blue, padding: EdgeInsets.all(3),),
                  _buildItems(state.items),
                  CustomTag(text: Text("Suggestions",style: TextStyle(fontSize: 22),),color: Colors.green, padding: EdgeInsets.all(3),),
                  _buildReviews(state.reviews),
                ],
              );
            }
          }, 
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle_outline),
        onPressed: (){
          showDialog(
            context: context,
            builder: (context){
              return DialogWithAvatar(
                height: 190,
                avatarIcon: Icon(Icons.add_circle_outline),
                title: Text("${isAssignedTo? "Submit Material" : "Open Suggestions"}",style: TextStyle(fontSize: 20),),
                children: <Widget>[
                  TextFormField(
                    controller: isAssignedTo? _itemController : _suggestionController,
                  ),
                ],
                bottomRight: FlatButton(
                  onPressed: (){
                    if(!isAssignedTo){
                      _bloc.add(CreateReviewsEvent(data: 
                      TaskReviewsModel(
                        id: "",
                        review: _suggestionController.text,
                        by: _email,
                        createdDate: DateTime.now(),
                        approval: Approval.tbd, 
                      )));
                      Navigator.of(context).pop();
                    } else {
                      _bloc.add(CreateItemsEvent(
                        data: TaskItemsModel(
                          id: "",
                          by: _email,
                          item: _itemController.text,
                          createdDate: DateTime.now(),
                          approval: Approval.tbd
                        )
                      ));
                    }
                  },
                  child: Text("Confirm"),
                ),
              );
            }
          );
        },
      ),
    );
  }
}