import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:traffic_patrol/src/pages/widgets/config.dart';
import 'package:traffic_patrol/src/pages/widgets/upload_widget.dart';
import 'package:traffic_patrol/src/localization/app_localizations.dart';
import 'package:openapi/openapi.dart';

import 'app_home_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ─── Design tokens (same across all pages) ────────────────────────────────────
class _C {
  static const bg       = Color(0xFF0A0E1A);
  static const surface  = Color(0xFF111827);
  static const border   = Color(0xFF1E2D45);
  static const amber    = Color(0xFFF59E0B);
  static const amberDim = Color(0xFF78450A);
  static const red      = Color(0xFFEF4444);
  static const cyan     = Color(0xFF06B6D4);
  static const green    = Color(0xFF10B981);
  static const textPri  = Color(0xFFE2E8F0);
  static const textSec  = Color(0xFF64748B);
  static const textMono = Color(0xFF94A3B8);
}
// ─────────────────────────────────────────────────────────────────────────────

class ManagedUser {
  final String id;
  final String login;
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  ManagedUser(
    this.id,
    this.login,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
  );

  Map<String, dynamic> toJson() => {'id': id};
}

class AppUser {
  final String phoneNumber;
  final String address;
  final String pinCode;
  final ManagedUser user;

  AppUser({
    required this.phoneNumber,
    required this.address,
    required this.pinCode,
    required this.user,
  });
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  // Controllers
  final _loginController       = TextEditingController();
  final _firstNameController   = TextEditingController();
  final _lastNameController    = TextEditingController();
  final _emailController       = TextEditingController();
  final _passwordController    = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController     = TextEditingController();
  final _pinCodeController     = TextEditingController();
  final Openapi _openapi       = Openapi();

  bool _obscurePassword = true;
  bool _isLoading       = false;

