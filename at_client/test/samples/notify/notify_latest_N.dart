import 'package:at_client/at_client.dart';
import 'package:at_client/src/service/notification_service.dart';
import 'package:at_commons/at_commons.dart';

import '../test_util.dart';

void main() async {
  final atsign = '@sitaram';
  final preference = TestUtil.getSitaramPreference();
  var atClientManager = await AtClientManager.getInstance()
      .setCurrentAtSign(atsign, 'buzz', preference);
  var heartBeat = AtKey()
    ..key = 'heartbeat.buzz'
    ..sharedWith = '@murali'
    ..sharedBy = '@sitaram'
    ..metadata = (Metadata()..ttr = -1);
  var pulseRate = AtKey()
    ..key = 'pulseRate.buzz'
    ..sharedWith = '@murali'
    ..sharedBy = '@sitaram'
    ..metadata = (Metadata()..ttr = -1);
  for (int i = 0; i < 100; i++) {
    atClientManager.notificationService.notify(
        NotificationParams.notifyLatest(heartBeat, 'buzz-device01', 1,
            value: 'heartRate-$i'),
        onSuccess: _onSuccessCallback,
        onError: _onErrorCallback);
    await Future.delayed((Duration(seconds: 1)));
    atClientManager.notificationService.notify(
        NotificationParams.notifyLatest(pulseRate, 'buzz-device02', 1,
            value: 'pulseRate-$i'),
        onSuccess: _onSuccessCallback,
        onError: _onErrorCallback);
    await Future.delayed(Duration(seconds: 1));
  }
}

void _onSuccessCallback(NotificationResult notificationResult) {
  print('Response from success callback - $notificationResult');
}

void _onErrorCallback(NotificationResult notificationResult) {
  print('Response from error callback - $notificationResult');
}
