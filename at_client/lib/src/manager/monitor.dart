import 'dart:io';
import 'package:at_client/at_client.dart';
import 'package:at_lookup/at_lookup.dart';
import 'package:at_lookup/src/connection/outbound_connection.dart';
import 'package:at_lookup/src/connection/outbound_connection_impl.dart';

class Monitor {
  // Regex on whith what the monitor is started
  var _regex;

  // Date and time of the last notification received on this minotor
  var _lastNotificationTime;

  // Status on the monitor
  MonitorStatus status = MonitorStatus.NotStarted;

  var _retry = false;

  OutboundConnection outboundConnection;

  Function _sucessCallback;

  Function _errorCallback;

  var _atSign;

  AtClientPreference _preference;

  var _monitorConnection;

  var _command;

  // Constructor
  Monitor(sucessCallback, errorCallback, String atSign, String command,
      AtClientPreference preference,
      {String regex, DateTime lastNotificationTime, bool retry = false}) {
    _sucessCallback = sucessCallback;
    _errorCallback = errorCallback;
    _atSign = atSign;
    _preference = preference;
    _regex = regex;
    _lastNotificationTime = lastNotificationTime;
    _retry = retry;
    _command = command;
  }

// Starts the monitor by establishing a TCP/IP connection with the secondary server
  Future<void> start() async {
    // Step1 : create a TCP/IP socket connection
    //1. Get a new outbound connection dedicated to monitor verb.
    _monitorConnection = await _createConnection(
        _atSign, _preference.rootDomain, _preference.rootPort);
    if (_monitorConnection.isInValid()) {
      status = MonitorStatus.Errored;
      _errorCallback(this);
      return;
    }

    await _authenticateConnection(_atSign, _monitorConnection);
    await _monitorConnection.write(_command);

    // Step 2: connection.write("Monitor:<_regex>:<_lastNotificationTime>")
    // Step 3: onDone and onError() _handleError(e);
    // Step 4: connection.read() =  _handleResponse(response);

    status = MonitorStatus.Started;
    _sucessCallback(this);
  }

// Stops the monitor from receiving notification
  Future<void> stop() {
    status = MonitorStatus.Stopped;
    _monitorConnection.close();
  }

// Stops the monitor from receiving notification
  MonitorStatus getStatus() {
    return status;
  }

  _handleResponse(response) {
    // Check partial response etc..
    // Parse the notifications
    // Step 1: set _lastNotificationTime = latestOfTheseNotofications;
    // Add to secondary store if needed, if we aredoing this we should give a chance to delete this.
    // Step 2: call sucessCallback(List<notification>)
  }

  _handleError(e) {
    status = MonitorStatus.Errored;
    // Pass monitor and error
    _errorCallback(this, e);
    // TBD : If retry = true should the errorCallBack needs to be called?
    if (_retry) {
      // We will use a strategy here
      Future.delayed(Duration(seconds: 5), start);
    }
  }

  getLastNotificationTime() {
    return _lastNotificationTime;
  }

  getRegex() {
    return _regex;
  }

  Future<OutboundConnection> _createConnection(
      String toAtSign, String rootDomain, int rootPort) async {
    /// Create a new connection for monitor verb.
    //1. find secondary url for atsign from lookup library
    var secondaryUrl =
        await AtLookupImpl.findSecondary(toAtSign, rootDomain, rootPort);
    var secondaryInfo = _getSecondaryInfo(secondaryUrl);
    var host = secondaryInfo[0];
    var port = secondaryInfo[1];

    //2. create a connection to secondary server
    var secureSocket = await SecureSocket.connect(host, int.parse(port));
    OutboundConnection _monitorConnection =
        OutboundConnectionImpl(secureSocket);
    return _monitorConnection;
  }

  List<String> _getSecondaryInfo(String url) {
    var result = <String>[];
    if (url != null && url.contains(':')) {
      var arr = url.split(':');
      result.add(arr[0]);
      result.add(arr[1]);
    }
    return result;
  }

  /// To authenticate connection via PKAM verb.
  Future<OutboundConnection> _authenticateConnection(
      String _atSign, OutboundConnection _monitorConnection) async {
    // await _monitorConnection.write('from:$_atSign\n');
    // var fromResponse = await _getQueueResponse();
    // //logger.info('from result:$fromResponse');
    // fromResponse = fromResponse.trim().replaceAll('data:', '');
    // //logger.info('fromResponse $fromResponse');
    // var key = RSAPrivateKey.fromString(_preference.privateKey);
    // var sha256signature = key.createSHA256Signature(utf8.encode(fromResponse));
    // var signature = base64Encode(sha256signature);
    // //logger.info('Sending command pkam:$signature');
    // await _monitorConnection.write('pkam:$signature\n');
    // var pkamResponse = await _getQueueResponse();
    // if (!pkamResponse.contains('success')) {
    //   throw UnAuthenticatedException('Auth failed');
    // }
    return _monitorConnection;
  }

}

enum MonitorStatus { NotStarted, Started, Stopped, Errored }
