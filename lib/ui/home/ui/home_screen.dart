import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wegas/gen/assets.gen.dart';
import 'package:wegas/models/user/user_model.dart';
import 'package:wegas/ui/backgrounds/backgrounds_screen.dart';
import 'package:wegas/ui/game/ui/game_screen.dart';
import 'package:wegas/ui/prestart/prestart_screen.dart';
import 'package:wegas/ui/settings/settings_screen.dart';
import 'package:wegas/ui/skins/skins_screen.dart';
import 'package:wegas/ui/store/store_screen.dart';
import 'package:wegas/utils/apptypography/style.dart';
import 'package:wegas/utils/color_palette/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedSum = 50;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/${Hive.box<UserModel>('user').values.first.activeBg}.png'),
                    fit: BoxFit.fill)),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(bottom: 40.h,top: 18.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${Hive.box<UserModel>('user').values.first.balance!}',
                            style: AppTypography.mainStyle.copyWith(
                              color: AppColors.orange,
                              fontSize: 32.w,
                              letterSpacing: 0.8,
                            )),
                        Text(' coins'.toUpperCase(),style: AppTypography.mainStyle.copyWith(
                          fontSize: 32.w,
                          letterSpacing: 0.8,
                        ),)
                      ],
                    ),
                    Image.asset('assets/images/menulogo.png',width: 343.w,height: 260.h,filterQuality: FilterQuality.high,),
                    SizedBox(height: 43.h,),
                    InkWell(
                      onTap: ()=>Navigator.push(context, PageTransition(child: PreStartScreen(), type: PageTransitionType.rightToLeft)),
                      child: Padding(
                        padding: EdgeInsets.all(5.w),
                        child: Text('start'.toUpperCase(),style: AppTypography.mainStyle.copyWith(
                          fontSize: 50.w,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w400
                        ),),),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 33.h),
                        child: InkWell(
                      onTap: ()=>Navigator.push(context, PageTransition<Widget>(child: SettingsScreen(),type:PageTransitionType.rightToLeft)),
                          child: Padding(
                        padding: EdgeInsets.all(5.w),
                        child: Text('settings'.toUpperCase(),style: AppTypography.mainStyle.copyWith(
                            fontSize: 50.w,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w100
                        ),),),
                    ),),
                    InkWell(
                      onTap: ()=>Navigator.push(context, PageTransition(child: StoreScreen(), type: PageTransitionType.rightToLeft)),
                      child: Padding(
                        padding: EdgeInsets.all(5.w),
                        child: Text('store'.toUpperCase(),style: AppTypography.mainStyle.copyWith(
                            fontSize: 50.w,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w400
                        ),),),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: () async => false);
  }

}
