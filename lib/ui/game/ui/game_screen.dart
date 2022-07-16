import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wegas/gen/assets.gen.dart';
import 'package:wegas/models/user/user_model.dart';
import 'package:wegas/ui/home/ui/home_screen.dart';
import 'package:wegas/utils/apptypography/style.dart';
import 'package:wegas/utils/color_palette/colors.dart';

class GameScreen extends StatefulWidget {
  GameScreen({required this.bet});
  final int bet;
  @override
  State<StatefulWidget> createState() => _GameState();
}

class _GameState extends State<GameScreen> {
  late final List<int> bombs;
  List<int> horStepHistory = List.generate(7, (index) => -1);
  final List<double> coeff = [0, 1.1, 1.3, 1.5,1.7,1.9,2.1,2.3,2.5,2.7,2.7];
  int vertical = 1;
  late double winsum;
  bool showBombs = false;
  int horizontal = 0;
  UserModel user = Hive.box<UserModel>('user').values.first;
  @override
  initState() {
    var rng = Random();
    bombs = List.generate(7, (index) => rng.nextInt(7)+2);
    winsum = widget.bet.toDouble();
    print(bombs);
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    if(horizontal==9||checkBomb())showBombs=true;
    return WillPopScope(
        child: Scaffold(
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/${Hive.box<UserModel>('user').values.first.activeBg}.png'),
                  fit: BoxFit.fill),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 40.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (_) => BackdropFilter(filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),child: Scaffold(
                                    backgroundColor:
                                    Colors.black.withOpacity(0.05),
                                    body: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [Spacer()],
                                        ),
                                        InkWell(
                                          onTap: () => Navigator.pop(context),
                                          child: Container(
                                            width: 279.w,
                                            height: 72.h,
                                            child: Center(
                                              child: Text(
                                                'return'.toUpperCase(),
                                                style: AppTypography.mainStyle.copyWith(
                                                    fontSize: 50.w,
                                                    letterSpacing: 3,
                                                    fontWeight: FontWeight.w100
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 24.h),
                                          child: InkWell(
                                            onTap: () => showCupertinoDialog(
                                                context: context,
                                                builder: (_) =>
                                                    CupertinoAlertDialog(
                                                      content: Text(
                                                          'You will loose the money spent on the game'),
                                                      title:
                                                      Text('Restart the game?'),
                                                      actions: [
                                                        CupertinoDialogAction(
                                                          isDefaultAction: true,
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          child: Text(
                                                            'Cancel',
                                                          ),
                                                        ),
                                                        CupertinoDialogAction(
                                                          onPressed: (){
                                                            user.balance=user.balance!-widget.bet;
                                                            Navigator.pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (_) =>
                                                                        GameScreen(
                                                                          bet: widget.bet,
                                                                        )));
                                                          },
                                                          child: Text('Yes'),
                                                        ),
                                                      ],
                                                    )),
                                            child: Container(
                                              width: 279.w,
                                              height: 72.h,
                                              child: Center(
                                                child: Text(
                                                    'get reward'.toUpperCase(),
                                                    style: AppTypography.mainStyle.copyWith(
                                                        fontSize: 50.w,
                                                        letterSpacing: 3,
                                                        fontWeight: FontWeight.w100
                                                    )
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () => showBombs ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen())) :showCupertinoDialog(
                                              context: context,
                                              builder: (_) =>
                                                  CupertinoAlertDialog(
                                                    content: Text(
                                                        'Are you leaving the game? You loose your bet'),
                                                    title:
                                                    Text('Leave the game?'),
                                                    actions: [
                                                      CupertinoDialogAction(
                                                        isDefaultAction: true,
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: Text(
                                                          'Cancel',
                                                        ),
                                                      ),
                                                      CupertinoDialogAction(
                                                        onPressed: (){
                                                          user.balance=(user.balance!-widget.bet);
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      HomeScreen()));},
                                                        child: Text('Leave'),
                                                      ),
                                                    ],
                                                  )),
                                          child: Container(
                                            width: 279.w,
                                            height: 72.h,
                                            child: Center(
                                              child: Text(
                                                'exit'.toUpperCase(),
                                                style: AppTypography.mainStyle.copyWith(
                                                    fontSize: 50.w,
                                                    letterSpacing: 3,
                                                    fontWeight: FontWeight.w100
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),)),
                              icon: showBombs ? Icon(
                                Icons.arrow_back,
                                color: AppColors.white,
                                size: 30.w,
                              )  :Icon(
                                Icons.menu,
                                color: AppColors.white,
                                size: 30.w,
                              )),
                          RichText(text: TextSpan(
                              text: '${Hive.box<UserModel>('user').values.first.balance}',
                              style: AppTypography.mainStyle.copyWith(
                                  color: AppColors.orange,
                                  fontSize: 32.w
                              ),
                              children: [
                                TextSpan(text:' coins'.toUpperCase(),style: AppTypography.mainStyle.copyWith(
                                    fontSize: 32.w
                                ))
                              ]
                          ),),
                          SizedBox(width: 56.w,)
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text:  TextSpan(
                              text: checkBomb() ? 'you lost by getting into the\n'.toUpperCase() :'your bet - '.toUpperCase(),
                              style: AppTypography.robotoStyle.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22.w
                              ),
                              children: [TextSpan(text: checkBomb() ? 'sarcophagus'.toUpperCase() : '${widget.bet}',style: AppTypography.robotoStyle.copyWith(
                                  color: checkBomb() ? AppColors.white : AppColors.orange,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22.w
                              ),children: [
                                TextSpan(text: checkBomb() ? '' : ' coins'.toUpperCase(),style: AppTypography.robotoStyle.copyWith(
                                    fontSize: 22.w,
                                    fontWeight: FontWeight.w700
                                ),
                                    children: [
                                      TextSpan(text: checkBomb() ? '' :'\ncurrent - X${coeff[vertical]}'.toUpperCase(),style: AppTypography.robotoStyle.copyWith(
                                          fontSize: 22.w,
                                          fontWeight: FontWeight.w700
                                      ))
                                    ]
                                )
                              ])]
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 16.h,),
                        Row(
                          children: [
                            for (int i = 0; i < 10; i++)
                              InkWell(
                                onTap: () async {if(Hive.box<UserModel>('user').values.first.balance!>=widget.bet){
                                  if (bombs[3] != i && vertical == 4) {
                                    user.balance=user.balance!-widget.bet;
                                    setState(() =>
                                    winsum = winsum * coeff[3] + widget.bet);
                                    await Hive.box<UserModel>('user').clear();
                                    await Hive.box<UserModel>('user').add(user);
                                  } else {
                                    await Hive.box<UserModel>('user').clear();
                                    await Hive.box<UserModel>('user').add(user);
                                    print('loose screen');
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) =>
                                    //             LooseScreen(sum: winsum.toInt())));
                                  }
                                }},
                                child: Container(
                                  width: 35.w,
                                  height: 32.h,
                                  decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: i==9 ? AppColors.orange : AppColors.white),
                                        left: BorderSide(color: i==9 ? AppColors.orange : AppColors.white),
                                        right: BorderSide(color: i==9 || i==8 ? AppColors.orange : AppColors.white),
                                      )
                                  ),
                                  child: cellIcon(i, 7),
                                ),
                              )
                          ],
                        ),
                        SizedBox(height: 16.h,),
                        Row(
                          children: [
                            for (int i = 0; i < 10; i++)
                              InkWell(
                                onTap: () async {if(Hive.box<UserModel>('user').values.first.balance!>=widget.bet){
                                  if (bombs[3] != i && vertical == 4) {
                                    user.balance=user.balance!-widget.bet;
                                    setState(() =>
                                    winsum = winsum * coeff[3] + widget.bet);
                                    await Hive.box<UserModel>('user').clear();
                                    await Hive.box<UserModel>('user').add(user);
                                  } else {
                                    await Hive.box<UserModel>('user').clear();
                                    await Hive.box<UserModel>('user').add(user);
                                    print('loose screen');
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) =>
                                    //             LooseScreen(sum: winsum.toInt())));
                                  }
                                }},
                                child: Container(
                                  width: 35.w,
                                  height: 32.h,
                                  decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: i==9 ? AppColors.orange : AppColors.white),
                                        left: BorderSide(color: i==9 ? AppColors.orange : AppColors.white),
                                        right: BorderSide(color: i==9 || i==8 ? AppColors.orange : AppColors.white),
                                      )
                                  ),
                                  child: cellIcon(i, 6),
                                ),
                              )
                          ],
                        ),
                        SizedBox(height: 16.h,),
                        Row(
                          children: [
                            for (int i = 0; i < 10; i++)
                              InkWell(
                                onTap: () async {if(Hive.box<UserModel>('user').values.first.balance!>=widget.bet){
                                  if (bombs[3] != i && vertical == 4) {
                                    user.balance=user.balance!-widget.bet;
                                    setState(() =>
                                    winsum = winsum * coeff[3] + widget.bet);
                                    await Hive.box<UserModel>('user').clear();
                                    await Hive.box<UserModel>('user').add(user);
                                  } else {
                                    await Hive.box<UserModel>('user').clear();
                                    await Hive.box<UserModel>('user').add(user);
                                    print('loose screen');
                                  }
                                }},
                                child: Container(
                                  width: 35.w,
                                  height: 32.h,
                                  decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: i==9 ? AppColors.orange : AppColors.white),
                                        left: BorderSide(color: i==9 ? AppColors.orange : AppColors.white),
                                        right: BorderSide(color: i==9 || i==8 ? AppColors.orange : AppColors.white),
                                      )
                                  ),
                                  child: cellIcon(i, 5),
                                ),
                              )
                          ],
                        ),
                        SizedBox(height: 16.h,),
                        Row(
                          children: [
                            for (int i = 0; i < 10; i++)
                              InkWell(
                                onTap: () async {if(Hive.box<UserModel>('user').values.first.balance!>=widget.bet){
                                  if (bombs[3] != i && vertical == 4) {
                                    user.balance=user.balance!-widget.bet;
                                    setState(() =>
                                    winsum = winsum * coeff[3] + widget.bet);
                                    await Hive.box<UserModel>('user').clear();
                                    await Hive.box<UserModel>('user').add(user);
                                  } else {
                                    await Hive.box<UserModel>('user').clear();
                                    await Hive.box<UserModel>('user').add(user);
                                    print('loose screen');
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) =>
                                    //             LooseScreen(sum: winsum.toInt())));
                                  }
                                }},
                                child: Container(
                                  width: 35.w,
                                  height: 32.h,
                                  decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: i==9 ? AppColors.orange : AppColors.white),
                                        left: BorderSide(color: i==9 ? AppColors.orange : AppColors.white),
                                        right: BorderSide(color: i==9 || i==8 ? AppColors.orange : AppColors.white),
                                      )
                                  ),
                                  child: cellIcon(i, 4),
                                ),
                              )
                          ],
                        ),
                        SizedBox(height: 16.h,),
                        Row(
                          children: [
                            for (int i = 0; i < 10; i++)
                              InkWell(
                                onTap: () async {
                                  if(Hive.box<UserModel>('user').values.first.balance!>=widget.bet){
                                    if (bombs[2] != i && vertical == 3) {
                                      user.balance=user.balance!-widget.bet;
                                      setState(() =>
                                      winsum = winsum * coeff[2] + widget.bet);
                                    } else {
                                      print('Loose');
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (_) => LooseScreen(
                                      //               sum: winsum.toInt(),
                                      //             )));
                                    }
                                  }},
                                child: Container(
                                  width: 35.w,
                                  height: 32.h,
                                  decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: i==9 ? AppColors.orange : AppColors.white),
                                        left: BorderSide(color: i==9 ? AppColors.orange : AppColors.white),
                                        right: BorderSide(color: i==9 || i==8 ? AppColors.orange : AppColors.white),
                                      )
                                  ),
                                  child: cellIcon(i, 3),
                                ),
                              )
                          ],
                        ),
                        SizedBox(height: 16.h,),
                        Row(
                          children: [
                            for (int i = 0; i < 10; i++)
                              InkWell(
                                onTap: () async {if(Hive.box<UserModel>('user').values.first.balance!>=widget.bet){
                                  if (vertical < 2)
                                  if (bombs[1] != i && vertical == 2) {
                                    user.balance=user.balance!-widget.bet;
                                    setState(() => winsum *= coeff[1]);
                                  } else {
                                    print('loose screen');
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) => LooseScreen(
                                    //               sum: winsum.toInt(),
                                    //             )));
                                  }
                                }},
                                child: Container(
                                  width: 35.w,
                                  height: 32.h,
                                  decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: i==9 ? AppColors.orange : AppColors.white),
                                        left: BorderSide(color: i==9 ? AppColors.orange : AppColors.white),
                                        right: BorderSide(color: i==9  || i==8 ? AppColors.orange : AppColors.white),
                                      )
                                  ),
                                  child: cellIcon(i, 2),
                                ),
                              )
                          ],
                        ),
                        SizedBox(height: 16.h,),
                        Row(
                          children: [
                            for (int i = 0; i < 10; i++)
                              Container(
                                width: 35.w,
                                height: 32.h,
                                decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: i==9 ? AppColors.orange : AppColors.white),
                                      left: BorderSide(color: i==9 ? AppColors.orange : AppColors.white),
                                      right: BorderSide(color: i==9  || i==8 ? AppColors.orange : AppColors.white),
                                    )
                                ),
                                child: cellIcon(i, 1),
                              )
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    showBombs==false ?Column(
                      children: [
                        Row(children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(40.r),
                            onTap: ()=>vertical>1&&!showBombs ? setState(()=>vertical--) : null,
                            child: Container(
                              width: 165.w,
                              padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 19.h),
                              decoration: BoxDecoration(
                                  color: AppColors.orange,
                                  borderRadius: BorderRadius.circular(40.r)
                              ),
                              child: Center(child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Down'.toUpperCase(),style: AppTypography.robotoStyle.copyWith(
                                      color: AppColors.black,
                                      fontSize: 22.w,
                                      fontWeight: FontWeight.w700
                                  ),),
                                  RotatedBox(quarterTurns: 1,child: Icon(Icons.arrow_right_alt_outlined,color: AppColors.black,),)
                                ],),),
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: vertical<7&&!showBombs ? ()=>setState(()=>vertical++) : null,
                            borderRadius: BorderRadius.circular(40.r),
                            child: Container(
                              width: 165.w,
                              padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 19.h),
                              decoration: BoxDecoration(
                                  color: AppColors.orange,
                                  borderRadius: BorderRadius.circular(40.r)
                              ),
                              child: Center(child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('up'.toUpperCase(),style: AppTypography.robotoStyle.copyWith(
                                      color: AppColors.black,
                                      fontSize: 22.w,
                                      fontWeight: FontWeight.w700
                                  ),),
                                  RotatedBox(quarterTurns: -1,child: Icon(Icons.arrow_right_alt_outlined,color: AppColors.black,),)
                                ],),),
                            ),
                          )
                        ],),
                        SizedBox(height:16.h),
                        InkWell(
                          onTap: ()=>horizontal+1<10&&!showBombs ? setState(()=>horizontal++) : null,
                          borderRadius: BorderRadius.circular(40.r),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 19.h),
                            decoration: BoxDecoration(
                                color: AppColors.orange,
                                borderRadius: BorderRadius.circular(40.r)
                            ),
                            child: Center(child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Move forward'.toUpperCase(),style: AppTypography.robotoStyle.copyWith(
                                    color: AppColors.black,
                                    fontSize: 22.w,
                                    fontWeight: FontWeight.w700
                                ),),
                                Icon(Icons.arrow_right_alt_outlined,color: AppColors.black,)
                              ],),),
                          ),
                        ),
                      ],
                    ) : checkBomb()
                        ? InkWell(
                      onTap: () async {
                        final box =  Hive.box<UserModel>('user');
                        var user = box.values.first;
                        user.balance=(user.balance)!-widget.bet;
                        await box.clear();
                        box.put('user', user);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>HomeScreen()));
                      },
                      borderRadius: BorderRadius.circular(40.r),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 19.h),
                        decoration: BoxDecoration(
                            color: AppColors.orange,
                            borderRadius: BorderRadius.circular(40.r)
                        ),
                        child: Center(child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Try again'.toUpperCase(),style: AppTypography.robotoStyle.copyWith(
                                color: AppColors.black,
                                fontSize: 22.w,
                                fontWeight: FontWeight.w700
                            ),),
                          ],),),
                      ),
                    )
                        : InkWell(
                      onTap: () async {
                        final box = Hive.box<UserModel>('user');
                        user = box.values.first;
                        print(winsum*coeff[vertical]);
                        user.balance=(user.balance)!+(winsum*coeff[vertical]).round();
                        await box.clear();
                        await box.put('user', user);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
                      },
                      borderRadius: BorderRadius.circular(40.r),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 19.h),
                        decoration: BoxDecoration(
                            color: AppColors.orange,
                            borderRadius: BorderRadius.circular(40.r)
                        ),
                        child: Center(child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Get your reward'.toUpperCase(),style: AppTypography.robotoStyle.copyWith(
                                color: AppColors.black,
                                fontSize: 22.w,
                                fontWeight: FontWeight.w700
                            ),),
                          ],),),
                      ),
                    ),
                    SizedBox(height: 30.h,)
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: () async => false);
  }
  Widget? cellIcon(int indexCell, int stepInd) {
    if (vertical == stepInd &&horizontal==indexCell&&
        bombs[stepInd - 1] == indexCell&& showBombs)
      return Center(
        child: Image.asset(
          Assets.images.onbomb.path,
          filterQuality: FilterQuality.high,
          height: 30.h,
        ),
      );
    if ((indexCell == bombs[stepInd - 1])&&showBombs==true)
      return Center(
        child: Image.asset(
          Assets.images.bomb.path,
          filterQuality: FilterQuality.high,
          height: 30.h,
        ),
      );
    if ((vertical == 4 &&
            bombs[3] != indexCell &&
            indexCell != horizontal &&
            stepInd > 3) ||
        (horStepHistory[stepInd - 1] == indexCell && vertical > stepInd))
      return Container();
    if (vertical < 4 && stepInd - 1 == vertical)
      return Container();
    if ((stepInd == 1 && indexCell == 1 && vertical > 1) ||
        (vertical > stepInd &&
            bombs[stepInd - 1] != indexCell &&
            bombs[stepInd - 1] != indexCell &&
            bombs[stepInd - 1] != -100 &&
            stepInd > 1) ||
        (horizontal != indexCell && vertical == stepInd && stepInd!=1))
      return Container();
    return indexCell == horizontal && vertical == stepInd
        ? Padding(
      padding: EdgeInsets.all(1.h),
      child: Center(
        child: Image.asset(
          'assets/images/${user.activeSkin}cell.png',
          height: 29.h,
        ),
      ),
    )
        : null;
  }
  bool checkBomb(){
    return horizontal==bombs[vertical-1] ? true : false;
  }
}
