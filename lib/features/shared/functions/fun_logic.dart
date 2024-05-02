import 'package:intl/intl.dart';

class UtilsFunctionsLogic {
  static String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('dd/MM/yy');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = date.difference(now);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date); // Doesn't get called when it should be
    } else {
      time = '${diff.inDays} DAYS AGO'; // Gets call and it's wrong date
    }

    return time;
  }

  static String getAcronimo(String cadena) {
    List<String> split;
    split = cadena.split(' ');
    var acronimo = '';
    for (var i = 0; i < split.length; i++) {
      if (split[i] != 'de') acronimo = acronimo + split[i][0].toUpperCase();
    }
    return (acronimo.length > 3) ? acronimo.substring(0, 3) : acronimo;
  }

  static String getFirstWord(String value) {
    final s = value.split(' ')[0];
    return s;
  }

  static String getFirstTreeWord(String value) {
    final s = value.split(' ')[0];
    return s;
  }

  static String getFirstUpperCase(String value) {
    value = value.toLowerCase();
    String finalWord = '';
    for (var word in value.split(' ')) {
      finalWord =
          '$finalWord${word[0].toUpperCase()}${word.substring(1).toLowerCase()} ';
    }
    return finalWord.trimRight();
  }

  /// [Validators]
  static String? validateCorreo(String? correo, String errorMsg,
      {String? correoInsMsg}) {
    // Expresión regular para validar un correo electrónico con dominio específico

    if (correo == null || correo.isEmpty) {
      return errorMsg;
    } else {
      String pattern = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$';
      RegExp regExp = RegExp(pattern);
      bool isValid = regExp.hasMatch(correo);
      return isValid ? null : correoInsMsg;
    }
  }

  static String? validateDataNull(String? mensaje, String errorMsg) {
    if (mensaje == null || mensaje.isEmpty) {
      return errorMsg;
    }
    return null;
  }
}
