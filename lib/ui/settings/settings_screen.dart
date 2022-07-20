import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hive/hive.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:wegas/main.dart';
import 'package:wegas/models/user/user_model.dart';
import 'package:wegas/ui/home/ui/home_screen.dart';
import 'package:wegas/ui/onboarding/ui/onboarding.dart';
import 'package:wegas/utils/apptypography/style.dart';
import 'package:wegas/utils/color_palette/colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<SettingsScreen> {
  int selectedSum = 250;
  InAppReview inappreview = InAppReview.instance;
  UserModel user = Hive.box<UserModel>('user').values.first;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Color(0xFF142850),
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF142850), Color(0xFF253B6E)]),
                image: DecorationImage(
                    image: AssetImage('assets/images/${Hive.box<UserModel>('user').values.first.activeBg}.png'),
                    fit: BoxFit.fill)),
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: 45.h, top: 56.h, left: 20.w, right: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen())),
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppColors.white,
                            size: 30.h,
                          )),
                      Row(
                        children: [
                          Text(
                            '${Hive.box<UserModel>('user').values.first.balance}',
                            style: AppTypography.mainStyle.copyWith(
                                color: AppColors.orange,
                                fontWeight: FontWeight.w400,
                                fontSize: 32.w,
                                letterSpacing: 0.08
                            ),),
                          Text(
                              ' coins'.toUpperCase(),
                              style: AppTypography.mainStyle.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 32.w,
                                  letterSpacing: 0.08
                              )
                          ),
                        ],
                      ),
                      Container(width: 30.w,)
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  if(!subscribed)RawBtn(
                    label: 'buy premium',
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => OnBoardingScreen())),
                  ),
                  if(subscribed)Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.5.h),
                    child: InkWell(
                      onTap: ()async{
                        if(Hive.box<UserModel>('user').values.first.lastUpdate!=null){
                          if(Hive.box<UserModel>('user').values.first.lastUpdate!.day-DateTime.now().day>=1){
                            print(Hive.box<UserModel>('user').values.first.lastUpdate);
                            setState(()=> user.balance=user.balance!+5000);
                            Hive.box<UserModel>('user').values.first.lastUpdate=DateTime.now();
                            await Hive.box<UserModel>('user').clear();
                            await Hive.box<UserModel>('user').put('user',user);
                          }else{
                            print('День еще не прошел');
                          }
                        }else{
                          setState(()=> user.balance=user.balance!+5000);
                          user.lastUpdate=DateTime.now();
                          await Hive.box<UserModel>('user').clear();
                          await Hive.box<UserModel>('user').put('user',user);
                        }
                      },
                      child: Container(
                        width: 304.w,
                        height: 47.h,
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              text: 'get'.toUpperCase(),
                                style: AppTypography.mainStyle.copyWith(
                                  fontSize: 50.w,
                                  letterSpacing: 1.24
                                ),
                              children: [
                                TextSpan(
                                  text: ' 5000 ',
                                    style: AppTypography.mainStyle.copyWith(
                                      fontSize: 50.w,
                                      color: AppColors.orange,
                                        letterSpacing: 1.24
                                    ),
                                  children: [
                                    TextSpan(
                                      text: 'coins'.toUpperCase(),
                                      style: AppTypography.mainStyle.copyWith(
                                        fontSize: 50.w,
                                          letterSpacing: 1.24
                                      )
                                    )
                                  ]
                                )
                              ]
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  RawBtn(
                    onTap: ()=>openPrivacyPolicy(),
                      label: 'privacy policy'.toUpperCase(),
    ),
                  RawBtn(
                      onTap: ()=>openTermsOfUse(),
                      label: 'terms of use'.toUpperCase(),
                      ),
                  RawBtn(
                    onTap:()=>inappreview.requestReview(),
                      label: 'rate app'.toUpperCase(),
                  ),
                  RawBtn(
                    onTap:()=>openSupport(),
                      label: 'support'.toUpperCase(),
    )
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async => false);
  }
}

class RawBtn extends StatelessWidget {
  RawBtn({this.onTap, required this.label});
  final String label;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(vertical: 16.5.h),
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: 304.w,
            height: 47.h,
            child: Center(
              child: Text(
                label.toUpperCase(),
                style: AppTypography.mainStyle.copyWith(
                  color: label == 'buy premium'
                      ? AppColors.orange
                      : AppColors.white,
                  letterSpacing: 1.24,
                  fontSize: 50.w,
                  fontWeight: FontWeight.w400
                )
              ),
            ),
          ),
        ),
      );
}
