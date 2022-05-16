import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Decoration/CardDecoration.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(
            color: Colors.white70,
          ),
          child: Container(
            decoration: CardDecoration(16),
            width: 300.0,
            height: 200.0,
            alignment: AlignmentDirectional.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: CircularProgressIndicator(
                      value: null,
                      strokeWidth: 7.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
