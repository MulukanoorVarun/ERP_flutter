import 'package:flutter/material.dart';
import '../models/AttendanceHistoryresponse.dart';

class CalendarAdapter extends StatelessWidget {
  final DateTime month;
  final DateArray? dateArray; // Define dateArray here
  final Function(DateTime) dateListener;

  CalendarAdapter({
    required this.month,
    required this.dateArray,
    required this.dateListener,
  });

@override
  Widget build(BuildContext context) {
    // Calculate the start date (January 26th) for the selected month
    DateTime startDate = DateTime(month.year, month.month-1, 26);
    // Calculate the end date (February 25th) for the selected month
    DateTime endDate = DateTime(month.year, month.month, 25);

        // Calculate the starting day of the week for the month
        // Adjust the calculation to start from Sunday (index 0)
        int startDayOfWeek = startDate.weekday % 7; // Sunday as 0, Monday as 1, ..., Saturday as 6

        // Create a list to hold the dates for the entire month
        List<String> dates = [];

        // Add empty placeholders for days before the start of the month
        for (int i = 0; i < startDayOfWeek; i++) {
          dates.add('');
        }

        // Add the dates for the month
        for (DateTime date = startDate; date.isBefore(endDate) || date.isAtSameMomentAs(endDate); date = date.add(Duration(days: 1))) {
          dates.add(date.day.toString());
        }

        // Add empty placeholders for days after the end of the month to fill the last row
        while (dates.length % 7 != 0) {
          dates.add('');
        }
    //
    // // Iterate over the DateArray and store dates in a separate list
    // List<String> dateArrayDates = [];
    // dateArray?.toJson().forEach((key, value) {
    //   if (value != null && value.isNotEmpty) {
    //     dateArrayDates.add(key);
    //   }
    // });
    // print("dateArray.toJson(): ${dateArray?.toJson()}");
    //
    //  print("dateArrayDates:${dateArrayDates}");


    // Iterate over the DateArray keys and store them in a separate list
    List<String> dateArrayDates = [];
    dateArray?.toJson().keys.forEach((key) {
      dateArrayDates.add(key);
    });

    print("dateArrayDates: $dateArrayDates");

        return GridView.builder(
          itemCount: dates.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            crossAxisSpacing: 2,
            mainAxisSpacing: 25,
            childAspectRatio: (255 / 190),
          ),
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0), // Adjusted padding for Sunday
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final date = dates[index];
            if (date.isNotEmpty) {
              return InkWell(
                onTap: () {
                  dateListener(DateTime.utc(2024, 2, int.parse(date)));
                },
                child: Card(
                  elevation: 0,
                  shadowColor: Colors.black,
                  child: Column(
                  children:[
                  Center(
                    child: Text(
                      date,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orangeAccent,
                      ),
                    ),
                ],
                ),
                ),
              );
            } else {
              return Card(
                elevation: 0,
                shadowColor: Colors.transparent,
              );
            }
          },
        );
      }

}













