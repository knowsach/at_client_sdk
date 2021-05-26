import 'package:at_client/src/manager/monitor.dart';
import 'package:at_client/src/preference/at_client_preference.dart';
import 'package:at_commons/at_builders.dart';

class MonitorManager {
  static Map<String, Monitor> _monitors;

  static Monitor getMonitor(VerbBuilder monitorVerbBuilder, sucessCallback,
      errorcallback, String atSign, AtClientPreference preference,
      {String regex, DateTime lastNotificationTime, bool retry}) {
    // TODO regex is optional ??
    if ((regex != null) && _monitors[regex] != null) {
      return _monitors[regex];
    }
    var monitor = Monitor(sucessCallback, errorcallback, atSign,
        monitorVerbBuilder.buildCommand(), preference,
        regex: regex, lastNotificationTime: lastNotificationTime, retry: retry);
    _monitors[regex] = monitor;
  }

  static List<Monitor> getMonitors() {}

  static void terminate(Monitor monitor) {
// Eligible for GC
    _monitors.remove(monitor);
  }
}
