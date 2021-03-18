import 'package:at_client/at_client.dart';
import 'package:at_client/src/client/at_client_impl.dart';
import 'package:at_commons/at_commons.dart';

import 'at_demo_data.dart' as demo_data;
import 'test_util.dart';

void main() async {
  try {
    var preference = TestUtil.getSitaramPreference();
    var atsign = '@sitaram🛠';
    //1.
    await AtClientImpl.createClient(atsign, 'buzz', preference);
    var atClient = await AtClientImpl.getClient(atsign);
    await atClient.getSyncManager().init(atsign, preference,
        atClient.getRemoteSecondary(), atClient.getLocalSecondary());
    var metadata = Metadata();
    metadata.namespaceAware = false;
    var result;
    // set pkam private key
    result = await atClient.getLocalSecondary().putValue(AT_PKAM_PRIVATE_KEY,
        demo_data.pkamPrivateKeyMap[atsign]); // set pkam public key
    result = await atClient
        .getLocalSecondary()
        .putValue(AT_PKAM_PUBLIC_KEY, demo_data.pkamPublicKeyMap[atsign]);
    // set encryption private key
    result = await atClient.getLocalSecondary().putValue(
        AT_ENCRYPTION_PRIVATE_KEY, demo_data.encryptionPrivateKeyMap[atsign]);

    // set encryption public key. should be synced
    metadata.isPublic = true;
    var atKey = AtKey()
      ..key = 'publickey'
      ..metadata = metadata;
    result =
        await atClient.put(atKey, demo_data.encryptionPublicKeyMap[atsign]);
    print(result);
  } on Exception catch (e, trace) {
    print(e.toString());
    print(trace);
  }
}
