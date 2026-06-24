// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malayalam (`ml`).
class AppLocalizationsMl extends AppLocalizations {
  AppLocalizationsMl([String locale = 'ml']) : super(locale);

  @override
  String get appTitle => 'ട്രാഫിക് പട്രോൾ';

  @override
  String get home => 'ഹോം';

  @override
  String get camera => 'ക്യാമറ';

  @override
  String get upload => 'അപ്‌ലോഡ്';

  @override
  String get login => 'ലോഗിൻ';

  @override
  String get settings => 'ക്രമീകരണങ്ങൾ';

  @override
  String get theme => 'തീം';

  @override
  String get language => 'ഭാഷ';

  @override
  String get light => 'ലൈറ്റ്';

  @override
  String get dark => 'ഡാർക്ക്';

  @override
  String get system => 'സിസ്റ്റം';

  @override
  String get english => 'ഇംഗ്ലീഷ്';

  @override
  String get loginFailed => 'ലോഗിൻ പരാജയപ്പെട്ടു';

  @override
  String get ok => 'ശരി';

  @override
  String get usernamePasswordRequired => 'ഉപയോക്തൃനാമവും പാസ്‌വേഡും ആവശ്യമാണ്.';

  @override
  String get invalidCredentials => 'തെറ്റായ ഉപയോക്തൃനാമം അല്ലെങ്കിൽ പാസ്‌വേഡ്.';

  @override
  String get username => 'ഉപയോക്തൃനാമം';

  @override
  String get password => 'പാസ്‌വേഡ്';

  @override
  String get dontHaveAccountSignUp => 'അക്കൗണ്ട് ഇല്ലേ? സൈൻ അപ്പ് ചെയ്യുക';

  @override
  String get appBarTitle => 'ട്രാഫിക് പട്രോൾ v2.1';

  @override
  String get automatedViolationDetection =>
      'സ്വയശക്തമാക്കിയ ലംഗന ശിക്ഷണ കണ്ടെത്തൽ';

  @override
  String get aiPoweredTrafficSystem =>
      'AI സഹായത്തോടെ ട്രാഫിക്\nനിയന്ത്രണ വിധാനം';

  @override
  String get captureDetectReportProtect =>
      ' പിടിക്കുക · കണ്ടെത്തുക · റിപ്പോർട്ട് · സംരക്ഷിക്കുക';

  @override
  String get systemOnline => 'സിസ്റ്റം ഓണ്‍ലൈനില്‍';

  @override
  String get mlKitActive => 'ML കിറ്റ് ● ആക്‌ടീവ്';

  @override
  String get selectOperation => 'ഓപറേഷൻ തിരഞ്ഞെടുക്കുക';

  @override
  String get captureViolation => 'ലംഗന ശിക്ഷണ പകരം';

  @override
  String get openCameraDetectReport =>
      ' ക്യാമറ തുറക്കുക · കണ്ടെത്തുക · റിപ്പോർട്ട്';

  @override
  String get violations => 'ലംഗന ശിക്ഷണങ്ങൾ';

  @override
  String get records => 'റെക്കോർഡുകൾ';

  @override
  String get points => 'പോയിന്റുകൾ';

  @override
  String get rewards => 'ബഹുമതികൾ';

  @override
  String get contents => 'ഉള്ളടക്കം';

  @override
  String get info => 'വിവരങ്ങൾ';

  @override
  String get account => 'അക്കൗണ്ട്';

  @override
  String get footerText => 'ട്രാഫിക് പട്രോൾ നിയന്ത്രണ വിധാനം ©2025';

  @override
  String get cameraPageTitle => 'ക്യാമറ';

  @override
  String get describeViolation => 'ലംഗന ശിക്ഷണം വിശദീകരിക്കുക';

  @override
  String get editOrConfirmDescription =>
      'AI വിശദീകരണം എഡിറ്റ് ചെയ്യുക അല്ലെങ്കിൽ സ്ഥിരീകരിക്കുക...';

  @override
  String get cancel => 'ലഘൂകരിക്കുക';

  @override
  String get uploadSuccess => 'വിച്ച്ഫലനമായി അപ്‌ലോഡ് ചെയ്യപ്പെട്ടു!';

  @override
  String uploadError(String error) {
    return 'അപ്‌ലോഡ് പിഴവ്: $error';
  }

  @override
  String get noHelmetOnRider => 'സവാരിക്ക് ഹെൽമെറ്റ് ഇല്ല';

  @override
  String get vehicleNearSignal =>
      'വാഹനം സിഗ്‌നലിന് സമീപത്തുണ്ട് — സാധ്യതയുള്ള സിഗ്‌നൽ ലംഗനം';

  @override
  String vehicleOverloading(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    return 'വാഹനത്തിൽ അമിതം ഭാരം ($countString പേർ)';
  }

  @override
  String detectedObjects(String objects) {
    return 'കണ്ടെത്തി: $objects. നിശ്ചിത ലംഗനം ഇല്ല.';
  }

  @override
  String violationPrefix(String violations) {
    return '⚠️ ലംഗനം: $violations';
  }

  @override
  String get noContentsFound => 'ഉള്ളടക്കം കണ്ടെത്തിയില്ല.';

  @override
  String get noPointsFound => 'പോയിന്റുകൾ കണ്ടെത്തിയില്ല.';

  @override
  String get noViolationsFound => 'ലംഗന ശിക്ഷണങ്ങൾ കണ്ടെത്തിയില്ല.';

  @override
  String get registration => 'റജിസ്ട്രേഷൻ';

  @override
  String get userRegistered => 'ഉപയോക്താവ് റജിസ്റ്റർ ആയി';

  @override
  String get registrationFailed => 'റജിസ്ട്രേഷൻ പരാജയപ്പെട്ടു';

  @override
  String get tryOnceMore => 'മെiedenis അയക്ക് കൂട്ടുക';

  @override
  String get signUp => 'റജിസ്റ്റർ ചെയ്യുക';

  @override
  String get firstName => 'മുൻപേര്';

  @override
  String get lastName => 'പേര്';

  @override
  String get email => 'ഈമെയിൽ';

  @override
  String get phoneNumber => 'ഫോൺ നമ്പർ';

  @override
  String get address => 'വിലാസം';

  @override
  String get pinCode => 'പിൻകോഡ്';

  @override
  String get malayalam => 'മലയാളം';

  @override
  String get hindi => ' हिंदी';
}
