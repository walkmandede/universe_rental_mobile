import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_widget_cache.dart';
import 'package:universe_rental/modules/my_calendar/w_my_calendar_widget.dart';

class MyCalendarTestPage extends StatefulWidget {
  const MyCalendarTestPage(
      {super.key, required this.selectedDateTimeRange, this.onChangeDate});
  final DateTimeRange selectedDateTimeRange;
  final void Function(DateTimeRange)? onChangeDate;
  @override
  State<MyCalendarTestPage> createState() => _MyCalendarTestPageState();
}

class _MyCalendarTestPageState extends State<MyCalendarTestPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              // color: Colors.amber,
              width: double.infinity,
              // margin: EdgeInsets.symmetric(
              //   horizontal: Get.width*0.2,
              //   vertical: Get.width*0.2
              // ),
              child: AspectRatio(
                aspectRatio: 2 / 2,
                child: MyCalendar(
                    initialDateRange: DateTimeRange(
                        start: widget.selectedDateTimeRange.start,
                        end: widget.selectedDateTimeRange.end),
                    xStartWithMonday: false,
                    onChangeDate: widget.onChangeDate),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
