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

  static String formatFecha(DateTime? fecha) {
    if (fecha == null) {
      return '-';
    } else {
      final DateFormat formatter =
          DateFormat('dd \'de\' MMMM \'del\' yyyy', 'es_ES');
      return formatter.format(fecha);
    }
  }

  static String formatFechaLocal(DateTime? fecha, String locale) {
    if (fecha == null) {
      return '-';
    } else {
      String pattern;

      // Detect locale and adjust the pattern
      if (locale == 'es_ES' || locale == 'es') {
        pattern = 'dd \'de\' MMMM \'del\' yyyy';
      } else if (locale == 'en_US' || locale == 'en') {
        pattern = 'MMMM dd, yyyy';
      } else {
        // Fallback pattern (you can customize this)
        pattern = 'MMMM dd, yyyy';
      }

      final DateFormat formatter = DateFormat(pattern, locale);
      return formatter.format(fecha);
    }
  }

  static String formatFechaHoraLocal(DateTime? fecha, String locale) {
    if (fecha == null) {
      return '-';
    }

    final now = DateTime.now();

    // Verificar si es el mismo día
    if (now.year == fecha.year &&
        now.month == fecha.month &&
        now.day == fecha.day) {
      // Devuelve solo la hora (HH:mm)
      return DateFormat('HH:mm', locale).format(fecha);
    }

    // Verificar si es el mismo año
    if (now.year == fecha.year) {
      // Devuelve la fecha en formato dd/MM
      return DateFormat('dd/MM', locale).format(fecha);
    }

    // Si es de un año diferente, devolver la hora y la fecha en formato dd/MM/yy
    return DateFormat('dd/MM/yy', locale).format(fecha);
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
