import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hive/hive.dart';
import 'package:wegas/gen/assets.gen.dart';
import 'package:wegas/models/user/user_model.dart';
import 'package:wegas/utils/color_palette/colors.dart';

class DailyCoinsScreen extends StatefulWidget {
  const DailyCoinsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<DailyCoinsScreen> {
  int selectedSum = 1000;
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppColors.white,
                            size: 30.h,
                          )),
                      Spacer(),
                      Text(
                        '${Hive.box<UserModel>('user').values.first.balance}',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 28.h,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Bebas',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text('Change daily coin balance',style: TextStyle(
                    color: AppColors.white,
                    fontSize: 28.w,
                    fontFamily: 'Bebas',
                    fontWeight: FontWeight.w700
                  ),),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$selectedSum',
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Bebas',
                              fontSize: 28.w),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: ()=>setState(()=>selectedSum=1000),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.h),
                          child: Container(
                            width: 18.w,height: 4.h,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      selectedSum!=1000
                          ? InkWell(
                        child: Container(
                          width: 4.w,height: 16.h,
                          color: AppColors.white,
                        ),
                        onTap: ()=>setState(()=>selectedSum=1000),
                      )
                          : Container(
                        width: 16.h,
                        height: 16.h,
                        decoration: BoxDecoration(
                            color: AppColors.yellow,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Color(0xFFBF9500),width: 1.r)
                        ),
                      ),
                      InkWell(
                          onTap: ()=>setState(()=>selectedSum=1000),
                          child:Padding(
                              padding: EdgeInsets.symmetric(vertical: 24.h),
                              child:Container(
                                width: 28.w,height: 4.h,
                                color: AppColors.white,
                              ))),
                      selectedSum!=2000
                          ? InkWell(
                        child: Container(
                          width: 4.w,height: 16.h,
                          color: AppColors.white,
                        ),
                        onTap: ()=>setState(()=>selectedSum=2000),
                      )
                          : Container(
                        width: 16.h,
                        height: 16.h,
                        decoration: BoxDecoration(
                            color: AppColors.yellow,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Color(0xFFBF9500),width: 1.r)
                        ),
                      ),
                      InkWell(
                          onTap: ()=>setState(()=>selectedSum=2000),
                          child:Padding(
                            padding: EdgeInsets.symmetric(vertical: 24.h),
                            child: Container(
                              width: 28.w,height: 4.h,
                              color: AppColors.white,
                            ),
                          )),
                      selectedSum!=3000 ? InkWell(
                        child: Container(
                          width: 4.w,height: 16.h,
                          color: AppColors.white,
                        ),
                        onTap: ()=>setState(()=>selectedSum=3000),
                      )
                          : Container(
                        width: 16.h,
                        height: 16.h,
                        decoration: BoxDecoration(
                            color: AppColors.yellow,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Color(0xFFBF9500),width: 1.r)
                        ),
                      ),
                      InkWell(
                        onTap: ()=>setState(()=>selectedSum=3000),
                        child:Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.h),
                          child: Container(
                            width: 28.w,height: 4.h,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      selectedSum!=4000
                          ? InkWell(
                        child: Container(
                          width: 4.w,height: 16.h,
                          color: AppColors.white,
                        ),
                        onTap: ()=>setState(()=>selectedSum=4000),
                      )
                          : Container(
                        width: 16.h,
                        height: 16.h,
                        decoration: BoxDecoration(
                            color: AppColors.yellow,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Color(0xFFBF9500),width: 1.r)
                        ),
                      ),
                      InkWell(
                          onTap: ()=>setState(()=>selectedSum=4000),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 24.h),
                            child: Container(
                              width: 28.w,height: 4.h,
                              color: AppColors.white,
                            ),
                          )),
                      selectedSum!=5000
                          ? InkWell(
                        child: Container(
                          width: 4.w,height: 16.h,
                          color: AppColors.white,
                        ),
                        onTap: ()=>setState(()=>selectedSum=5000),
                      )
                          : Container(
                        width: 16.h,
                        height: 16.h,
                        decoration: BoxDecoration(
                            color: AppColors.yellow,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Color(0xFFBF9500),width: 1.r)
                        ),
                      ),
                      InkWell(
                          onTap: ()=>setState(()=>selectedSum=6000),
                          child:Padding(
                              padding: EdgeInsets.symmetric(vertical: 24.h),
                              child:Container(
                                width: 28.w,height: 4.h,
                                color: AppColors.white,
                              ))),
                      selectedSum!=6000
                          ? InkWell(
                        child: Container(
                          width: 4.w,height: 16.h,
                          color: AppColors.white,
                        ),
                        onTap: ()=>setState(()=>selectedSum=6000),
                      )
                          : Container(
                        width: 16.h,
                        height: 16.h,
                        decoration: BoxDecoration(
                            color: AppColors.yellow,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Color(0xFFBF9500),width: 1.r)
                        ),
                      ),
                      InkWell(
                          onTap: ()=>setState(()=>selectedSum=7000),
                          child:Padding(
                              padding: EdgeInsets.symmetric(vertical: 24.h),
                              child:Container(
                                width: 28.w,height: 4.h,
                                color: AppColors.white,
                              ))),
                      selectedSum!=7000
                          ? InkWell(
                        child: Container(
                          width: 4.w,height: 16.h,
                          color: AppColors.white,
                        ),
                        onTap: ()=>setState(()=>selectedSum=7000),
                      )
                          : Container(
                        width: 16.h,
                        height: 16.h,
                        decoration: BoxDecoration(
                            color: AppColors.yellow,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Color(0xFFBF9500),width: 1.r)
                        ),
                      ),
                      InkWell(
                          onTap: ()=>setState(()=>selectedSum=8000),
                          child:Padding(
                            padding: EdgeInsets.symmetric(vertical: 24.h),
                            child: Container(
                              width: 28.w,height: 4.h,
                              color: AppColors.white,
                            ),
                          )),
                      selectedSum!=8000 ? InkWell(
                        child: Container(
                          width: 4.w,height: 16.h,
                          color: AppColors.white,
                        ),
                        onTap: ()=>setState(()=>selectedSum=8000),
                      )
                          : Container(
                        width: 16.h,
                        height: 16.h,
                        decoration: BoxDecoration(
                            color: AppColors.yellow,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Color(0xFFBF9500),width: 1.r)
                        ),
                      ),
                      InkWell(
                        onTap: ()=>setState(()=>selectedSum=9000),
                        child:Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.h),
                          child: Container(
                            width: 28.w,height: 4.h,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      selectedSum!=9000
                          ? InkWell(
                        child: Container(
                          width: 4.w,height: 16.h,
                          color: AppColors.white,
                        ),
                        onTap: ()=>setState(()=>selectedSum=9000),
                      )
                          : Container(
                        width: 16.h,
                        height: 16.h,
                        decoration: BoxDecoration(
                            color: AppColors.yellow,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Color(0xFFBF9500),width: 1.r)
                        ),
                      ),
                      InkWell(
                          onTap: ()=>setState(()=>selectedSum=10000),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 24.h),
                            child: Container(
                              width: 28.w,height: 4.h,
                              color: AppColors.white,
                            ),
                          )),
                      selectedSum!=10000
                          ? InkWell(
                        child: Container(
                          width: 4.w,height: 16.h,
                          color: AppColors.white,
                        ),
                        onTap: ()=>setState(()=>selectedSum=10000),
                      )
                          : Container(
                        width: 16.h,
                        height: 16.h,
                        decoration: BoxDecoration(
                            color: AppColors.yellow,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Color(0xFFBF9500),width: 1.r)
                        ),
                      ),
                      InkWell(
                        onTap: ()=>setState(()=>selectedSum=10000),
                        child:  Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.h),
                          child: Container(
                            width: 18.w,height: 4.h,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  if(Hive.box<UserModel>('user').values.first.dailyCoinBalance!=selectedSum)Padding(
                    padding: EdgeInsets.only(bottom:58.h),
                    child: InkWell(
                      onTap: ()=>setState(()=>Hive.box<UserModel>('user').values.first.dailyCoinBalance=selectedSum),
                      child: Container(
                        height: 72.h,
                        width: 279.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: Svg(Assets.images.onboardingbtn.path,
                                    size: Size(279.w, 72.h)))),
                        child: Center(
                          child: Text(
                            "confirm".toUpperCase(),
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Bebas',
                              fontSize: 35.w,
                            ),
                          ),
                        ),
                      ),
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
