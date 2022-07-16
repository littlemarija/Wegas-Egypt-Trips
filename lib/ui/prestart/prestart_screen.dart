import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wegas/models/user/user_model.dart';
import 'package:wegas/ui/game/ui/game_screen.dart';
import 'package:wegas/utils/apptypography/style.dart';
import 'package:wegas/utils/color_palette/colors.dart';

class PreStartScreen extends StatefulWidget {
  const PreStartScreen({Key? key}) : super(key: key);

  @override
  State<PreStartScreen> createState() => _PreStartScreenState();
}

class _PreStartScreenState extends State<PreStartScreen> {
  int? selSum;
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
                    image: AssetImage(
                        'assets/images/${Hive.box<UserModel>('user').values.first.activeBg}.png'),
                    fit: BoxFit.fill)),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h, top: 18.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () => Navigator.pop(context),
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
                                  letterSpacing: 0.08),
                            ),
                            Text(' coins'.toUpperCase(),
                                style: AppTypography.mainStyle.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 32.w,
                                    letterSpacing: 0.08)),
                          ],
                        ),
                        Container(
                          width: 30.w,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(height: 22.h,),
                        Text('choose your bet'.toUpperCase(),style: AppTypography.robotoStyle.copyWith(
                          fontSize: 22.w,
                          fontWeight: FontWeight.w700,
                        ),),
                        SizedBox(height: 30.h,),
                        ///50
                        TextButton(
                            onPressed: () => Hive.box<UserModel>('user')
                                        .values
                                        .first
                                        .balance! >=
                                    50
                                ? setState(() => selSum = 50)
                                : null,
                            child: Column(
                              children: [
                                Text(
                                  '50',
                                  style: AppTypography.mainStyle.copyWith(
                                      fontSize: 50.w,
                                      color: AppColors.white.withOpacity(
                                          Hive.box<UserModel>('user')
                                                      .values
                                                      .first
                                                      .balance! <
                                                  50
                                              ? 0.5
                                              : 1.0)),
                                ),
                                Container(
                                  width: 45.w,
                                  height: 3.h,
                                  color: selSum == 50 ? AppColors.orange : null,
                                )
                              ],
                            )),

                        SizedBox(height: 30.h,),

                        ///100
                        TextButton(
                            onPressed: () => Hive.box<UserModel>('user')
                                        .values
                                        .first
                                        .balance! >=
                                    100
                                ? setState(() => selSum = 100)
                                : null,
                            child: Column(
                              children: [
                                Text(
                                  '100',
                                  style: AppTypography.mainStyle.copyWith(
                                      fontSize: 50.w,
                                      color: AppColors.white.withOpacity(
                                          Hive.box<UserModel>('user')
                                                      .values
                                                      .first
                                                      .balance! <
                                                  100
                                              ? 0.5
                                              : 1.0)),
                                ),
                                Container(
                                  width: 55.w,
                                  height: 3.h,
                                  color:
                                      selSum == 100 ? AppColors.orange : null,
                                )
                              ],
                            )),

                        SizedBox(height: 30.h,),

                        ///500
                        TextButton(
                            onPressed: () => Hive.box<UserModel>('user')
                                        .values
                                        .first
                                        .balance! >=
                                    500
                                ? setState(() => selSum = 500)
                                : null,
                            child: Column(
                              children: [
                                Text(
                                  '500',
                                  style: AppTypography.mainStyle.copyWith(
                                      fontSize: 50.w,
                                      color: AppColors.white.withOpacity(
                                          Hive.box<UserModel>('user')
                                                      .values
                                                      .first
                                                      .balance! <
                                                  500
                                              ? 0.5
                                              : 1.0)),
                                ),
                                Container(
                                  width: 55.w,
                                  height: 3.h,
                                  color:
                                      selSum == 500 ? AppColors.orange : null,
                                )
                              ],
                            )),

                        SizedBox(height: 30.h,),

                        ///1000
                        TextButton(
                            onPressed: () => Hive.box<UserModel>('user')
                                        .values
                                        .first
                                        .balance! >=
                                    1000
                                ? setState(() => selSum = 1000)
                                : null,
                            child: Column(
                              children: [
                                Text(
                                  '1000',
                                  style: AppTypography.mainStyle.copyWith(
                                      fontSize: 50.w,
                                      color: AppColors.white.withOpacity(
                                          Hive.box<UserModel>('user')
                                                      .values
                                                      .first
                                                      .balance! <
                                                  1000
                                              ? 0.5
                                              : 1.0)),
                                ),
                                Container(
                                  width: 80.w,
                                  height: 3.h,
                                  color:
                                      selSum == 1000 ? AppColors.orange : null,
                                )
                              ],
                            )),

                        SizedBox(height: 30.h,),

                        ///5000
                        TextButton(
                            onPressed: () => Hive.box<UserModel>('user')
                                        .values
                                        .first
                                        .balance! >=
                                    5000
                                ? setState(() => selSum = 5000)
                                : null,
                            child: Column(
                              children: [
                                Text(
                                  '5000',
                                  style: AppTypography.mainStyle.copyWith(
                                      fontSize: 50.w,
                                      color: AppColors.white.withOpacity(
                                          Hive.box<UserModel>('user')
                                                      .values
                                                      .first
                                                      .balance! <
                                                  5000
                                              ? 0.5
                                              : 1.0)),
                                ),
                                Container(
                                  width: 85.w,
                                  height: 3.h,
                                  color:
                                      selSum == 5000 ? AppColors.orange : null,
                                )
                              ],
                            )),
                      ],
                    ),
                    Spacer(),
                    InkWell(
                      onTap: ()=>selSum==null ? null : Navigator.push(context, PageTransition(child: GameScreen(bet: selSum!,), type: PageTransitionType.rightToLeft)),
                      child: Container(
                      width: 343.w,
                        height: 64.h,
                      decoration: BoxDecoration(
                        color: selSum==null ? AppColors.white.withOpacity(0.5) :AppColors.orange,
                        borderRadius: BorderRadius.circular(40.r)
                      ),
                      child: Center(
                        child: Text('Make your bet',style: AppTypography.robotoStyle.copyWith(
                          color: AppColors.black,
                          fontSize: 22.w,
                          fontWeight: FontWeight.w700
                        ),),
                      ),
                    ),)
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: () async => false);
  }
}
