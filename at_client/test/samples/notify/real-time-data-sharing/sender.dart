import 'dart:convert';

import 'package:at_client/at_client.dart';
import 'package:at_client/src/encryption_service/encryption_manager.dart';
import 'package:at_client/src/service/notification_service.dart';
import 'package:at_commons/at_commons.dart';

import '../../test_util.dart';

class HealthData {
  var heartRate;
  var bloodPressure;
  var timeStampEpoch;
  var deviceId;

  Map toJson() {
    Map map = {};
    map['heartRate'] = heartRate;
    map['bloodPressure'] = bloodPressure;
    map['timeStampEpoch'] = timeStampEpoch;
    map['deviceId'] = deviceId;
    return map;
  }

  HealthData fromJson(Map map) {
    heartRate = map['heartRate'];
    bloodPressure = map['bloodPressure'];
    timeStampEpoch = map['timeStampEpoch'];
    deviceId = map['deviceId'];
    return this;
  }

  HealthData(
      this.heartRate, this.bloodPressure, this.timeStampEpoch, this.deviceId);
}

void main() async {
  var atClientManager = await AtClientManager.getInstance()
      .setCurrentAtSign('@bob', 'me', TestUtil.getBobPreference());
  var heartBeat = 0;
  while (true) {
    var healthData = HealthData(
        heartBeat++, 120 / 80, DateTime.now().millisecondsSinceEpoch, 123);
    await _put(atClientManager, healthData);
    await _putAndCache(atClientManager, healthData);
    await _notify(atClientManager, healthData);
    await Future.delayed(Duration(seconds: 2));
  }
}

Future<void> _put(
    AtClientManager atClientManager, HealthData healthData) async {
  await atClientManager.atClient.put(
      AtKey()
        ..key = 'healthdata'
        ..sharedWith = '@alice',
      jsonEncode(healthData));
  print('put data: ${healthData.heartRate} at ${healthData.timeStampEpoch}');
}

Future<void> _putAndCache(
    AtClientManager atClientManager, HealthData healthData) async {
  await atClientManager.atClient.put(
      AtKey()
        ..key = 'healthdata'
        ..sharedWith = '@alice'
        ..metadata = (Metadata()
          ..ttr = -1
          ..ccd = true),
      jsonEncode(healthData));
  print(
      'put and cache data: ${healthData.heartRate} at ${healthData.timeStampEpoch}');
}

Future<void> _notify(
    AtClientManager atClientManager, HealthData healthData) async {
  var atKey = AtKey()
    ..sharedWith = '@alice'
    ..key = 'healthdata'
    ..sharedBy = '@bob';
  var encryptionManager = AtKeyEncryptionManager.get(atKey, '@bob');
  var encryptedValue =
      await encryptionManager.encrypt(atKey, jsonEncode(healthData));
  atClientManager.notificationService
      .notify(NotificationParams.forText(encryptedValue, '@alice'));
  print('Notify data: ${healthData.heartRate} at ${healthData.timeStampEpoch}');
}