  // Pulse for the status dot
  late final AnimationController _pulse;
  late final Animation<double>   _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _pulse, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulse.dispose();
    _loginController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _pinCodeController.dispose();
    super.dispose();
  }

  // ── Sign up logic (unchanged from original) ────────────────────────────────
  Future<void> _signUp(BuildContext context) async {
    setState(() => _isLoading = true);
    try {
      ManagedUserVMBuilder managedUserVMBuilder = ManagedUserVMBuilder()
        ..login     = _loginController.text
        ..firstName = _firstNameController.text
        ..lastName  = _lastNameController.text
        ..email     = _emailController.text
        ..password  = _passwordController.text
        ..activated = true;

      ManagedUserVM managedUserVM = managedUserVMBuilder.build();
      final userResponse = await _openapi
          .getAccountResourceApi()
          .registerAccount(managedUserVM: managedUserVM);

      if (userResponse.statusCode == 201) {
        LoginVMBuilder loginVMBuilder = LoginVMBuilder()
          ..username   = _loginController.text
          ..password   = _passwordController.text
          ..rememberMe = true;

        LoginVM loginVM = loginVMBuilder.build();
        final jwtResponse = await _openapi
            .getAuthenticateControllerApi()
            .authorize(loginVM: loginVM);

        if (jwtResponse.statusCode == 200 || jwtResponse.statusCode == 201) {
          Configuration.secureStorage.write(
            key: 'jwt',
            value: jwtResponse.data?.idToken,
          );
          String? jwt = jwtResponse.data?.idToken;

          final currentUser = await _openapi.getAccountResourceApi().getAccount(
            headers: {'Authorization': 'Bearer $jwt'},
          );

          UserDTOBuilder userDTOBuilder = UserDTOBuilder()
            ..id    = currentUser.data?.id
            ..login = currentUser.data?.login;

          AppUserDTOBuilder appUserDTOBuilder = AppUserDTOBuilder()
            ..phoneNumber = int.tryParse(_phoneNumberController.text)
            ..address     = _addressController.text
            ..pinCode     = int.tryParse(_pinCodeController.text)
            ..user        = userDTOBuilder;

          AppUserDTO appUserDTO = appUserDTOBuilder.build();

          final appUserResponse = await _openapi
              .getAppUserResourceApi()
              .createAppUser(
                appUserDTO: appUserDTO,
                headers: {'Authorization': 'Bearer $jwt'},
              );

          if (appUserResponse.statusCode == 201) {
            Configuration.secureStorage.write(
              key: 'appuserId',
              value: appUserResponse.data?.id.toString(),
            );
            Configuration.secureStorage.write(
              key: 'appUsernumber',
              value: appUserResponse.data?.phoneNumber.toString(),
            );
            setState(() => _isLoading = false);
            _showStatusDialog(
              success: true,
              message: 'Account created successfully.\nWelcome to Traffic Patrol.',
              onConfirm: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => AppHomePage(
                    onLocaleChanged: (_) {},
                    onThemeChanged: (ThemeMode p1) {},
                  ),
                ),
              ),
            );
          } else {
            setState(() => _isLoading = false);
            _showStatusDialog(
              success: false,
              message: 'AppUser registration failed.\nPlease try again.',
            );
          }
        }
      } else {
        setState(() => _isLoading = false);
        _showStatusDialog(
          success: false,
          message: 'Registration failed.\nCheck your details and try again.',
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showStatusDialog(
        success: false,
        message: 'An error occurred:\n${e.toString()}',
      );
    }
  }

  // ── Themed dialog ──────────────────────────────────────────────────────────
  void _showStatusDialog({
    required bool success,
    required String message,
    VoidCallback? onConfirm,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: _C.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: success ? _C.green : _C.red,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                success ? Icons.check_circle_outline : Icons.error_outline,
                color: success ? _C.green : _C.red,
                size: 40,
              ),
              const SizedBox(height: 12),
              Text(
                success ? 'REGISTRATION COMPLETE' : 'REGISTRATION FAILED',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  letterSpacing: 2,
                  color: success ? _C.green : _C.red,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: _C.textSec,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  onConfirm?.call();
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: success ? _C.green : _C.red),
                    borderRadius: BorderRadius.circular(6),
                    color: (success ? _C.green : _C.red)
                        .withOpacity(0.08),
                  ),
                  child: Text(
                    success ? 'CONTINUE' : 'TRY AGAIN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      letterSpacing: 2,
                      color: success ? _C.green : _C.red,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: _C.bg,
        appBarTheme: const AppBarTheme(
          backgroundColor: _C.bg,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            letterSpacing: 2.5,
            color: _C.textMono,
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('REGISTER  //  NEW ACCOUNT'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios,
                size: 16, color: _C.textSec),
            onPressed: () => Navigator.pop(context),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(height: 1, color: _C.border),
          ),
        ),
        body: Column(
          children: [
            _buildHeader(),
            _buildStatusBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _SectionLabel(label: 'ACCOUNT CREDENTIALS'),
                    const SizedBox(height: 10),
                    _DarkField(
                      controller: _loginController,
                      label: 'Username',
                      icon: Icons.person_outline,
                      hint: 'Enter username',
                    ),
                    const SizedBox(height: 10),
                    _DarkField(
                      controller: _emailController,
                      label: 'Email',
                      icon: Icons.email_outlined,
                      hint: 'Enter email address',
                      keyboard: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10),
                    // Password with toggle
                    _DarkField(
                      controller: _passwordController,
                      label: 'Password',
                      icon: Icons.lock_outline,
                      hint: 'Enter password',
                      obscure: _obscurePassword,
                      suffix: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 18,
                          color: _C.textSec,
                        ),
                        onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword),
                      ),
                    ),

                    const SizedBox(height: 20),
                    _SectionLabel(label: 'PERSONAL INFORMATION'),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _DarkField(
                            controller: _firstNameController,
                            label: 'First Name',
                            icon: Icons.badge_outlined,
                            hint: 'First',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _DarkField(
                            controller: _lastNameController,
                            label: 'Last Name',
                            icon: Icons.badge_outlined,
                            hint: 'Last',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _DarkField(
                      controller: _phoneNumberController,
                      label: 'Phone Number',
                      icon: Icons.phone_outlined,
                      hint: 'Enter phone number',
                      keyboard: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),

                    const SizedBox(height: 20),
                    _SectionLabel(label: 'LOCATION'),
                    const SizedBox(height: 10),
                    _DarkField(
                      controller: _addressController,
                      label: 'Address',
                      icon: Icons.location_on_outlined,
                      hint: 'Enter full address',
                      maxLines: 2,
                    ),
                    const SizedBox(height: 10),
                    _DarkField(
                      controller: _pinCodeController,
                      label: 'Pin Code',
                      icon: Icons.pin_outlined,
                      hint: 'Enter pin code',
                      keyboard: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),

                    const SizedBox(height: 28),
                    // Submit button
                    GestureDetector(
                      onTap: _isLoading ? null : () => _signUp(context),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        width: double.infinity,
                        padding:
                            const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: _isLoading
                              ? _C.amberDim.withOpacity(0.3)
                              : _C.amber.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: _isLoading ? _C.amberDim : _C.amber,
                            width: 1.2,
                          ),
                        ),
                        child: _isLoading
                            ? const Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: _C.amber,
                                    strokeWidth: 1.5,
                                  ),
                                ),
                              )
                            : const Text(
                                'CREATE ACCOUNT',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 13,
                                  letterSpacing: 2.5,
                                  color: _C.amber,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    // Login redirect
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        'Already registered?  SIGN IN',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                          color: _C.textSec,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Header ─────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: _C.surface,
        border: Border(bottom: BorderSide(color: _C.border)),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _GridPainter())),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 20, horizontal: 20),
            child: Row(
              children: [
                // ── LOTTIE / ICON PLACEHOLDER ─────────────────────────────
                // Replace this Container with your Lottie widget, e.g.:
                // LottieBuilder.asset('assets/lottie/register.json',
                //   width: 60, height: 60)
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: _C.amberDim, width: 1.5),
                    color: _C.bg,
                  ),
                  child: const Center(
                    child: Icon(Icons.person_add_outlined,
                        color: _C.amber, size: 26),
                  ),
                ),
                // ── END LOTTIE PLACEHOLDER ────────────────────────────────
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'NEW OFFICER REGISTRATION',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 9,
                        letterSpacing: 3,
                        color: _C.amber,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Create your account',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: _C.textPri,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Join the Traffic Patrol network',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        color: _C.textSec,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Status bar ─────────────────────────────────────────────────────────────
  Widget _buildStatusBar() {
    return Container(
      color: _C.bg,
      padding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: _pulseAnim,
            builder: (_, __) => Opacity(
              opacity: _pulseAnim.value,
              child: Container(
                width: 7, height: 7,
                decoration: const BoxDecoration(
                    color: _C.amber, shape: BoxShape.circle),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'SECURE REGISTRATION',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: _C.amber,
              letterSpacing: 2,
            ),
          ),
          const Spacer(),
          const Text(
            'ENCRYPTED',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9,
              color: _C.textSec,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.lock_outline, size: 11, color: _C.textSec),
        ],
      ),
    );
  }
}

