import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:at_client/src/preference/at_client_preference.dart';
import 'package:crypto/crypto.dart';

import 'at_demo_data.dart' as demo_data;

class TestUtil {
  static AtClientPreference getPreferenceRemote() {
    var preference = AtClientPreference();
    preference.isLocalStoreRequired = false;
    preference.privateKey = ''; // specify private key of user here.
    preference.rootDomain = 'test.do-sf2.atsign.zone';
    preference.outboundConnectionTimeout = 60000;
    return preference;
  }

  static AtClientPreference getSitaramPreference() {
    var preference = AtClientPreference();
    preference.hiveStoragePath =
        '/home/sitaram/atsign/hive/at_client_1/hive/client';
    preference.commitLogPath =
        '/home/sitaram/atsign/hive/at_client_1/hive/client/commit';
    preference.isLocalStoreRequired = true;
    preference.syncStrategy = SyncStrategy.IMMEDIATE;
    preference.privateKey = demo_data
        .pkamPrivateKeyMap['@sitaram🛠']; // specify private key of user here.
    preference.rootDomain = 'vip.ve.atsign.zone';
    // preference.keyStoreSecret =
    //     _getKeyStoreSecret(''); // path of hive encryption key filefor client
    return preference;
  }

  static AtClientPreference getMuraliPreference() {
    var preference = AtClientPreference();
    preference.hiveStoragePath =
        '/home/sitaram/atsign/hive/at_client/hive/client';
    preference.commitLogPath =
        '/home/sitaram/atsign/hive/at_client/hive/client/commit';
    preference.isLocalStoreRequired = true;
    preference.syncStrategy = SyncStrategy.IMMEDIATE;
    preference.privateKey =
        'MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCjycOqdMbUy6En0EqeRcBu4urDviCyKrNiw2kI9bpiTX9kqA2pmeYjPqoC/rsYsgIQu0hmXDmF/n1MkTsaxL7itXQbJQDc45gP3yGCIIw6QSmIFWivbak81TeGn5GmB9suKRbivyN7hItjmLUFRUhARSZ3bMjAjYmNspATTDAHoc19UnxvxUrJGRZESSEI0liS0TjqQ53HF9r7R9qHEaiMTRFzwrDzFOwvrrgGux+NNX28hZWQU/kntqp64ddPWhRCWyrx7WgzZHNfWNK26mMxyeC5bF5dQXMOeJWcDZWfIWsntu2CuxqKEoxKy4SNcO5MNvXn0E7OZNDm45zATe4FAgMBAAECggEAZYqSqbyYABj2Ii659AGeWaCIly3qK0rZx6MKHSnqkUMmdYrSXZEx4ivZTt4JtDe3nBPfwMXwS6gImk13bRMInJiOEL4SGN9oyH420evHw93eF6XeLtQ3laVCNU38CAja03VZ4N1K7CqyF972avwW3PGB9YwVsXqOCrDnLW+QX0nseX5F7i0oDAHKvQcQi/lIbf4eFP/MC7VJYo4kMeEFw/UpCWsRbh+fCwH4PPcrM768IvoplxtM82w2V2bxnkWZR6Hjp8sD0cvdgE74/chWHVj15yJEfOcwsnu0/rkIe57FpajuAe3lVhVfy986kT0S19HFrMdl70YzNhdnIWLCSQKBgQDU+/cZJH/GZokQAQOn9hynBU4toeUk7rLGzMAlXlLGKmTANcU25c7MdYfuvtsPaEWNKm593MMQkOct4Cn6pqYG4py8Rqlg+qGgQPxWPAWDZRuLunVGGAUYdJy5WrZ77/ihsMTR95Thbvbz5aItQbRO1h3MAYUWDqUbbJPjPF6V1wKBgQDE3jAOCrg9cZWqTeVM/77aMoAOmjqzzGCPg447Ay939NXgA4fv3l1KcT7MAmgiHvOyG1Gl9vQR0RXRPRfng4veabeH+ZFAt6XVP0YCcS64RUIaK+N6A1tk3FeI+BMlMqkzfbv8cz6stmEbJ0GfEjnH3mjsApCdIOfhJx/4RBingwKBgQC3LhZx63ByBVIxD45DcWtnQyrgGHPqddoRHZzNBvkOMvwATL7X3oMkWpmU/1WNRNM8/JeXbL3gi6ApVrkEOTxmg5TmYafgHu/P0tS0nl7niZhNbwraRGJtjC4XRSvaIKSo/E3rgJLt6PBBCOmZHv+jJojuIwiB1gqvMY1oTU3UdQKBgAPFGXh7XhHXJf2P5k82Kop1IxykeXFN/Z9h7oxUwEj0yE+04ZqHUJQHXSN8/E+C9jm36jVaaEwbC+bo25dUXo5QyfHxpoVtvuA5iPatAi8HLH/hzUZd4BcrXQXDcmJo+PKCeuIXtuCJ0Yw6kTghmjeom6vBVNGderNGE4emji5PAoGBAKb8feuoCkpf3VFZxVF6lnrCVudgIl5Uuz7ttt83kcZI+zLAuZhIZHeH5XAI7CXEkOyaa5mYA/AEefcXNHHr88hQ4a2yZ3o38VD0ti+fusQnQ/KV5J2rtYI9HEYdw7QUhRzHAxPKcEsq/lgkFepSUtwphhzHCVp8wuUvDC7wTEpZ'; // specify private key of user here.
    preference.rootDomain = 'vip.ve.atsign.zone';
    // preference.keyStoreSecret =
    //     _getKeyStoreSecret(''); // path of hive encryption key filefor client
    return preference;
  }

