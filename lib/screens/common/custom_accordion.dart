import 'package:flutter/material.dart';

class AccordionItem{
  final header;
  final expandedBody;
  
  const AccordionItem({
    Key key,
    @required this.header,
    @required this.expandedBody,
  });

}

class BuildAccordionItems extends StatelessWidget{
  final AccordionItem item;

  const BuildAccordionItems({
    Key key,
    @required this.item
    }) : super(key:key);
      
  @override
  Widget build(BuildContext context) {
    return null;
  }

}