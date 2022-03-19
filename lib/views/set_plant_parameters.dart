import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:plantbuddy/widgets/transparant_appbar.dart';


class SetPlantParameters extends StatelessWidget {
  const SetPlantParameters({Key? key}) : super(key: key);

  InputDecoration _defaultInputDecoration(labelName) =>
      InputDecoration(labelText: labelName);

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FormBuilder(
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: "Name",
                      decoration: _defaultInputDecoration("Name"),
                    ),
                    FormBuilderRangeSlider(
                      name: "Moisture",
                      initialValue: const RangeValues(50, 60),
                      min: 0,
                      max: 100,
                      decoration: _defaultInputDecoration("Moisture level"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
