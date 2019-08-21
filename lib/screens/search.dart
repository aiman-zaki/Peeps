import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  SearchView({Key key}) : super(key: key);

  _SearchViewState createState() => _SearchViewState();
}

enum FiltersOption {Groupwork,Lecturer}

class _SearchViewState extends State<SearchView> {
  FiltersOption _filtersOption = FiltersOption.Groupwork;
  TextEditingController _filterController = TextEditingController();

  Widget _buildSearchFilter(){
    return Padding(
      padding: EdgeInsets.all(2),
      child: Card(
        child: Form(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Flexible(
                    child: TextFormField(
                      controller: _filterController,
                    ),
                  ),
                  Icon(Icons.search),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: ListTile(
                      title: const Text("Groupwork"),
                      leading: Radio(
                        value: FiltersOption.Groupwork,
                        groupValue: _filtersOption,
                        onChanged: (FiltersOption value){
                          setState(() {
                            _filtersOption = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: const Text("Lecturer"),
                      leading: Radio(
                        value: FiltersOption.Lecturer,
                        groupValue: _filtersOption,
                        onChanged: (FiltersOption value){
                          setState(() {
                            _filtersOption = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Column(
          children: <Widget>[
            _buildSearchFilter(),
          ],
        ),
    );
  }
}