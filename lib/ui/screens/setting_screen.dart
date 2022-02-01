import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/preferences.dart';
import 'package:resto_app/provider/preference_provider.dart';
import 'package:resto_app/provider/schedule_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = '/setting';

  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PreferenceProvider>(
      create: (context) => PreferenceProvider(
        preferences:
            Preferences(sharedPreferences: SharedPreferences.getInstance()),
      ),
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Setting',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            )),
        body: Consumer<PreferenceProvider>(
          builder: (context, provider, child) {
            return ChangeNotifierProvider<ScheduleProvider>(
              create: (context) => ScheduleProvider(),
              child: Material(
                child: ListTile(
                  title: Text('Daily reminder'),
                  trailing: Consumer<ScheduleProvider>(
                      builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: provider.isDailyReminderActive,
                      onChanged: (value) async {
                        scheduled.scheduledResto(value);
                        provider.enableDailyReminder(value);
                      },
                    );
                  }),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
