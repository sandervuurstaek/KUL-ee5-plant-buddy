import 'package:flutter/material.dart';
import 'package:plantbuddy/views/registerpage.dart';
import 'package:plantbuddy/widgets/text.dart';
import '../widgets/transparant_appbar.dart';

class ChooseSkillLevel extends StatelessWidget {
  const ChooseSkillLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget topArea = Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      width: double.infinity,
      child: Column(
        children: [
           Header1Text(
            "Skill level",
            textAlign: TextAlign.center,
            textStyle: const TextStyle(
              color: Color.fromRGBO(72, 75, 75, 1.0),
              fontWeight: FontWeight.bold,
            ),
          ),
          Header2Text(
            "CREAT ACCOUNT",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Header3Text(
            "How skilled are you at taking care of plants?",
            textAlign: TextAlign.center,
            textStyle: const TextStyle(
              color: Color.fromRGBO(125, 128, 128, 1.0),
            ),
          ),
        ],
      ),
    );
    List<String> _skillLevelImageList = [
      "asset/hopelessLevel.jpg",
      "asset/beginnerLevel.jpg",
      "asset/experiencedLevel.jpg",
      "asset/skilledLevel.jpg",
      "asset/masterLevel.jpg",
    ];
    List<String> _skillLevelList = [
      "Hopeless/The only plants that are still alive are the ones that never lived",
      "Beginner/Every now and then I manage to keep a plant alive",
      "Experienced/I have my plants under control, we are alright",
      "Skilled/What I don't know about plants is not worth working",
      "Master/I'm Linne!"
    ];

    Widget skillSelectionArea = ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _skillLevelList.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          color: Colors.grey,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        var l1 = _skillLevelList[index];
        List<String> splitString = l1.split('/');
        var level = splitString[0];
        var description = splitString[1];
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const RegisterPage();
            }));
          },
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: AssetImage(_skillLevelImageList[index]),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header2Text(
                          level,
                          softWrap: true,
                          textStyle: const TextStyle(
                            color: Color.fromRGBO(72, 75, 75, 1.0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Header3Text(
                          description,
                          softWrap: true,
                          maxLines: 3,
                          textStyle: const TextStyle(
                            color: Color.fromRGBO(72, 75, 75, 1.0),
                          ),
                        ),

                      ],
                    )
                  ]
              ),
            ),

        );
      }
      );
    return Scaffold(
      appBar: const TransparantAppbar(
        title: '',
      ),
      body: ListView(
        children: [
          topArea,
          const Divider(
            color: Colors.grey,
          ),
          const SizedBox(
            height: 16,
          ),
          skillSelectionArea,
        ],
      ),
    );
  }
}
