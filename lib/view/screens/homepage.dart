import 'package:final_exam/modal/helper/local_notification.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();

    LocalNotificationHelper.localNotificationHelper
        .initializationLocalNotification();
    LocalNotificationHelper.localNotificationHelper.loadReminder();
  }

  List<Map<String, dynamic>> reminders = [];
  DateTime? selectDatetime;
  TextEditingController reminderController = TextEditingController();

  Future<void> PickedDateTime() async {
    DateTime? pickedDatetime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2070));

    if (pickedDatetime != null) {
      TimeOfDay? pickedtime =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
    }

    if (pickedDatetime != null) {
      selectDatetime = DateTime(
        pickedDatetime.year,
        pickedDatetime.month,
        pickedDatetime.day,
        pickedDatetime.minute,
        pickedDatetime.hour,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alram App",
            style: GoogleFonts.getFont("Mulish",
                textStyle: TextStyle(
                  fontSize: 20,
                ))),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: reminderController,
              decoration: InputDecoration(
                hintText: "Reminder",
                label: Text("Reminder"),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(selectDatetime == null
                        ? 'Pick the date and time'
                        : 'Select Date & Time: ${selectDatetime.toString()}'),
                    IconButton(
                        onPressed: PickedDateTime,
                        icon: Icon(Icons.calendar_month_sharp)),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      LocalNotificationHelper.localNotificationHelper
                          .addreminder();
                    });
                  },
                  child: Text("Set your Reminder")),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Divider(),
          Expanded(
              child: ListView.builder(
                  itemCount: reminders.length,
                  itemBuilder: (context, index) {
                    var reminder = reminders[index];
                    return ListTile(
                      title: Text(reminder['remindertime']),
                      subtitle: Text(reminder['datetime']),
                    );
                  }))
        ],
      ),
    );
  }
}
