import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/views/ProfilePage.dart';
import 'package:plantbuddy/views/registerpage.dart';

import '../widgets/text.dart';
import '../widgets/transparant_appbar.dart';



class IndoorOrOutdoorPage extends StatelessWidget {
  final String mode;
  const IndoorOrOutdoorPage({Key? key, required this.mode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget topArea = Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      width: double.infinity,
      child: Column(
        children: [
          Header1Text(
            "Indoor or Outdoor",
            textAlign: TextAlign.center,
            textStyle: const TextStyle(
              color: Color.fromRGBO(72, 75, 75, 1.0),
              fontWeight: FontWeight.bold,
            ),
          ),
          Header2Text(
            mode=='Settings'?"SETTINGS":"CREAT ACCOUNT",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Header3Text(
            "Would you like help with plants indoor, outdoor or both?",
            textAlign: TextAlign.center,
            textStyle: const TextStyle(
              color: Color.fromRGBO(125, 128, 128, 1.0),
            ),
          ),
        ],
      ),
    );
    List<String> _skillLevelImageList = [
      "asset/indoor.jpg",
      "asset/outdoor.jpg",
      "asset/IndoorOutdoor.jpg",
    ];
    List<String> _skillLevelList = [
      "Indoor/For indoor plant care",
      "Outdoor/For potted plants in garden, balcony or terrace",
      "Indoor & Outdoor/For plant care indoor, and potted plants outdoor/balcony",
    ];

    Widget IndoorOrOutdoorSelectionArea = ListView.separated(
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
              if(mode=='Settings')
              {
                Navigator.of(context).pop();
              }
              else{
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const RegisterPage();
                }));
              }
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
          IndoorOrOutdoorSelectionArea,
        ],
      ),
    );
  }
}