  static AtClientPreference getPreferenceLocal() {
    var preference = AtClientPreference();
    preference.hiveStoragePath = 'hive/client';
    preference.commitLogPath = 'hive/client/commit';
    preference.isLocalStoreRequired = true;
    preference.syncStrategy = SyncStrategy.IMMEDIATE;
    preference.privateKey = ''; // specify private key of user here.
    preference.rootDomain = 'test.do-sf2.atsign.zone';
    preference.keyStoreSecret =
        _getKeyStoreSecret(''); // path of hive encryption key filefor client
    return preference;
  }

  static AtClientPreference getAlicePreference() {
    var preference = AtClientPreference();
    preference.hiveStoragePath = 'hive/client';
    preference.commitLogPath = 'hive/client/commit';
    preference.isLocalStoreRequired = true;
    preference.syncStrategy = SyncStrategy.IMMEDIATE;
    preference.privateKey =
        'MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCDVMetuYSlcwNdS1yLgYE1oBEXaCFZjPq0Lk9w7yjKOqKgPCWnuVVly5+GBkYPYN3mPXbi/LHy3SqVM/8s5srxa+C8s5jk2pQI6BgG/RW59XM6vrGuw0pUQoL0bMyQxtR8XAFVgd54iDcgp4ZPLEH6odAgBraAtkIEpfwSwtMaWJCaS/Yn3q6ZoVOxL+O7DHD2dJWmwwjAJyDqEDeeNVuNHWnmj2ZneVXDnsY4fOR3IZdcGArM28FFcFIM6Q0K6XGiLGvJ2pYPywtzwARFChYJTBJYhNNLRgT+MUvx8fbNa6mMnnXQmagh/YvYwmyIUVQK1EhFNZIgezX9xdmIgS+FAgMBAAECggEAEq0z2FjRrFW23MWi25QHNAEXbSS52WpbHNSZJ45bVqcQCYmEMV4B7wAOJ5kszXMRG3USOyWEiO066Q0D9Pa9VafpxewkiicrdjjLcfL76/4j7O7BhgDvyRvMU8ZFMTGVdjn/VpGpeaqlbFdmmkvI9kOcvXE28wb4TIDuYBykuNI6twRqiaVd1LkKg9yoF0DGfSp8OHGWm/wz5wwnNYT6ofTbgV3gSGKOrLf4rC1swHh1VoNXiaYKQQFo2j23vGznC+hVJy8kAkSTMvRy4+SrZ+0MtYrNt0CI9n4hw79BNzwAd0kfJ5WCsYL6MaF8Giyym3Wl77KoiriwRF7cGCEnAQKBgQDWD+l1b6D8QCmrzxI1iZRoehfdlIlNviTxNks4yaDQ/tu6TC/3ySsRhKvwj7BqFYj2A6ULafeh08MfxpG0MfmJ+aJypC+MJixu/z/OXhQsscnR6avQtVLi9BIZV3EweyaD/yN/PB7IVLuhz6E6BV8kfNDb7UFZzrSSlvm1YzIdvQKBgQCdD5KVbcA88xkv/SrBpJcUME31TIR4DZPg8fSB+IDCnogSwXLxofadezH47Igc1CifLSQp4Rb+8sjVOTIoAXZKvW557fSQk3boR3aZ4CkheDznzjq0vY0qot4llkzHdiogaIUdPDwvYBwERzc73CO3We1pHs36bIz70Z3DRF5BaQKBgQC295jUARs4IVu899yXmEYa2yklAz4tDjajWoYHPwhPO1fysAZcJD3E1oLkttzSgB+2MD1VOTkpwEhLE74cqI6jqZV5qe7eOw7FvTT7npxd64UXAEUUurfjNz11HbGo/8pXDrB3o5qoHwzV7RPg9RByrqETKoMuUSk1FwjPSr9efQKBgAdC7w4Fkvu+aY20cMOfLnT6fsA2l3FNf2bJCPrxWFKnLbdgRkYxrMs/JOJTXT+n93DUj3V4OK3036AsEsuStbti4ra0b7g3eSnoE+2tVXl8q6Qz/rbYhKxR919ZgZc/OVdiPbVKUaYHFYSFHmKgHO6fM8DGcdOALUx/NoIOqSTxAoGBALUdiw8iyI98TFgmbSYjUj5id4MrYKXaR7ndS/SQFOBfJWVH09t5bTxXjKxKsK914/bIqEI71aussf5daOHhC03LdZIQx0ZcCdb2gL8vHNTQoqX75bLRN7J+zBKlwWjjrbhZCMLE/GtAJQNbpJ7jOrVeDwMAF8pK+Put9don44Gx';
    preference.rootDomain = 'test.do-sf2.atsign.zone';
    var hashFile = _getShaForAtSign('@alice🛠');
    preference.keyStoreSecret =
        _getKeyStoreSecret('hive/client/' + hashFile + '.hash');
    return preference;
  }

