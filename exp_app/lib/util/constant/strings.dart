import 'package:package_info/package_info.dart';

class Strings {
  static String helloWorld = 'Hello World!';

  /* ACTIONS */
  static String newEntryButton = 'ADD NEW ENTRY';
  static String confirm = 'CONFIRM';
  static String cancel = 'CANCEL';
  static String delete = 'DELETE';
  static String loading = 'LOADING';
  static String sep = '|';

  /* INFO PAGE */
  static String retrievingAppV = 'retrieving app version...';
  static String failRetrieveAppV = 'failed to retrieve the app version';

  static Future<String> appVersion =
      PackageInfo.fromPlatform().then((info) => 'v' + info.version);
  static String appDesc =
      'Thank you for checking out the alpha version of this app.';
  static String reportBug = 'Report a bug';
  static String buildType =
      '-alpha'; // NOTE pick between '-alpha', '-beta' or ''

  /* DB HELPER */
  static String dbFailedList = 'failed to read list';
  static String dbFailedEntryTitle = 'problem loading entry...';
  static String dbFailedEntryAmount = '0.00';
  static String dbFailedEntryDate = '2021-01-01';
  static String dbPrevVerListName = 'old version list';

  /* EXPENSE LIST HEADER */
  static String appName = 'EXP';
  static String total = 'TOTAL';
  static String thisMonth = 'THIS MONTH';

  /* NEW ENTRY DIALOG */
  static String nedTitle = 'TITLE';
  static String nedAmount = 'AMOUNT';

  /* NEW LIST DIALOG */
  static String nldName = 'NEW LIST';

  /* EXPENSE ENTRY */
  static String expEntryDefTitle = 'expense';
  static String expEntryDefAmount = '0.00';

  /* INFO TILE */
  static String infoThisMonth = 'THIS MONTH: ';
}
