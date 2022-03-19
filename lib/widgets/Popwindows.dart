import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/widgets/text.dart';


class popwindows{
  String _selectedValue="";
  List<Header2Text> options;

  popwindows(this.options);

  Widget _SettingPicker()
  {
    return CupertinoPicker(
       backgroundColor: Colors.white,
        itemExtent: 32,
        onSelectedItemChanged: (position){
          _selectedValue=options[position].toString();
          print(options[position].data.toString());
        },
      children: options,
      diameterRatio:1,
      useMagnifier: true,
    );
  }

   void showLanguagePicker(BuildContext context){
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context)
        {
      return Container(
        height: 200,
        child: _SettingPicker(),
      );
    }
    );
  }

  String get selectedValue => _selectedValue;

  void setSelectedValue(String value) {
    _selectedValue = value;
  }


}
