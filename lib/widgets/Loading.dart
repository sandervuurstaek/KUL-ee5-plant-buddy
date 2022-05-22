import 'package:flutter/cupertino.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      radius: 10,
    );
  }
}
