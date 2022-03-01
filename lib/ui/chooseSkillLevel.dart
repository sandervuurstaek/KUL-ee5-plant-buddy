import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantbuddy/ui/registerpage.dart';

class ChooseSkillLevel extends StatelessWidget {
  const ChooseSkillLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget topArea = Container(
      margin: EdgeInsets.only(left: 60.w, right: 60.w, top: 60.h),
      width: double.infinity,
      child: Column(
        children: [
          Text(
            "Skill level",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 80.sp,
              color: const Color.fromRGBO(72, 75, 75, 1.0),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "CREAT ACCOUNT",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.sp,
              color: const Color.fromRGBO(72, 75, 75, 1.0),
            ),
          ),
          SizedBox(height: 30.h),
          Text(
            "How skilled are you at taking care of plants?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 45.sp,
              color: const Color.fromRGBO(125, 128, 128, 1.0),
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
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _skillLevelList.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
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
              return RegisterPage();
            }));
          },
          child: Container(
            height: 400.h,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(40.w),
                  width: 320.r,
                  height: 320.r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    image: DecorationImage(
                        image: AssetImage(_skillLevelImageList[index]),
                        fit: BoxFit.fill),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 80.h),
                    Container(
                      width: 700.w,
                      child: Text(
                        level,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 50.sp,
                          color: const Color.fromRGBO(72, 75, 75, 1.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 700.w,
                      child: Text(
                        description,
                        softWrap: true,
                        maxLines: 3,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 45.sp,
                          color: const Color.fromRGBO(72, 75, 75, 1.0),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          topArea,
          Divider(
            color: Colors.grey,
          ),
          SizedBox(
            height: 40.h,
          ),
          skillSelectionArea,
        ],
      ),
    );
  }
}
