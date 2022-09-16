import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_sixvalley_ecommerce/provider/facebook_login_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/featured_deal_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/google_sign_in_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/home_category_product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/location_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/top_seller_provider.dart';
import 'package:flutter_sixvalley_ecommerce/service_app/app/modules/auth/bindings/auth_binding.dart';
import 'package:flutter_sixvalley_ecommerce/service_app/app/modules/root/bindings/root_binding.dart';
import 'package:flutter_sixvalley_ecommerce/service_app/app/routes/theme1_app_pages.dart';
import 'package:flutter_sixvalley_ecommerce/service_app/app/services/firebase_messaging_service.dart';
import 'package:flutter_sixvalley_ecommerce/service_app/app/services/settings_service.dart';
import 'package:flutter_sixvalley_ecommerce/service_app/app/services/translation_service.dart';
import 'package:flutter_sixvalley_ecommerce/service_app/main.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/order_details_screen.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/brand_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/cart_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/category_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/chat_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/coupon_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/localization_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/notification_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/onboarding_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/search_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/seller_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/support_ticket_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/wishlist_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/splash/splash_screen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'di_container.dart' as di;
import 'helper/custom_delegate.dart';
import 'localization/app_localization.dart';
import 'notification/my_notification.dart';
import 'provider/product_details_provider.dart';
import 'provider/banner_provider.dart';
import 'provider/flash_deal_provider.dart';
import 'provider/product_provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  RootBinding().dependencies();
  AuthBinding().dependencies();
  await di.init();
  final NotificationAppLaunchDetails notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  int _orderID;
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    _orderID = (notificationAppLaunchDetails.payload != null &&
            notificationAppLaunchDetails.payload.isNotEmpty)
        ? int.parse(notificationAppLaunchDetails.payload)
        : null;
  }
  await MyNotification.initialize(flutterLocalNotificationsPlugin);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => di.sl<CategoryProvider>(),
      ),
      ChangeNotifierProvider(
        create: (context) => di.sl<LocationProvider>(),
      ),
      ChangeNotifierProvider(
        create: (context) => di.sl<HomeCategoryProductProvider>(),
      ),
      ChangeNotifierProvider(
        create: (context) => di.sl<TopSellerProvider>(),
      ),
      ChangeNotifierProvider(
        create: (context) => di.sl<FlashDealProvider>(),
      ),
      ChangeNotifierProvider(
        create: (context) => di.sl<FeaturedDealProvider>(),
      ),
      ChangeNotifierProvider(
        create: (context) => di.sl<BrandProvider>(),
      ),
      ChangeNotifierProvider(
        create: (context) => di.sl<ProductProvider>(),
      ),
      ChangeNotifierProvider(
        create: (context) => di.sl<BannerProvider>(),
      ),
      ChangeNotifierProvider(
        create: (context) => di.sl<ProductDetailsProvider>(),
      ),
      ChangeNotifierProvider(
        create: (context) => di.sl<OnBoardingProvider>(),
      ),
      ChangeNotifierProvider(
        create: (context) => di.sl<AuthProvider>(),
      ),
      ChangeNotifierProvider(
        create: (context) => di.sl<SearchProvider>(),
      ),
      ChangeNotifierProvider(
        create: (context) => di.sl<SellerProvider>(),
      ),
      ChangeNotifierProvider(
        create: (context) => di.sl<CouponProvider>(),
      ),
      ChangeNotifierProvider(
        create: (context) => di.sl<ChatProvider>(),
      ),
      ChangeNotifierProvider(
        create: (context) => di.sl<OrderProvider>(),
      ),
      ChangeNotifierProvider(
        create: (context) => di.sl<NotificationProvider>(),
      ),
      ChangeNotifierProvider(
        create: (context) => di.sl<ProfileProvider>(),
      ),
      ChangeNotifierProvider(
        create: (context) => di.sl<WishListProvider>(),
      ),
      ChangeNotifierProvider(
        create: (context) => di.sl<SplashProvider>(),
      ),
      ChangeNotifierProvider(
        create: (context) => di.sl<CartProvider>(),
      ),
      ChangeNotifierProvider(
          create: (context) => di.sl<SupportTicketProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<GoogleSignInProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<FacebookLoginProvider>()),
    ],
    child: MyApp(orderId: _orderID),
  ));
}

class MyApp extends StatelessWidget {
  final int orderId;
  MyApp({@required this.orderId});

  static final navigatorKey = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    List<Locale> _locals = [];
    AppConstants.languages.forEach((language) {
      _locals.add(Locale(language.languageCode, language.countryCode));
    });
    return GetMaterialApp(
      title: AppConstants.APP_NAME,
      navigatorKey: navigatorKey,
      onReady: ()
      async {
        await Get.putAsync(() => FireBaseMessagingService().init());
      },
      getPages: Theme1AppPages.routes,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackLocalizationDelegate()
      ],
      supportedLocales: _locals,
      translationsKeys: Get.find<TranslationService>().translations,
      locale: Provider.of<LocalizationProvider>(context, listen: false).locale,
      fallbackLocale: Get.find<TranslationService>().fallbackLocale,
      defaultTransition: Transition.noTransition,
      themeMode: kDebugMode ? ThemeMode.light : ThemeMode.system,
      theme: Get.find<SettingsService>().getLightTheme(),
      darkTheme: Get.find<SettingsService>().getDarkTheme(),
      home: orderId == null
          ? SplashScreen()
          : OrderDetailsScreen(orderModel: null, orderId: orderId),
    );
  }
}
