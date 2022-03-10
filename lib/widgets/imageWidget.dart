
import 'package:flutter/cupertino.dart';

class ImageWidget extends StatelessWidget {
  final String imagepath;
  final double? height;
  const ImageWidget({Key? key, required this.imagepath, this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      child: Image.asset(imagepath,
      ),
    );
  }
}
