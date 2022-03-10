import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/views/set_plant_parameters.dart';
import 'package:plantbuddy/widgets/text.dart';
import 'package:plantbuddy/widgets/transparant_appbar.dart';

class AddNewPlant extends StatelessWidget {
  const AddNewPlant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TransparantAppbar(title: "New plant"),
      body: Container(
        constraints: const BoxConstraints(maxWidth: 1024),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(32),
                  color: Colors.grey,
                  padding: const EdgeInsets.all(16),
                  dashPattern: const [10, 8],
                  strokeWidth: 6,
                  child: Image.network(
                    "https://webstockreview.net/images/clipart-smile-sunflower-18.png",
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SetPlantParameters(),
                    ),
                  ),
                  child: Header2Text("Connect new device"),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
