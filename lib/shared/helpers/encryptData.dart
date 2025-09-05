import 'package:encrypt/encrypt.dart';

import 'consts.dart';

class EncryptData {
  static Encrypted? encryptAES(plainText) {
    if (plainText == "") return null;

    final encrypter = Encrypter(AES(keyEncrypt));

    var encrypted = encrypter.encrypt(plainText, iv: ivEncrypt);
    return encrypted;
  }

  static String decryptAES(Encrypted? encrypted) {
    final encrypter = Encrypter(AES(keyEncrypt));
    var decrypted = encrypter.decrypt(encrypted!, iv: ivEncrypt);
    return decrypted;
  }
}
