import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hive/hive.dart';
import 'package:wegas/gen/assets.gen.dart';
import 'package:wegas/main.dart';
import 'package:wegas/models/user/user_model.dart';
import 'package:wegas/utils/apptypography/style.dart';
import 'package:wegas/utils/color_palette/colors.dart';
import 'package:wegas/utils/routes/routes.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OnBoardingScreenState();
  }
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Color(0xFF142850),
          body:Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF142850),
                      Color(0xFF253B6E),
                    ],
                ),
                image: DecorationImage(
                    image: AssetImage('assets/images/${Hive.box<UserModel>('user').values.first.activeBg}.png'),
                    fit: BoxFit.fill,
                ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 16.h, right: 16.w, bottom: 16.h),
                        child: InkWell(
                          onTap: () async {
                            final box = await Hive.openBox<bool>('seen');
                            await box.clear();
                            await box.put('seen', true);
                            Navigator.pushNamed(
                                context, MainNavigationRoutes.main);
                          },
                          child: Icon(
                            Icons.clear,
                            color: AppColors.white,
                            size: 30.h,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        child: Image.asset(Assets.images.logo.path,filterQuality: FilterQuality.high,width: 343.w,height: 260.h,),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "more skins".toUpperCase(),
                          textAlign: TextAlign.center,
                          style: AppTypography.mainStyle.copyWith(
                              fontSize: 50.w
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "money adding\nfunction".toUpperCase(),
                          textAlign: TextAlign.center,
                          style: AppTypography.mainStyle.copyWith(
                              fontSize: 50.w
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ads removing".toUpperCase(),
                          textAlign: TextAlign.center,
                          style: AppTypography.mainStyle.copyWith(
                              fontSize: 50.w
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: InkWell(
                      onTap: () async {
                        await purchase().then((value) => subscribed=value);
                        Navigator.pushNamed(context, MainNavigationRoutes.main);
                      },
                      child: Container(
                        height: 64.h,
                        width: 343.w,
                        padding: EdgeInsets.symmetric(vertical: 12.h,horizontal: 16.w),
                        decoration: BoxDecoration(
                            color: AppColors.orange,
                            borderRadius: BorderRadius.circular(40.r)
                        ),
                        child: Center(
                          child: Text(
                            "Buy premium for 0.99\$".toUpperCase(),
                            style: AppTypography.robotoStyle.copyWith(
                                fontSize: 22.w,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(left: 56.w,right:56.w, top: 18.h,bottom: 30.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () =>openTermsOfUse(),
                          child: Text(
                            'Terms of use',
                            style: AppTypography.robotoStyle.copyWith(
                                fontSize: 11.w
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: ()=>restore().then((value) => value ? Navigator.pop(context) : null),
                          child: Text(
                            'Restore',
                            style: AppTypography.robotoStyle.copyWith(
                                fontSize: 11.w
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => openPrivacyPolicy(),
                          child: Text(
                            'Privacy Policy',
                            style: AppTypography.robotoStyle.copyWith(
                                fontSize: 11.w
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async => false);
  }
}
