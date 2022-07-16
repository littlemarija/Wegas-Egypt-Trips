
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hive/hive.dart';
import 'package:wegas/gen/assets.gen.dart';
import 'package:wegas/models/user/user_model.dart';
import 'package:wegas/ui/home/ui/home_screen.dart';
import 'package:wegas/utils/apptypography/style.dart';
import 'package:wegas/utils/color_palette/colors.dart';

class SkinsScreen extends StatefulWidget {
  const SkinsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SkinsScreenState();
  }
}

class Skin {
  Skin({this.name, this.price});

  int? price;
  String? name;
}

class _SkinsScreenState extends State<SkinsScreen> {
  static List<Skin> skins = [
    Skin(
        name: 'emily',
        price: 0),
    Skin(
        name: 'nora',
        price: 3000),
    Skin(
        name: 'dilan',
        price: 7000),
    Skin(
        name: 'lora',
        price: 12000),
    Skin(
        name: 'nubis',
        price: 100000),
    Skin(
      name: 'rira',
      price: 10000
    )
  ];
  UserModel user = Hive.box<UserModel>('user').values.first;
  int currInd = 0;
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
                padding: EdgeInsets.only(bottom: 4.h, top: 16.h),
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
                      height: 36.h,
                    ),
                    Image.asset('assets/images/${skins[currInd].name}.png',filterQuality: FilterQuality.high,width: 343.w),
                    SizedBox(height: 73.h,),
                    Row(
                      children: [
                        if(currInd!=0)InkWell(
                            onTap: () {
                              if (currInd > 0) setState(() => currInd--);
                            },
                            child: RotatedBox(
                              quarterTurns: -1,
                              child: Icon(
                                Icons.arrow_drop_up,
                                color: AppColors.orange,
                                size: 50.w,
                              ),
                            )
                        ),
                        Spacer(),
                        Text(skins[currInd].name!.toUpperCase()
                          ,style: AppTypography.mainStyle.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 50.w,
                              letterSpacing: 0.8
                          ),),
                        Spacer(),
                        if(currInd!=5)InkWell(
                          onTap: () {
                            if (currInd >=0&&currInd<5) setState(() => currInd++);
                          },
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Icon(
                              Icons.arrow_drop_up,
                              color: AppColors.orange,
                              size: 50.w,
                            ),
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    InkWell(
                      onTap: (){
                        final userData = user;
                        if(userData.availableSkins!.contains(skins[currInd].name)==false&&(userData.balance)!>=skins[currInd].price!){
                          setState((){
                            userData.balance=userData.balance!-skins[currInd].price!;
                            userData.availableSkins!.add(skins[currInd].name!);
                          });
                        }
                        if(userData.availableSkins!.contains(skins[currInd].name)==true&&userData.activeSkin! != skins[currInd]){
                          setState(()=>userData.activeSkin=skins[currInd].name);
                        }
                      },
                      child: Container(
                        width: 343.w,
                        height: 64.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.r),
                            color: labelSelector()=='CHOSEN' ? AppColors.white.withOpacity(0.5) :AppColors.orange

                        ),
                        child: Center(
                          child: Text(labelSelector(),style: AppTypography.robotoStyle.copyWith(
                              color: AppColors.black,
                              fontSize: 22.w,
                              fontWeight: FontWeight.w700
                          ),),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: () async => false);
  }

  String labelSelector(){
    if(Hive.box<UserModel>('user').values.first.activeSkin==skins[currInd].name)return 'CHOSEN';
    if (Hive.box<UserModel>('user').values.first.availableSkins!.contains(skins[currInd].name!))return 'CHOOSE';
    return '${skins[currInd].price} COINS';
  }
  String pathSelector(){
    if (Hive.box<UserModel>('user').values.first.availableSkins!.contains(skins[currInd].name!))return Assets.images.onboardingbtn.path;
    return Assets.images.onboardingbtn.path;
  }
}
