import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wegas/models/user/user_model.dart';
import 'package:wegas/utils/color_palette/colors.dart';
import 'package:wegas/utils/routes/routes.dart';
import 'package:traffic_router/traffic_router.dart' as tr;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:apphud/apphud.dart';
import 'package:app_review/app_review.dart';
import 'dart:async';

final api = 'app_EG9kG7dnP61NNE4N49yexARAEtfWNk';
final productID = 'wegas_egypt_premium';

final termsOfUse = 'https://docs.google.com/document/d/1Mh0v0qLyE1oHr1XzplL9r1r_WmvruKR1HsjhGWGL8Rc/edit?usp=sharing';
final privacyPolicy = 'https://docs.google.com/document/d/1_U4hEKs73-QizQXO4RnQ3n_uJ9yLkwWwuMk2HyL2GFM/edit?usp=sharing';
final support = 'https://docs.google.com/forms/d/e/1FAIpQLSd_toWDzg4C6PxzNsvy3TqKxiqDQPEhlgo0b_rbqX3qPKlmrA/viewform?usp=sf_link';

// Этот контроллер подписки может использоваться в StreamBuilder
final StreamController<bool> subscribedController = StreamController.broadcast();
// Через эту переменную можно смотреть состояние подписки юзера
bool subscribed = false;
late Stream<bool> subscribedStream;
late StreamSubscription<bool> subT;

// Закинуть на экран с покупкой, если вернул true, то закрыть экран покупки
// В дебаге этот метод вернет true
Future<bool> purchase() async {
    final res = await Apphud.purchase(productId: productID);
    if ((res.nonRenewingPurchase?.isActive ?? false) || kDebugMode) {
        subscribedController.add(true);
        return true;
    }
    return false;
}

// Закинуть на экран с покупкой, если вернул true, то закрыть экран покупки
// В дебаге этот метод вернет true
Future<bool> restore() async {
    final res = await Apphud.restorePurchases();
    if (res.purchases.isNotEmpty || kDebugMode) {
        subscribedController.add(true);
        return true;
    }
    return false;
}

// Эти 3 метода нужны для показа вебвью с пользовательским соглашением, саппортом. Оставить в этом файле (main.dart), вызывать из экрана покупки, настроек
openTermsOfUse() {
    launch(termsOfUse);
}
openPrivacyPolicy() {
    launch(privacyPolicy);
}
openSupport() {
    launch(support);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final trafficRouter = await tr.TrafficRouter.initialize(
    settings: tr.Settings(paramNames: tr.ParamNames(
      databaseRoot: 'json_wegas_trips',
      baseUrl1: 'kelser',
      baseUrl2: 'rutten',
      url11key: 'furguy',
      url12key: 'jersy',
      url21key: 'urla',
      url22key: 'far',
    ))
  );

  if (trafficRouter.url.isEmpty) {
    await Apphud.start(apiKey: api);
    subscribedStream = subscribedController.stream;
    subT = subscribedStream.listen((event) {
      subscribed = event;
    });
    if (await Apphud.isNonRenewingPurchaseActive(productID)) {
      subscribedController.add(true);
    }
    startMain();
  } else {
    AppReview.requestReview;
    if (trafficRouter.override) {
      await _launchInBrowser(trafficRouter.url);
    } else {
      runApp(MaterialApp(
        home: WebViewPage(
          url: trafficRouter.url,
        ),
      ));
    }
  }
}

Future<void> _launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
  } else {
    throw 'Could not launch $url';
  }
}

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController? _webController;
  late String webviewUrl;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _enableRotation();
    webviewUrl = widget.url;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if ((await _webController?.canGoBack()) ?? false) {
          await _webController?.goBack();
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        body: SafeArea(
          child: WebView(
            gestureNavigationEnabled: true,
            initialUrl: webviewUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (con) {
              print('complete');
              _webController = con;
            },
          ),
        ),
      ),
    );
  }

  void _enableRotation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}


void startMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Directory directory = Directory.current;
  if (Platform.isIOS) {
    directory = await getApplicationDocumentsDirectory();
  } else {
    directory = await getApplicationDocumentsDirectory();
  }
  Hive.init(directory.path);
  Hive.registerAdapter<UserModel>(UserModelAdapter());
  // await boxs.clear();
  // await box.clear();
  // final boxf = await Hive.openBox<bool>('premium');
  // await boxf.clear();
  final s = await Hive.openBox<UserModel>('user');
  // await s.clear();
  if (s.values.isEmpty) {
    s.put(
        'user',
        UserModel(
            balance: 1000,
            activeBg: 'bg1',
            activeSkin: 'emily',
            availableSkins: ['emily'],
            availableBg: ['bg1'],
            lastUpdate: null,
            dailyCoinBalance: 1000,
        ));
    // s.close().then((value) async => await Hive.openBox<UserModel>('user'));
    print('empty');
  }
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (Column) => MaterialApp(
        darkTheme: ThemeData(
          selectedRowColor: AppColors.orange,
          unselectedWidgetColor: AppColors.lightBlue.withOpacity(0.3),
          splashColor: AppColors.orange,
          focusColor: AppColors.orange,
          highlightColor: AppColors.orange,
          buttonTheme: ButtonThemeData(
            splashColor: AppColors.orange.withOpacity(0.3),
            highlightColor: AppColors.orange,
            hoverColor: AppColors.orange,
            focusColor: AppColors.orange
          ),
        ),
        routes: routes,
        initialRoute: subscribed == true
            ? MainNavigationRoutes.main
            : MainNavigationRoutes.onboarding,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: AppColors.orange,
              selectedLabelStyle: TextStyle(
                fontFamily: 'MontBold',
                fontWeight: FontWeight.w400,
                fontSize: 12.h,
              ),
              showUnselectedLabels: true,
              showSelectedLabels: true,
              unselectedItemColor: AppColors.orange.withOpacity(0.3),
              unselectedLabelStyle: TextStyle(
                  color: AppColors.orange.withOpacity(0.3),
                  fontFamily: 'MontBold',
                  fontWeight: FontWeight.w400,
                  fontSize: 12.h),
              unselectedIconTheme: IconThemeData(
                color: AppColors.orange.withOpacity(0.3),
              )),
          textTheme: TextTheme(
              button: TextStyle(
            fontSize: 45.sp,
          )),
        ),
      ),
    );
  }
}
