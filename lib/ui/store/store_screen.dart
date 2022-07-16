import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:wegas/gen/assets.gen.dart';
import 'package:wegas/main.dart';
import 'package:wegas/models/user/user_model.dart';
import 'package:wegas/ui/backgrounds/backgrounds_screen.dart';
import 'package:wegas/ui/home/ui/home_screen.dart';
import 'package:wegas/ui/skins/skins_screen.dart';
import 'package:wegas/utils/apptypography/style.dart';
import 'package:wegas/utils/color_palette/colors.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StoreScreenState();
  }
}

class _StoreScreenState extends State<StoreScreen> {
  int currInd=0;
  UserModel user = Hive.box<UserModel>('user').values.first;
  int bgInd = 0;
  int skinsInd=0;
  static List<Backgrounds> bgs = [
    Backgrounds(name: 'bg1',price: 0),
    Backgrounds(name: 'bg2',price: 7500),
    Backgrounds(name: 'bg3',price: 15000),
  ];
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
    ),
    Skin(
        name: 'rira',
    )
  ];
  late List<Widget> screens;

  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    screens=[
      Expanded(child: Column(
        children: [
          SizedBox(height: 10.h,),
          Image.asset('assets/images/${skins[skinsInd].name}.png',filterQuality: FilterQuality.high,width: 343.w,height: 343.h,),
        ],
      ),),
      Container()
    ];
    return WillPopScope(
        child: Scaffold(
          backgroundColor: AppColors.black,
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/images/${bgs[bgInd].name}.png'),
                    fit: BoxFit.fill)),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(bottom: 40.h,top: 18.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen())),
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppColors.white,
                            size: 30.w,
                          ),
                        ),
                        Row(children: [
                          Text('${Hive.box<UserModel>('user').values.first.balance!}',
                              style: AppTypography.mainStyle.copyWith(
                                color: AppColors.white,
                                fontSize: 32.w,
                                letterSpacing: 0.8,
                              )),
                          Text(' coins'.toUpperCase(),style: AppTypography.mainStyle.copyWith(
                            color: AppColors.orange,
                            fontSize: 32.w,
                            letterSpacing: 0.8,
                          ),),
                        ],),
                        SizedBox(width: 20.w,),
                      ],
                    ),),
                    SizedBox(height: 29.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                      children: [
                        InkWell(
                          onTap: ()=>setState((){currInd=0;}),
                          child: Container(
                            width: 165.w,
                            height: 64.h,
                            decoration: BoxDecoration(
                                color: currInd==0 ? AppColors.orange : AppColors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(40.r)
                            ),
                            child: Center(
                              child: Text('player'.toUpperCase(),style: AppTypography.robotoStyle.copyWith(
                                  color: AppColors.black,
                                  fontSize: 22.w,
                                  fontWeight: FontWeight.w700
                              ),),
                            ),
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: ()=>setState((){currInd=1;}),
                          child: Container(
                            width: 165.w,
                            height: 64.h,
                            decoration: BoxDecoration(
                                color: currInd==1 ? AppColors.orange : AppColors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(40.r)
                            ),
                            child: Center(
                              child: Text('back'.toUpperCase(),style: AppTypography.robotoStyle.copyWith(
                                  color: AppColors.black,
                                  fontSize: 22.w,
                                  fontWeight: FontWeight.w700
                              ),),
                            ),
                          ),
                        )
                      ],
                    ),),
                    screens[currInd],
                    if(currInd==1)Spacer(),
                    currInd==0 ? Row(
                      children: [
                        skinsInd!=0 ? InkWell(
                            onTap: () {
                              if (skinsInd > 0) setState(() => skinsInd--);
                            },
                            child: RotatedBox(
                              quarterTurns: -1,
                              child: Icon(
                                Icons.arrow_drop_up,
                                color: AppColors.orange,
                                size: 50.w,
                              ),
                            )
                        ) : SizedBox(width: 50.w,),
                        Spacer(),
                        Text(skins[skinsInd].name!.toUpperCase()
                          ,style: AppTypography.mainStyle.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 50.w,
                              letterSpacing: 0.8
                          ),),
                        Spacer(),
                        skinsInd!=5&&subscribed || skinsInd!=3&&subscribed==false ? InkWell(
                          onTap: () {
                            if (skinsInd >=0&&skinsInd<(subscribed ? 5 : 3)) setState(() => skinsInd++);
                          },
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Icon(
                              Icons.arrow_drop_up,
                              color: AppColors.orange,
                              size: 50.w,
                            ),
                          ),
                        ) : SizedBox(width: 50.w,)
                      ],
                    ) : Row(
                      children: [
                        bgInd!=0 ? InkWell(
                            onTap: () {
                              if (bgInd > 0) setState(() => bgInd--);
                            },
                            child: RotatedBox(
                              quarterTurns: -1,
                              child: Icon(
                                Icons.arrow_drop_up,
                                color: AppColors.orange,
                                size: 50.w,
                              ),
                            )
                        ) : SizedBox(width: 50.w,),
                        Spacer(),
                        Text(bgs[bgInd].name!.toUpperCase()
                          ,style: AppTypography.mainStyle.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 50.w,
                              letterSpacing: 0.8
                          ),),
                        Spacer(),
                        bgInd!=2
                            ? InkWell(
                          onTap: () {
                            if (bgInd >=0&&bgInd<2) setState(() => bgInd++);
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
                            : SizedBox(width: 50.w,),
                      ],
                    ),
                    SizedBox(height: 20.h,),
                    currInd==0
                        ? InkWell(
                      onTap: (){
                        final userData = user;
                        if(userData.availableSkins!.contains(skins[skinsInd].name)==false&&(userData.balance)!>=(skins[skinsInd].price ?? 0)){
                          setState((){
                            userData.balance=userData.balance!-(skins[skinsInd].price ?? 0);
                            userData.availableSkins!.add(skins[skinsInd].name!);
                          });
                        }
                        if(userData.availableSkins!.contains(skins[skinsInd].name)==true&&userData.activeSkin! != skins[skinsInd]){
                          setState(()=>userData.activeSkin=skins[skinsInd].name);
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
                        : InkWell(
                      onTap: (){
                        final userData = user;
                        if(userData.availableBg!.contains(skins[bgInd].name)==false&&(userData.balance)!>= (bgs[bgInd].price?? 0)){
                          setState((){
                            userData.balance=userData.balance!-(bgs[bgInd].price ?? 0);
                            userData.availableBg!.add(bgs[bgInd].name!);
                          });
                        }
                        if(userData.availableBg!.contains(bgs[bgInd].name)==true&&userData.activeBg! != bgs[bgInd]){
                          setState(()=>userData.activeBg=bgs[bgInd].name);
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: () async => false);
  }
  String labelSelector(){
    if (currInd == 0){
      if (Hive
          .box<UserModel>('user')
          .values
          .first
          .activeSkin == skins[skinsInd].name) return 'CHOSEN';
      if (Hive
          .box<UserModel>('user')
          .values
          .first
          .availableSkins!
          .contains(skins[skinsInd].name!) || skins[skinsInd].price==null) return 'CHOOSE';
      return '${skins[skinsInd].price} COINS';
    }
    else {
      if (Hive
          .box<UserModel>('user')
          .values
          .first
          .activeBg == bgs[bgInd].name) return 'CHOSEN';
      if (Hive
          .box<UserModel>('user')
          .values
          .first
          .availableBg!
          .contains(bgs[bgInd].name!) || bgs[bgInd].price==null) return 'CHOOSE';
    }
    return currInd == 0 ? '${skins[skinsInd].price} COINS' : '${bgs[bgInd]
        .price} COINS';
  }
}
