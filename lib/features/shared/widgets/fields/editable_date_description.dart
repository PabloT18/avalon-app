import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditableDateDescription extends StatelessWidget {
  const EditableDateDescription({
    super.key,
    required this.label,
    required this.dateTextController,
    this.disablePastDates = false,
    this.minSelectedDate, // <--- NUEVO parámetro
    this.onFieldSubmitted,
  });

  final TextEditingController dateTextController;
  final String label;
  final bool disablePastDates;
  final DateTime? minSelectedDate;
  final Function(String)? onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    DateTime now = DateTime.now();

    if (dateTextController.text.isEmpty) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(now);
      dateTextController.text = formattedDate;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppLayoutConst.spaceM),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppLayoutConst.spaceM),
        TextFormField(
          controller: dateTextController,
          focusNode: focusNode,
          keyboardType: TextInputType.datetime,
          onTap: () async {
            focusNode.unfocus();
            // Obtener una instancia única de la fecha actual

            // Si deseas establecer la hora en 00:00:00 para minimumDate
            DateTime minimumDate = DateTime(now.year, now.month, now.day);

            // Si te pasaron minSelectedDate (por ejemplo, la fecha del primer campo),
            // tomamos la máxima de (minimumDate, minSelectedDate):
            final DateTime finalMinDate = minSelectedDate != null
                ? (minSelectedDate!.isAfter(minimumDate)
                    ? minSelectedDate!
                    : minimumDate)
                : minimumDate;

            // Usar la misma instancia de fecha para initialDateTime y minimumDate
            DateTime initialDate = disablePastDates ? finalMinDate : now;

            await showCupertinoModalPopup(
              context: context,
              builder: (context) => Center(
                child: SizedBox(
                  height: 200,
                  child: Card(
                    color: Colors.white,
                    child: CupertinoDatePicker(
                      initialDateTime: initialDate,
                      mode: CupertinoDatePickerMode.date,
                      dateOrder: DatePickerDateOrder.dmy,
                      // initialDateTime: DateTime.now(),
                      // onDateTimeChanged: (DateTime newDateTime) {
                      //   dateTextController.text = newDateTime.toString();
                      // },
                      onDateTimeChanged: (DateTime newDateTime) {
                        String formattedDate =
                            DateFormat('dd/MM/yyyy').format(newDateTime);
                        dateTextController.text = formattedDate;
                      },
                      minimumDate: disablePastDates ? finalMinDate : null,
                      maximumDate:
                          disablePastDates ? null : DateTime.now(), // Opcional
                    ),
                  ),
                ),
              ),
            );

            if (onFieldSubmitted != null) {
              onFieldSubmitted!('');
            }
          },
          decoration: InputDecoration(
            labelText: label,
            //filled: true,
            icon: const Icon(Icons.calendar_today),
            labelStyle:
                const TextStyle(decorationStyle: TextDecorationStyle.solid),
          ),
          onFieldSubmitted: onFieldSubmitted,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return apptexts.appOptions.validators.requiredField;
            }
            return null;
          },
        ),
      ],
    );
  }

  // Método para parsear la cadena 'dd/MM/yyyy' a DateTime de forma segura
  /// y así obtener la fecha del TextController, si existiera.
  DateTime? _tryParseDate(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return null;
    try {
      return DateFormat('dd/MM/yyyy').parse(rawDate);
    } catch (_) {
      return null;
    }
  }
}
