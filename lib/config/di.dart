import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rentify_app/utils/prefs_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future di() async {
  await PrefsManager.init();
  await dotenv.load(fileName: ".env.local");
  await Supabase.initialize(url: dotenv.env['SUPABASE_URL']!, anonKey: dotenv.env['SUPABASE_ANON_KEY']!);

  LicenseRegistry.addLicense(() async* {
    final String splineSansLicense = await rootBundle.loadString('google_fonts/spline_sans/OFL.txt');
    yield LicenseEntryWithLineBreaks(<String>['google_fonts'], splineSansLicense);

    final String playfairDisplayLicense = await rootBundle.loadString('google_fonts/playfair_display/OFL.txt');
    yield LicenseEntryWithLineBreaks(<String>['google_fonts'], playfairDisplayLicense);
  });
}
