import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:payday/helper.dart';
import 'package:payday/services/attendance.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  AttendanceService service = AttendanceService();
  Attendance? attendance;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCurrentStatus(context);
    });
  }

  Future<void> getCurrentStatus(BuildContext context) async {
    var res = await service.status(context)
    .catchError((error) {
      if (context.mounted) alert(context, error.toString());
      return null;
    });

    setState(() {
      attendance = res;
    });
  }

  Future<void> checkAttendance(BuildContext context) async {
    var res = await service.check(context).catchError((error) {
      if (context.mounted) alert(context, error.toString());
      return false;
    });

    if (res == true && context.mounted) {
      alert(context, "Check succesfull");
    }

    if (context.mounted) {
      getCurrentStatus(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("dd MMMM yyyy").format(DateTime.now()),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            StreamBuilder(
              stream: Stream.periodic(Duration(minutes: 1)),
              builder: (context, snapshot) {
                return Text(
                  DateFormat("HH:mm").format(DateTime.now()),
                  style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
                );
              }
            ),
            SizedBox(
              height: 70,
            ),
            RawMaterialButton(
              onPressed: () {
                if (attendance?.leftTime != null) return;
                checkAttendance(context);
              },
              child: SizedBox(
                width: 200,
                height: 70,
                child: Opacity(
                  opacity: attendance?.leftTime != null ? .5 : 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xff3DC2EC),
                            Color(0xff4B70F5),
                          ]),
                    ),
                    child: Center(
                        child: Text(
                      attendance == null
                          ? "Check-in Attendance"
                          : attendance!.leftTime == null
                              ? "Check-out Attendance"
                              : "Work Finished",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
