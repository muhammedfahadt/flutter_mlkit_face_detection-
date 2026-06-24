import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ml.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('ml'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Traffic Patrol V2.1'**
  String get appTitle;

  /// Home page title
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Home action label: Camera
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// Home action label: Upload
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get upload;

  /// Home action label: Login
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Settings button label
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Theme menu label
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Language menu label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Theme option: Light
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// Theme option: Dark
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// Theme option: System
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// Language option: English
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Title shown when login fails
  ///
  /// In en, this message translates to:
  /// **'Login Failed'**
  String get loginFailed;

  /// Generic OK button label
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Validation message for empty username/password
  ///
  /// In en, this message translates to:
  /// **'Username and password are required.'**
  String get usernamePasswordRequired;

  /// Validation message for wrong credentials
  ///
  /// In en, this message translates to:
  /// **'Invalid username or password.'**
  String get invalidCredentials;

  /// Login form username field
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// Login form password field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Link to signup page
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign Up'**
  String get dontHaveAccountSignUp;

  /// App bar title in home page
  ///
  /// In en, this message translates to:
  /// **'TRAFFIC PATROL  v2.1'**
  String get appBarTitle;

  /// Hero section subtitle
  ///
  /// In en, this message translates to:
  /// **'AUTOMATED VIOLATION DETECTION'**
  String get automatedViolationDetection;

  /// Hero section main title
  ///
  /// In en, this message translates to:
  /// **'AI-Powered Traffic\nEnforcement System'**
  String get aiPoweredTrafficSystem;

  /// Hero section tagline
  ///
  /// In en, this message translates to:
  /// **'Capture · Detect · Report · Protect'**
  String get captureDetectReportProtect;

  /// Status bar text indicating system is online
  ///
  /// In en, this message translates to:
  /// **'SYSTEM ONLINE'**
  String get systemOnline;

  /// ML Kit status indicator
  ///
  /// In en, this message translates to:
  /// **'ML KIT  ●  ACTIVE'**
  String get mlKitActive;

  /// Grid section header text
  ///
  /// In en, this message translates to:
  /// **'SELECT OPERATION'**
  String get selectOperation;

  /// Primary action card label
  ///
  /// In en, this message translates to:
  /// **'CAPTURE VIOLATION'**
  String get captureViolation;

  /// Primary action card sublabel
  ///
  /// In en, this message translates to:
  /// **'Open camera · detect · report'**
  String get openCameraDetectReport;

  /// Violations page and menu item label
  ///
  /// In en, this message translates to:
  /// **'Violations'**
  String get violations;

  /// Tag for violations grid card
  ///
  /// In en, this message translates to:
  /// **'RECORDS'**
  String get records;

  /// Points page label
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get points;

  /// Tag for points grid card
  ///
  /// In en, this message translates to:
  /// **'REWARDS'**
  String get rewards;

  /// Contents page label
  ///
  /// In en, this message translates to:
  /// **'Contents'**
  String get contents;

  /// Tag for contents grid card
  ///
  /// In en, this message translates to:
  /// **'INFO'**
  String get info;

  /// Tag for login grid card
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT'**
  String get account;

  /// Footer copyright text
  ///
  /// In en, this message translates to:
  /// **'TRAFFIC PATROL ENFORCEMENT SYSTEM  ©2025'**
  String get footerText;

  /// Camera page title
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get cameraPageTitle;

  /// Dialog title for violation description
  ///
  /// In en, this message translates to:
  /// **'Describe the violation'**
  String get describeViolation;

  /// Hint text for violation description field
  ///
  /// In en, this message translates to:
  /// **'Edit or confirm the AI description...'**
  String get editOrConfirmDescription;

  /// Cancel button label
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Success message after upload
  ///
  /// In en, this message translates to:
  /// **'Uploaded successfully!'**
  String get uploadSuccess;

  /// No description provided for @uploadError.
  ///
  /// In en, this message translates to:
  /// **'Upload error: {error}'**
  String uploadError(String error);

  /// Violation message: no helmet detected
  ///
  /// In en, this message translates to:
  /// **'No helmet on rider'**
  String get noHelmetOnRider;

  /// Violation message: vehicle near traffic light
  ///
  /// In en, this message translates to:
  /// **'Vehicle near signal — possible signal jump'**
  String get vehicleNearSignal;

  /// No description provided for @vehicleOverloading.
  ///
  /// In en, this message translates to:
  /// **'Vehicle overloading ({count} persons)'**
  String vehicleOverloading(int count);

  /// No description provided for @detectedObjects.
  ///
  /// In en, this message translates to:
  /// **'Detected: {objects}. No clear violation.'**
  String detectedObjects(String objects);

  /// No description provided for @violationPrefix.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Violation: {violations}'**
  String violationPrefix(String violations);

  /// Empty state message for contents page
  ///
  /// In en, this message translates to:
  /// **'No contents found.'**
  String get noContentsFound;

  /// Empty state message for points page
  ///
  /// In en, this message translates to:
  /// **'No points found.'**
  String get noPointsFound;

  /// Empty state message for violations page
  ///
  /// In en, this message translates to:
  /// **'No violations found.'**
  String get noViolationsFound;

  /// Registration dialog title
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get registration;

  /// Success message after registration
  ///
  /// In en, this message translates to:
  /// **'User registered'**
  String get userRegistered;

  /// Error message for failed registration
  ///
  /// In en, this message translates to:
  /// **'Registration Failed'**
  String get registrationFailed;

  /// Error message asking user to retry
  ///
  /// In en, this message translates to:
  /// **'Try once more'**
  String get tryOnceMore;

  /// Sign up page title and button label
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// First name field label in signup form
  ///
  /// In en, this message translates to:
  /// **'Firstname'**
  String get firstName;

  /// Last name field label in signup form
  ///
  /// In en, this message translates to:
  /// **'Lastname'**
  String get lastName;

  /// Email field label in signup form
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Phone number field label in signup form
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// Address field label in signup form
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// Pin code field label in signup form
  ///
  /// In en, this message translates to:
  /// **'Pin Code'**
  String get pinCode;

  /// hindi language display name
  ///
  /// In en, this message translates to:
  /// **'മലയാളം'**
  String get malayalam;

  /// No description provided for @hindi.
  ///
  /// In en, this message translates to:
  /// **' हिंदी'**
  String get hindi;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi', 'ml'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'ml':
      return AppLocalizationsMl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