// ─── Section label ────────────────────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 3, height: 14,
            decoration: BoxDecoration(
              color: _C.amber,
              borderRadius: BorderRadius.circular(2),
            )),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 9,
            letterSpacing: 3,
            color: _C.textSec,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: Container(height: 1, color: _C.border)),
      ],
    );
  }
}

// ─── Dark text field ──────────────────────────────────────────────────────────
class _DarkField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final bool obscure;
  final TextInputType keyboard;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;
  final int maxLines;

  const _DarkField({
    required this.controller,
    required this.label,
    required this.icon,
    required this.hint,
    this.obscure = false,
    this.keyboard = TextInputType.text,
    this.inputFormatters,
    this.suffix,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 9,
            letterSpacing: 2,
            color: _C.textSec,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboard,
          inputFormatters: inputFormatters,
          maxLines: obscure ? 1 : maxLines,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            color: _C.textPri,
            letterSpacing: 0.5,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: _C.textSec.withOpacity(0.5),
            ),
            prefixIcon:
                Icon(icon, size: 18, color: _C.textSec),
            suffixIcon: suffix,
            filled: true,
            fillColor: _C.surface,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 14, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: _C.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: _C.amber, width: 1.2),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Scanline grid painter ────────────────────────────────────────────────────
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1E2D45).withOpacity(0.35)
      ..strokeWidth = 0.5;
    const step = 28.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter old) => false;
}