import 'package:flutter/material.dart';
import 'package:plantbuddy/ui/chooseSkillLevel.dart';
import 'package:plantbuddy/ui/loginpage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Frontpage extends StatelessWidget {
  const Frontpage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height,
        ),
        designSize: const Size(1080.0, 2340.0),
        context: context,
        orientation: Orientation.portrait);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 150.h),
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              "asset/startpage.png",
              height: 1600.h,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 40.w, right: 40.w),
            height: 150.h,
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(10),
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(18, 144, 122, 1.0)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r))),
              ),
              child: Text(
                "Get Started With Plant Buddy",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 55.sp),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ChooseSkillLevel();
                }));
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
            child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Login();
                  }));
                },
                child: Text(
                  "Aready a member? Sign in here",
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 55.sp,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
