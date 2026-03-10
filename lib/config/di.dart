import 'package:rentify_app/utils/prefs_manager.dart';

Future di() async {
  await PrefsManager.init();
}
