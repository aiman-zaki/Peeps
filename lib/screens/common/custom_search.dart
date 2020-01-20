import 'package:flutter/material.dart';
import 'package:peeps/screens/common/withAvatar_dialog.dart';

//Provide Search Input data to Repostiory
typedef ProvideSearchInput = void Function(String);

typedef ListViewChild = Widget Function(dynamic);

class CustomSearch extends StatefulWidget {
  final List data;
  final searchInput;
  final listViewChild;
  final textInputLabel;
  CustomSearch({
    Key key,
    this.data, 
    this.searchInput, 
    this.listViewChild,
    this.textInputLabel}) : super(key: key);

  _CustomSearchState createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {

  @override
  Widget build(BuildContext context) {
  final _searchController = TextEditingController();
  final ProvideSearchInput _provideSearchInput = widget.searchInput;
  final ListViewChild _listViewChild = widget.listViewChild;

  _showSearchDialog(){
    showDialog(
      context: (context),
      builder: (context){
        return DialogWithAvatar(
          height: 200,
          avatarIcon: Icon(Icons.search),
          children: <Widget>[
            SizedBox(height: 20,),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: widget.textInputLabel
              ),
            ),
            SizedBox(height: 20,), 
          ],
          bottomRight: FlatButton(
              child: Text('Search'),
              onPressed: (){
                _provideSearchInput(_searchController.text);
              },
            ),
        );
      }
    );
  }
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.data != null ? widget.data.length : 1,
            itemBuilder: (BuildContext context,int index){

              if(widget.data == null){
                return Center(child: Text('No Input Data'),);
              }
              if(widget.data != null && widget.data.length == 0){
                return Center(child: Text('No Match Query'),);
              }
              return Container(
                child: _listViewChild(widget.data[index]),
              );
            },
          ),
          Positioned(
            bottom: 1,
            right: 1,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: RaisedButton.icon(
                  
                  icon: Icon(Icons.search),
                  label: Text('Search'),
                  onPressed: (){
                   _showSearchDialog();
                  }, 
              ),
            ),
          )
        ],
       ),
    );
  }
}