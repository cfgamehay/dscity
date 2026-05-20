import 'package:intl/intl.dart';

final _formatDate = DateFormat('HH:mm dd-MM-yyyy');
final _formatDateEn = DateFormat('yyyy-MM-dd HH:mm');
final _formatHm = DateFormat('HH:mm');
final _formatDMY = DateFormat('dd-MM-yyyy');
final _formatYMD = DateFormat('yyyy-MM-dd');

extension DateTimeFormat on DateTime {
  String get formatDate => _formatDate.format(this);
  String get formatDateEn => _formatDateEn.format(this);
  String get formatHm => _formatHm.format(this);
  String get formatDMY => _formatDMY.format(this);
  String get formatYMD => _formatYMD.format(this);

  // String formatDateTime(BuildContext context) {
  //   final now = DateTime.now().toLocal();
  //   final difference = DateTime(now.year, now.month, now.day)
  //       .difference(DateTime(year, month, day))
  //       .inDays;

  //   // If the date is today, show hours:minutes (HH:mm)
  //   if (difference == 0) {
  //     return DateFormat('HH:mm').format(this);
  //   }

  //   // If the date is within the last 7 days, show weekday (Mon, Tue, etc.)
  //   if (difference > 0 && difference <= 7) {
  //     // return DateFormat('EEEE').format(this); // Full day name
  //     return _getWeekday(context, weekday);
  //   }

  //   // If the date is older than 7 days, show day/month/year (dd/MM/yyyy)
  //   //Get language code
  //   final languageCode = Localizations.localeOf(context).languageCode;
  //   if (languageCode == 'vi') {
  //     return _formatDMY.format(this);
  //   }
  //   return _formatYMD.format(this);
  // }

  // String formatWeekday(BuildContext context) {
  //   return _getWeekday(context, weekday);
  // }

  // Helper method to map weekday to Vietnamese names
  // String _getWeekday(BuildContext context, int weekday) {
  //   switch (weekday) {
  //     case DateTime.monday:
  //       return context.loc.txtMon;
  //     case DateTime.tuesday:
  //       return context.loc.txtTue;
  //     case DateTime.wednesday:
  //       return context.loc.txtWed;
  //     case DateTime.thursday:
  //       return context.loc.txtThu;
  //     case DateTime.friday:
  //       return context.loc.txtFri;
  //     case DateTime.saturday:
  //       return context.loc.txtSat;
  //     case DateTime.sunday:
  //       return context.loc.txtSun;
  //     default:
  //       return '';
  //   }
  // }
}
