// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Traffic Patrol V2.1';

  @override
  String get home => 'Home';

  @override
  String get camera => 'Camera';

  @override
  String get upload => 'Upload';

  @override
  String get login => 'Login';

  @override
  String get settings => 'Settings';

  @override
  String get theme => 'Theme';

  @override
  String get language => 'Language';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get system => 'System';

  @override
  String get english => 'English';

  @override
  String get loginFailed => 'Login Failed';

  @override
  String get ok => 'OK';

  @override
  String get usernamePasswordRequired => 'Username and password are required.';

  @override
  String get invalidCredentials => 'Invalid username or password.';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get dontHaveAccountSignUp => 'Don\'t have an account? Sign Up';

  @override
  String get appBarTitle => 'TRAFFIC PATROL  v2.1';

  @override
  String get automatedViolationDetection => 'AUTOMATED VIOLATION DETECTION';

  @override
  String get aiPoweredTrafficSystem => 'AI-Powered Traffic\nEnforcement System';

  @override
  String get captureDetectReportProtect =>
      'Capture · Detect · Report · Protect';

  @override
  String get systemOnline => 'SYSTEM ONLINE';

  @override
  String get mlKitActive => 'ML KIT  ●  ACTIVE';

  @override
  String get selectOperation => 'SELECT OPERATION';

  @override
  String get captureViolation => 'CAPTURE VIOLATION';

  @override
  String get openCameraDetectReport => 'Open camera · detect · report';

  @override
  String get violations => 'Violations';

  @override
  String get records => 'RECORDS';

  @override
  String get points => 'Points';

  @override
  String get rewards => 'REWARDS';

  @override
  String get contents => 'Contents';

  @override
  String get info => 'INFO';

  @override
  String get account => 'ACCOUNT';

  @override
  String get footerText => 'TRAFFIC PATROL ENFORCEMENT SYSTEM  ©2025';

  @override
  String get cameraPageTitle => 'Camera';

  @override
  String get describeViolation => 'Describe the violation';

  @override
  String get editOrConfirmDescription =>
      'Edit or confirm the AI description...';

  @override
  String get cancel => 'Cancel';

  @override
  String get uploadSuccess => 'Uploaded successfully!';

  @override
  String uploadError(String error) {
    return 'Upload error: $error';
  }

  @override
  String get noHelmetOnRider => 'No helmet on rider';

  @override
  String get vehicleNearSignal => 'Vehicle near signal — possible signal jump';

  @override
  String vehicleOverloading(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    return 'Vehicle overloading ($countString persons)';
  }

  @override
  String detectedObjects(String objects) {
    return 'Detected: $objects. No clear violation.';
  }

  @override
  String violationPrefix(String violations) {
    return '⚠️ Violation: $violations';
  }

  @override
  String get noContentsFound => 'No contents found.';

  @override
  String get noPointsFound => 'No points found.';

  @override
  String get noViolationsFound => 'No violations found.';

  @override
  String get registration => 'Registration';

  @override
  String get userRegistered => 'User registered';

  @override
  String get registrationFailed => 'Registration Failed';

  @override
  String get tryOnceMore => 'Try once more';

  @override
  String get signUp => 'Sign Up';

  @override
  String get firstName => 'Firstname';

  @override
  String get lastName => 'Lastname';

  @override
  String get email => 'Email';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get address => 'Address';

  @override
  String get pinCode => 'Pin Code';

  @override
  String get malayalam => 'മലയാളം';

  @override
  String get hindi => ' हिंदी';
}
