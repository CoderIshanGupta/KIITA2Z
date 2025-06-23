import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _planSyncKeyPrefix = 'plan_sync_';

  static Future<void> savePlanSyncPrefs(Map<String, String> prefs) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    for (var key in prefs.keys) {
      await sp.setString('$_planSyncKeyPrefix$key', prefs[key]!);
    }
  }

  static Future<Map<String, String>> getPlanSyncPrefs() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return {
      'year': sp.getString('${_planSyncKeyPrefix}year') ?? '',
      'semester': sp.getString('${_planSyncKeyPrefix}semester') ?? '',
      'branch': sp.getString('${_planSyncKeyPrefix}branch') ?? '',
      'section': sp.getString('${_planSyncKeyPrefix}section') ?? '',
    };
  }
}
