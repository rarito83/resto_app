import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:resto_app/common/navigation.dart';
import 'package:resto_app/data/model/resto_response.dart';
import 'package:rxdart/subjects.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  var index;

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('resto');

    var initializationSettingsIOS = const IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestoResponse restoResponse) async {
    var _channelId = "11";
    var _channelName = "channel_11";
    var _channelDescription = "resto channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    Random random = Random();
    int randomNum = random.nextInt(restoResponse.restaurants.length + 1);
    var restaurant = restoResponse.restaurants[randomNum];

    var titleNotification = "<b>Mau pesan makanan dimana hari ini?</b>";
    var titleName = 'Resto ' + restaurant.name;

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      titleName,
      platformChannelSpecifics,
      payload: json.encode(restaurant.toJson()),
    );
  }

  void configureSelectNotificationSubject(BuildContext context, String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = RestoResponse.fromJson(json.decode(payload));
        var restaurant = data.restaurants[index];
        Navigation.intentWithData(route, restaurant);
      },
    );
  }
}
