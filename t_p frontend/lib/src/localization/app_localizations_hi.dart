// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'ट्रैफिक पेट्रोल';

  @override
  String get home => 'होम';

  @override
  String get camera => 'कैमरा';

  @override
  String get upload => 'अपलोड';

  @override
  String get login => 'लॉगिन';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get theme => 'थीम';

  @override
  String get language => 'भाषा';

  @override
  String get light => 'लाइट';

  @override
  String get dark => 'डार्क';

  @override
  String get system => 'सिस्टम';

  @override
  String get english => 'अंग्रेज़ी';

  @override
  String get loginFailed => 'लॉगिन विफल';

  @override
  String get ok => 'ठीक है';

  @override
  String get usernamePasswordRequired => 'यूज़रनेम और पासवर्ड आवश्यक हैं।';

  @override
  String get invalidCredentials => 'गलत यूज़रनेम या पासवर्ड।';

  @override
  String get username => 'यूज़रनेम';

  @override
  String get password => 'पासवर्ड';

  @override
  String get dontHaveAccountSignUp => 'खाता नहीं है? साइन अप करें';

  @override
  String get appBarTitle => 'ट्रैफिक पेट्रोल v2.1';

  @override
  String get automatedViolationDetection => 'स्वचालित उल्लंघन पता लगाना';

  @override
  String get aiPoweredTrafficSystem => 'AI सक्षम ट्रैफिक\nप्रवर्तन प्रणाली';

  @override
  String get captureDetectReportProtect =>
      'कैप्चर · पता लगाएं · रिपोर्ट · सुरक्षा';

  @override
  String get systemOnline => 'सिस्टम ऑनलाइन';

  @override
  String get mlKitActive => 'ML किट ● सक्रिय';

  @override
  String get selectOperation => 'ऑपरेशन चुने';

  @override
  String get captureViolation => 'उल्लंघन कैप्चर करें';

  @override
  String get openCameraDetectReport => 'कैमरा खोलें · पता लगाएं · रिपोर्ट';

  @override
  String get violations => 'उल्लंघन';

  @override
  String get records => 'रिकॉर्ड';

  @override
  String get points => 'अंक';

  @override
  String get rewards => 'पुरस्कार';

  @override
  String get contents => 'सामग्री';

  @override
  String get info => 'जानकारी';

  @override
  String get account => 'खाता';

  @override
  String get footerText => 'ट्रैफिक पेट्रोल प्रवर्तन प्रणाली ©2025';

  @override
  String get cameraPageTitle => 'कैमरा';

  @override
  String get describeViolation => 'उल्लंघन का वर्णन करें';

  @override
  String get editOrConfirmDescription =>
      'AI वर्णन संपादित करें या पुष्टि करें...';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get uploadSuccess => 'सफलतापूर्वक अपलोड हो गया!';

  @override
  String uploadError(String error) {
    return 'अपलोड त्रुटि: $error';
  }

  @override
  String get noHelmetOnRider => 'सवार पर हेलमेट नहीं';

  @override
  String get vehicleNearSignal =>
      'वाहन सिग्नल के पास - संभव सिग्नल तोड़ने का प्रयास';

  @override
  String vehicleOverloading(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    return 'वाहन पर अधिक भार ($countString व्यक्ति)';
  }

  @override
  String detectedObjects(String objects) {
    return 'पाया गया: $objects. कोई स्पष्ट उल्लंघन नहीं।';
  }

  @override
  String violationPrefix(String violations) {
    return '⚠️ उल्लंघन: $violations';
  }

  @override
  String get noContentsFound => 'कोई सामग्री नहीं मिली।';

  @override
  String get noPointsFound => 'कोई अंक नहीं मिले।';

  @override
  String get noViolationsFound => 'कोई उल्लंघन नहीं मिले।';

  @override
  String get registration => 'पंजीकरण';

  @override
  String get userRegistered => 'उपयोक्ता पंजीकृत';

  @override
  String get registrationFailed => 'पंजीकरण विफल';

  @override
  String get tryOnceMore => 'एक बार फिर कोशिश करें';

  @override
  String get signUp => 'साइन अप';

  @override
  String get firstName => 'प्रथम नाम';

  @override
  String get lastName => 'अंतिम नाम';

  @override
  String get email => 'ईमेल';

  @override
  String get phoneNumber => 'फोन नंबर';

  @override
  String get address => 'पता';

  @override
  String get pinCode => 'पिन कोड';

  @override
  String get malayalam => 'मलयालम';

  @override
  String get hindi => 'हिंदी';
}
