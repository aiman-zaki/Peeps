import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:peeps/bloc/supervisor/groupwork_template_supervisor/bloc.dart';
import 'package:peeps/models/template.dart';
import 'package:peeps/screens/splash_page.dart';
import 'package:flutter/services.dart';
import 'groupwork_template_form.dart';

class SupervisorGroupworkTemplateView extends StatefulWidget {
  SupervisorGroupworkTemplateView({Key key}) : super(key: key);

  @override
  _SupervisorGroupworkTemplateViewState createState() => _SupervisorGroupworkTemplateViewState();
}

class _SupervisorGroupworkTemplateViewState extends State<SupervisorGroupworkTemplateView> {
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<GroupworkTemplateSupervisorBloc>(context);
    
    _buildTemplatesList(List<GroupworkTemplateModel> data){
      return Container(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context,index){
            return Card(
              child: Slidable(
                actionPane: SlidableScrollActionPane(),
                actions: <Widget>[
                  IconSlideAction(
                    icon: Icons.content_copy,
                    caption: "ID",
                    onTap: (){
                      Clipboard.setData(new ClipboardData(text: data[index].id));
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Copied to clipboard"),
                      ));
                    },
                  ),
                  IconSlideAction(
                    icon: Icons.edit,
                    caption: "Edit",
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => 
                        BlocProvider.value(value: _bloc,child: 
                          GroupworkTemplateFormView(isEdit: true, data: data[index],)))
                      );
                    },
                  ),
                ],
                child: ListTile(
                    title: Text("${data[index].description}"),
                ),
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Groupwork Template"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _bloc.add(ReadGroupworkTemplateSupervisorEvent());
        },
        child: BlocBuilder(
          bloc: _bloc,
          builder: (context,state){
            if(state is InitialGroupworkTemplateSupervisorState){
              return SplashScreen();
            }
            if(state is LoadingGroupworkTemplateSupervisorState){
              return Center(child: CircularProgressIndicator(),);
            }
            if(state is LoadedGroupworkTemplateSupervisorState){
              return _buildTemplatesList(state.data);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "course-template",
        onPressed: (){
          Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) =>  BlocProvider.value(value: _bloc,child: GroupworkTemplateFormView(isEdit: false,),))
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}