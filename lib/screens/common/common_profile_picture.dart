import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';

class CustomNetworkProfilePicture extends StatelessWidget {
  final child;
  final Function onTap;
  final String image;
  final double width;
  final double heigth;
  final double topRadius;
  final double bottomRadius;
   
  const CustomNetworkProfilePicture({
    Key key, 
    this.child, 
    this.onTap, 
    @required this.image,
    this.width,
    this.heigth,
    this.topRadius,
    this.bottomRadius,
    
    }) : super(key: key);
  //TODO: Handle error no image
  @override
  Widget build(BuildContext context) {
    var _image;
    _checkImage(){
      _image = NetworkImageWithRetry(image,
          fetchStrategy: FetchStrategyBuilder(
          timeout: Duration(seconds: 2),
          transientHttpStatusCodePredicate: (code) {
            return code == null ||
                FetchStrategyBuilder
                    .defaultTransientHttpStatusCodePredicate(code);
          }).build()
      );
    }
    _checkImage();
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width == null ? 190.00 : width,
        height: heigth == null ? 190.00 : heigth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topRadius == null ? 120 : topRadius),
            topRight: Radius.circular(topRadius == null ? 120 : topRadius),
            bottomLeft: Radius.circular(bottomRadius == null ? 120 : bottomRadius),
            bottomRight: Radius.circular(bottomRadius == null ?120 : bottomRadius),
          ),
          image: DecorationImage(
            image:  _image,
            fit: BoxFit.cover
          )
        ),
        child: child));
  }
}