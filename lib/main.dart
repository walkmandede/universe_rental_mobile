import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:universe_rental/modules/_common/controllers/c_data_controller.dart';
import 'package:universe_rental/modules/home/v_home_page.dart';
import 'package:universe_rental/web_data_entry/web_data_entry_home_page.dart';
import 'constants/app_colors.dart';
import 'constants/app_constants.dart';
import 'modules/_common/flutter_super_scaffold.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await Future.delayed(const Duration(seconds: 1));
  } catch (e) {
    null;
  }

  runApp(const MyApp());
  // runApp(const RestartAppWidget(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // fucn([3, 4, 5, 6, 9]);
    // toArray('3_6,9_12,24');
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
    return GetMaterialApp(
        // key: GlobalKey(),
        debugShowCheckedModeBanner: false,
        title: 'App Studio',
        navigatorObservers: [routeObserver],
        locale: const Locale('mm', 'MM'),
        fallbackLocale: const Locale('en', 'US'),
        theme: ThemeData(
          primarySwatch: MaterialColor(AppColors.black.value, const {
            050: Color.fromRGBO(29, 44, 77, .1),
            100: Color.fromRGBO(29, 44, 77, .2),
            200: Color.fromRGBO(29, 44, 77, .3),
            300: Color.fromRGBO(29, 44, 77, .4),
            400: Color.fromRGBO(29, 44, 77, .5),
            500: Color.fromRGBO(29, 44, 77, .6),
            600: Color.fromRGBO(29, 44, 77, .7),
            700: Color.fromRGBO(29, 44, 77, .8),
            800: Color.fromRGBO(29, 44, 77, .9),
            900: Color.fromRGBO(29, 44, 77, 1),
          }),
          datePickerTheme: DatePickerTheme.of(context).copyWith(
              headerForegroundColor: AppColors.white,
              elevation: 2,
              shadowColor: AppColors.white.withOpacity(0.4)),
          // datePickerTheme: DatePickerThemeData(
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(15),
          //   ),
          //   headerBackgroundColor: AppColors.black,
          //   backgroundColor: AppColors.white,
          //   dayStyle: TextStyle(color: AppColors.white),
          //   weekdayStyle: TextStyle(
          //     color: AppColors.grey,
          //     fontWeight: FontWeight.w700
          //   ),
          //   yearStyle: TextStyle(
          //     color: AppColors.white
          //   ),
          //   headerHelpStyle: TextStyle(
          //     color: AppColors.white
          //   ),
          //   headerHeadlineStyle: TextStyle(
          //     color: AppColors.white,
          //   ),
          //   rangePickerHeaderHelpStyle: TextStyle(
          //     color: AppColors.white
          //   ),
          //   todayForegroundColor: MaterialStateColor.resolveWith((states) => AppColors.primary),
          //   yearForegroundColor: MaterialStateColor.resolveWith((states) => AppColors.white),
          //   dayForegroundColor: MaterialStateColor.resolveWith((states) => AppColors.white),
          // ),
          fontFamily: 'Nunito',
          fontFamilyFallback: const ['Book'],
          textTheme: TextTheme(
            bodyMedium: AppConstants.defaultTextStyle,
            titleMedium: AppConstants.defaultTextStyle,
            labelLarge: AppConstants.defaultTextStyle,
            bodyLarge: AppConstants.defaultTextStyle,
            bodySmall: AppConstants.defaultTextStyle,
            titleLarge: AppConstants.defaultTextStyle,
            titleSmall: AppConstants.defaultTextStyle,
          ),
          useMaterial3: false,
        ),
        // home: const ScheduleBookingPage(),
        // home: const TestPage1(),
        // home: const ImageUploadTestPage()
        home: homeWidget()
        // home: StatusBarTestingPage1(),
        );
  }

  List toArray(str) {
    List _list = [];
    Set _result = {};
    _list = str.toString().split("");
    for (int i = 0; i < _list.length; i++) {
      print(i);
      if (_list[i] == "_") {
        int _num = int.parse(_list[i - 1]);
        do {
          _result.add(_num);
          _num++;
        } while (_num != int.parse(_list[i + 1]));
        _result.add(int.parse(_list[i + 1]));
      } else if (_list[i] == ",") {
        continue;
      } else if (i == _list.length - 1 && _list[i - 1] == ",") {
        _result.add(int.parse(_list[i]));
      }
    }
    print(_result);
    return [];
  }

  String fucn(List<int> i) {
    //[3,4,5,6,9]
    List<int> arr = [3, 4, 5, 6, 9];

    String _result = arr.first.toString();
    for (int i = 0; i < arr.length; i++) {
      if (i < arr.length - 1 && arr[i] + 1 == arr[i + 1]) {
        print("object");
      } else {
        if (arr[i] - 1 == arr[i - 1]) {
          _result = _result + "_${arr[i]},";
        } else if (_result.endsWith(",")) {
          _result = _result + (arr[i]).toString();
        }
      }
    }

    return _result;
  }

  Widget homeWidget() {
    Get.put(DataController());
    if (kIsWeb) {
      return const WebDataEntryHomePage();
    } else if (Platform.isMacOS) {
      return const WebDataEntryHomePage();
    } else {
      // return const MyCalendarTestPage();
      return const HomePage();
      // return ListingDetailPage(
      //   id: '',
      //   images: [],
      //   imageShownIndex: 0,
      // );
    }
  }
}
