import 'dart:convert';

import 'package:at_client/at_client.dart';
import 'package:at_client/src/decryption_service/decryption_manager.dart';
import 'package:at_commons/at_commons.dart';

import '../../test_util.dart';

AtClientManager? atClientManager;

void main() async {
  try {
    final aliceAtSign = '@alice';
    final atClientManager = await AtClientManager.getInstance()
        .setCurrentAtSign(aliceAtSign, 'wavi', TestUtil.getAlicePreference());

    // alice - listen for notification
    atClientManager.notificationService
        .subscribe(regex: '')
        .listen((notification) {
      _notificationCallback(notification);
    });
  } on Exception catch (e, trace) {
    print(e.toString());
    print(trace);
  }
  await Future.delayed(Duration(minutes: 60));
  print('end of test');
}

Future<void> _notificationCallback(AtNotification notification) async {
  if (notification.key.contains('_latestNotificationId')) {
    return;
  }
  //
  if (notification.value == null &&
      notification.key == '@murali:healthdata.me@sitaram') {
    AtValue response = await atClientManager!.atClient.get(AtKey()
      ..key = 'healthdata'
      ..sharedBy = '@sitaram');
    print('Notification value from get method: ${response.value}');
  } else if (notification.value == null) {
    var result = notification.key.replaceAll('@murali:', '');
    var atKey = AtKey()
      ..key = notification.key
      ..sharedBy = notification.from
      ..sharedWith = notification.to;
    var decryptionService = AtKeyDecryptionManager.get(atKey, '@murali');

    var value = await decryptionService.decrypt(atKey, result);
    value = value.toString().trim();
    print('Notification value from notifyText method: ${jsonDecode(value)}');
  } else {
    var atKey = AtKey()
      ..key = notification.key
      ..sharedBy = notification.from
      ..sharedWith = notification.to;
    var decryptionService = AtKeyDecryptionManager.get(atKey, '@murali');

    var value = await decryptionService.decrypt(atKey, notification.value);
    value = value.toString().trim();
    print('Notification value from cached data: ${jsonDecode(value)}');
  }
}