  static AtClientPreference getBobPreference() {
    var preference = AtClientPreference();
    preference.hiveStoragePath = 'hive/client';
    preference.commitLogPath = 'hive/client/commit';
    preference.isLocalStoreRequired = true;
    preference.syncStrategy = SyncStrategy.IMMEDIATE;
    preference.privateKey =
        'MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCxGGbUHy3bpdMQdvQn5F5dAMEbcDsaYDYsvqYAkjLKGPwgl5pk8gdxU6HnWLaXJDwZd4xRaUDHYToGD+k1xp2SEFjMsxD4PAA9k/hKtddEpaDHEGiC3kOf3VD12BJ3VyFsikZutZtgwF7o5cJCdU5Ppqno5ThChV5I3ZUelfoumqQF1iKnZ3z/NdtWAyFs7HNcuO+bL7ls28CNpVkrPxHbydLL/Y/qqR9xeJ5wm8WnQr5YRVFgYGNi03NlsW0UODkE3mufXAC8ALnQ3W9iQa/pW3QXwMKzuyebF29Jfsx/ELvfnzbgRdlKPNEI++phQyMrvZ67uhSewQnAUrW8+aTfAgMBAAECggEBAInMtf6qgDFgd7phBRyhWze85YXnL2YXpS/t7ReWqwSMqmrl7FJN7bKl494zLmiu3kDmv/19C9XYdqDO8qVQdb15EM+/Kh4t+fXwVIw1sFqPEmqy/s+OCUq0mFGjnsLTvoNJmQJ+N3fyWCea2CyEQLpDsgQxkDRauIG0QVs6UiC+EWaolgYtDvNrXgybjjQyvbdSV5jxuYHvt8uzjyUVDQy22mq9H2S3ztI7KqZYoikoAq+baP5RHqD0CBd7hlZPjEo8+aeQN1WeXKiNQGO6JTfWQRquiGpQkwaVXt7kYPwQ0tYrpOXOT9kCWot+aTMbgyIkUmP44IoxMcsyBzi+PVECgYEA5ErweSkb+DGBKSDOcWJDhsfS6jLTu8fe1Y7h9TtRR4436GzpEPFQPd4192e96oe/IjibWQiIqm4KIwXPw7clXMhOtFpMu5935cJfzWkSaa+m9lHRmn/ire52J13KZc7eYpYQiSXue2aKVLQhG1VDXePO+N6M9gR5Mz52IokFzukCgYEAxpbB6mEbk3//hLNknZGj/WTFQV3FNG43sIn9KZckdBV+9sczAetKNvjScuX4ceNG7XyCnVCl9qmz0+TAGmWfnGB/u4EHyRc5iNNo3q/DVRhUPHeOpSdQw+VOEMN47HELdqzOrK0q4BbSJlFdsHjL0P/oFDWVeY0sqghBb8/4SIcCgYB5gU1GH1QsoCSPgE+AV317QeWHEvBQlIuMfJTVEfIrtI0bHsRZaSZ9F0T/3e5d4kwfaaN9GqaqlxC8HT68e0DehholsZ3/ilulJPQaft728y9ZEKkPoxtB2ZZ3U1sDHryMGjTI2jB461WayZiJVLMbSMGDAehilHTxikAUF3vI6QKBgQCU7WInXwPLLeZ1ogMGl74fvX6gcq39j9p7rkAI/Kv90lEQyHpcKhPR/e/08rnKzuLWHtXlHCIaRVHyyk22fhegsk2YVD9+cshW8BRpS+501nX1ksOK310WS9SrhawdxPkP2rBzlrncq8CVs9dLDIvtBL0KytR5/4FLUj2gmJpd6QKBgGNLjdysAYCd0GVVe7kKTuBks12jrMWbJqYq35NRTnKt3qYPe8Xuzy5WETDMWtWleIfXpbb+NEIQJ7ifs3dAJZ6/s/jo/tRawS8Hpa6j2oeGFcvCiI9rukd0gXuUDD2d0//RHxyJXpraE+5wx7JhAFm2opZOez98BgRoo0hISwAj';
    preference.rootDomain = 'root.atsign.org';
    var hashFile = _getShaForAtSign('@bob🛠');
    preference.keyStoreSecret =
        _getKeyStoreSecret('hive/client/' + hashFile + '.hash');
    return preference;
  }

  static List<int> _getKeyStoreSecret(String filePath) {
    var hiveSecretString = File(filePath).readAsStringSync();
    var secretAsUint8List = Uint8List.fromList(hiveSecretString.codeUnits);
    return secretAsUint8List;
  }

  static String _getShaForAtSign(String atsign) {
    var bytes = utf8.encode(atsign);
    return sha256.convert(bytes).toString();
  }
}
