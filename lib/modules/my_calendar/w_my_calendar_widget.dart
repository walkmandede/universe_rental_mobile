// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:universe_rental/constants/app_constants.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/modules/_common/widgets/w_fitted_widget.dart';
import '../../constants/app_colors.dart';
import 'c_my_calendar.dart';

class MyCalendar extends StatefulWidget {
  final DateTimeRange? initialDateRange;
  final bool xStartWithMonday;
  const MyCalendar({
    super.key,
    this.initialDateRange,
    this.xStartWithMonday = false
  });

  @override
  State<MyCalendar> createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> with TickerProviderStateMixin{

  final controller = Get.put(MyCalendarController());
  ValueNotifier<DateTime> focusedDate = ValueNotifier(DateTime.now().copyWith(day: 1));
  ValueNotifier<DateTime?> startDate = ValueNotifier(null);
  ValueNotifier<DateTime?> endDate = ValueNotifier(null);
  int lastIndex = 0;
  static const maxPageCount = 100000000000;
  PageController pageController = PageController();
  late AnimationController calendarChangeAnimation;
  late AnimationController dateRangeAnimation;


  @override
  void initState() {
    initLoad();
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<MyCalendarController>();
    calendarChangeAnimation.dispose();
    dateRangeAnimation.dispose();
    super.dispose();
  }

  Future<void> initLoad() async{

    calendarChangeAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250)
    );

    dateRangeAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400)
    );

    calendarChangeAnimation.forward();

    //setData
    if(widget.initialDateRange!=null){
      startDate.value = widget.initialDateRange!.start;
      endDate.value = widget.initialDateRange!.start;
      focusedDate.value = startDate.value!.copyWith(day: 1);
    }
    lastIndex = maxPageCount~/2;
    pageController = PageController(initialPage: lastIndex);
  }

  void onPageChanged({required int pageIndex}) async{
    calendarChangeAnimation.reverse().then((value) {
      if(pageIndex>lastIndex){
        //nextMonth
        focusedDate.value = AppFunctions().getNextMonth(dateTime: focusedDate.value).start;
      }
      else{
        //prevMonth
        focusedDate.value = AppFunctions().getPrevMonth(dateTime: focusedDate.value).start;
      }
      lastIndex = pageIndex;
      focusedDate.notifyListeners();
      calendarChangeAnimation.forward();
    });

  }

  void onClickEachDate({required DateTime dateTime}){

    //if tapped date is behind startOfCurrentDateRange it will overwrite as startDate
    //if tapped date is after endOfCurrentDateRange it will overwrite as endDate

    if(startDate.value==null){
      startDate.value = dateTime;
      startDate.notifyListeners();
    }
    else if(endDate.value==null){
      if(dateTime.isBefore(startDate.value!)){
        startDate.value = dateTime;
        startDate.notifyListeners();
      }
      else{
        endDate.value = dateTime;
        endDate.notifyListeners();
        animateDateRange();
      }
    }
    else{
      startDate.value = dateTime;
      startDate.notifyListeners();
      endDate.value = null;
      endDate.notifyListeners();
    }
  }

  void animateDateRange(){
    dateRangeAnimation.reset();
    dateRangeAnimation.forward();
}

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
      child: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: focusedDate,
              builder: (context, fd, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: FittedWidget(
                        mainAxisAlignment: MainAxisAlignment.start,
                        child: IconButton(
                          onPressed: () {
                            pageController.previousPage(duration: const Duration(milliseconds: 400), curve: Curves.linear);
                          },
                          icon: const Icon(Icons.arrow_back_ios_rounded),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FittedWidget(
                        mainAxisAlignment: MainAxisAlignment.center,
                        child: Text(
                            DateFormat("MMMM yyyy").format(focusedDate.value)
                        ),
                      ),
                    ),
                    Expanded(
                      child: FittedWidget(
                        mainAxisAlignment: MainAxisAlignment.end,
                        child: IconButton(
                          onPressed: () {
                            pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.linear);
                          },
                          icon: const Icon(Icons.arrow_forward_ios_rounded),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            flex: 7,
            child: AnimatedBuilder(
              animation: calendarChangeAnimation,
              builder: (context, child) {
                final calendarAnimatedValue = calendarChangeAnimation.value;
                return Opacity(
                  opacity: 0.5 + (calendarAnimatedValue*0.5),
                  child: ValueListenableBuilder(
                    valueListenable: focusedDate,
                    builder: (context, fd, child) {
                      return PageView.builder(
                        controller: pageController,
                        pageSnapping: true,
                        itemCount: maxPageCount,
                        allowImplicitScrolling: true,
                        onPageChanged: (value) {
                          onPageChanged(pageIndex: value);
                        },
                        itemBuilder: (context, index) {
                          int difference = index-lastIndex;
                          DateTime thatMonthFd = fd.copyWith(month: fd.month+difference);
                          List<int?> rawDateData = AppFunctions().getCalendarData(dateTime: thatMonthFd,xStartWithMonday: widget.xStartWithMonday);

                          return ValueListenableBuilder(
                            valueListenable: startDate,
                            builder: (context, sD, child) {
                              return  ValueListenableBuilder(
                                valueListenable: endDate,
                                builder: (context, eD, child) {
                                  return Column(
                                    children: [
                                      Expanded(
                                          child: Row(
                                            children: List.generate(7, (index) {
                                              int weekday = index + 1;
                                              if(!widget.xStartWithMonday){
                                                weekday = [7,1,2,3,4,5,6][index];
                                              }
                                              return Expanded(
                                                child: Center(
                                                  child: FittedWidget(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    child: Text(
                                                        AppFunctions().getWeekdayString(weekday).substring(0,3)
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          )
                                      ),
                                      Expanded(
                                          flex: 6,
                                          child: Column(
                                            children: List.generate(6, (ci) {
                                              return Expanded(
                                                child: Row(
                                                  children: List.generate(7, (ri) {
                                                    int dataIndex = (7*ci) + ri;
                                                    final dayString = (rawDateData[dataIndex]??"-").toString();
                                                    final thatDate = thatMonthFd.copyWith(day: int.tryParse(dayString)??1);
                                                    bool xIncluded = false;
                                                    bool xStartDate = sD == thatDate;
                                                    bool xEndDate = eD == thatDate;
                                                    
                                                    if(dayString=="-"){
                                                      xIncluded = false;
                                                      xStartDate = false;
                                                      xEndDate = false;
                                                    }
                                                    else{
                                                      if(sD!=null && eD !=null){
                                                        var days = AppFunctions().getBetweenDates(dtr: DateTimeRange(start: sD, end: eD)).map(
                                                                (e) => e.toString().substring(0,10)
                                                        ).toList();
                                                        try{
                                                          days.removeLast();
                                                          days.removeAt(0);
                                                        }
                                                        catch(e){
                                                          null;
                                                        }
                                                        xIncluded = days.contains(thatDate.toString().substring(0,10));
                                                      }
                                                    }


                                                    return Expanded(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          vibrateNow();
                                                          onClickEachDate(dateTime: thatDate);
                                                        },
                                                        child: AnimatedBuilder(
                                                          animation: dateRangeAnimation,
                                                          builder: (context, child) {
                                                            final dateRangeAnimatedValue = dateRangeAnimation.value;

                                                            BoxDecoration boxDecoration = BoxDecoration();

                                                            return Stack(
                                                              children: [
                                                                if(xIncluded)LayoutBuilder(
                                                                  builder: (b1, c1) {
                                                                    final cardWidth = c1.maxWidth;
                                                                    double occupiedAmount = controller.getEachCardOccupiedAmount(
                                                                        av: dateRangeAnimatedValue,
                                                                        thatDate: thatDate,
                                                                        dateRange: DateTimeRange(
                                                                            start: startDate.value!,
                                                                            end: endDate.value!
                                                                        )
                                                                    );

                                                                    return Container(
                                                                      width: cardWidth * occupiedAmount,
                                                                      height: double.infinity,
                                                                      decoration: BoxDecoration(
                                                                        color: AppColors.grey.withOpacity(0.4),
                                                                      ),
                                                                      alignment: Alignment.center,
                                                                    );
                                                                  },
                                                                ),
                                                                Builder(
                                                                  builder: (context) {
                                                                    if(xStartDate && xEndDate){
                                                                      return Container(
                                                                        alignment: Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            color: AppColors.black,
                                                                            borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius)
                                                                        ),
                                                                        child: FittedWidget(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          child: Text(
                                                                            dayString,
                                                                            style: TextStyle(
                                                                                color: AppColors.white
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                    else if(xStartDate){
                                                                      return Container(
                                                                        alignment: Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            color: AppColors.black,
                                                                            borderRadius: BorderRadius.horizontal(
                                                                                left: Radius.circular(AppConstants.baseBorderRadius)
                                                                            )
                                                                        ),
                                                                        child: FittedWidget(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          child: Text(
                                                                            dayString,
                                                                            style: TextStyle(
                                                                                color: AppColors.white
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                    else if(xEndDate){
                                                                      return Container(
                                                                        alignment: Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            color: AppColors.black,
                                                                            borderRadius: BorderRadius.horizontal(
                                                                                right: Radius.circular(AppConstants.baseBorderRadius)
                                                                            )
                                                                        ),
                                                                        child: FittedWidget(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          child: Text(
                                                                            dayString,
                                                                            style: TextStyle(
                                                                                color: AppColors.white
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                    else{
                                                                      return Container(
                                                                        alignment: Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            color: Colors.transparent
                                                                        ),
                                                                        child: FittedWidget(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          child: Text(
                                                                            dayString,
                                                                            style: TextStyle(
                                                                                color: dayString=="-"?AppColors.white:AppColors.black
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        )
                                                      ),
                                                    );
                                                  },
                                                  ),
                                                ),
                                              );
                                            },
                                            ),
                                          )
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      )
    );
  }
}


// I am about to draw linear animation with following data;
//
// animatedValue = [0,0.125,0.25,0.375,0.5,0.625,0.75,0.875,1];
//
// index0 = [0,0.5,1,1,1,1,1,1,1];
// index1 = [0,0,0,0.5,1,1,1,1,1];
// index2 = [0,0,0,0,0,0.5,1,1,1];
// index3 = [0,0,0,0,0,0,0,0.5,1];
//
// can you give me linear equation for n index
