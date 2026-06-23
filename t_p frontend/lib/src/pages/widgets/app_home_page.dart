import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:traffic_patrol/src/localization/app_localizations.dart';
import 'package:traffic_patrol/src/pages/widgets/home_appbar_actions.dart';
import 'package:traffic_patrol/src/pages/widgets/login_form.dart';
import 'package:traffic_patrol/src/pages/widgets/content_read_page.dart';
import 'package:traffic_patrol/src/pages/widgets/upload_widget.dart';
import 'package:traffic_patrol/src/pages/widgets/violation_read_page.dart';
import 'package:traffic_patrol/src/pages/widgets/points_read_page.dart';

// ─── Design tokens ────────────────────────────────────────────────────────────
class _C {
  static const bg = Color(0xFF0A0E1A); // deep navy black
  static const surface = Color(0xFF111827); // card surface
  static const border = Color(0xFF1E2D45); // subtle border
  static const amber = Color(0xFFF59E0B); // alert amber — primary accent
  static const amberDim = Color(0xFF78450A); // dimmed amber for borders
  static const red = Color(0xFFEF4444); // violation red
  static const cyan = Color(0xFF06B6D4); // data cyan
  static const textPri = Color(0xFFE2E8F0);
  static const textSec = Color(0xFF64748B);
  static const textMono = Color(0xFF94A3B8);
}
// ─────────────────────────────────────────────────────────────────────────────

class AppHomePage extends StatefulWidget {
  final Function(Locale) onLocaleChanged;
  final Function(ThemeMode) onThemeChanged;
  const AppHomePage({super.key, required this.onLocaleChanged, required this.onThemeChanged});

  @override
  State<AppHomePage> createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage>
    with SingleTickerProviderStateMixin {
  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('en', 'ml');

  // Subtle pulse for the status badge
  late final AnimationController _pulse;
  late final Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(
      begin: 0.4,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _pulse, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

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
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      
      child: Scaffold(
        appBar: AppBar(
          title: Text(loc?.appTitle ?? 'TRAFFIC PATROL  v2.1'),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: HomeAppBarActions(
                onThemeChanged: (mode) {
                  setState(() => _themeMode = mode);
                  widget.onThemeChanged(mode);
                },
                onLocaleChanged: (locale) {
                  setState(() => _locale = locale);
                  widget.onLocaleChanged(locale);
                },
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(height: 1, color: _C.border),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHero(context, loc),
              _buildStatusBar(),
              const SizedBox(height: 8),
              _buildGridSection(context, loc),
              const SizedBox(height: 32),
              _buildFooter(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ── Hero / logo zone ────────────────────────────────────────────────────────
  Widget _buildHero(BuildContext context, AppLocalizations? loc) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: _C.surface,
        border: Border(bottom: BorderSide(color: _C.border)),
      ),
      child: Stack(
        children: [
          // Scanline grid overlay — signature texture
          Positioned.fill(child: CustomPaint(painter: _GridPainter())),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
            child: Column(
              children: [
                // ── LOGO / ANIMATION PLACEHOLDER ──────────────────────────
                // Drop your animated logo or Lottie widget here.
                // Recommended size: 120×120. Remove the placeholder container.
                LottieBuilder.asset(
                  './assets/Loader.json',
                  width: 120,
                  height: 120,
                ),
                const SizedBox(height: 20),
                Text(
                  loc?.aiPoweredTrafficSystem ??
                      'AUTOMATED VIOLATION DETECTION',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    letterSpacing: 3.5,
                    color: _C.amber,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  loc?.aiPoweredTrafficSystem ??
                      "AI-Powered Traffic\nEnforcement System",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: _C.textPri,
                    height: 1.25,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  loc?.captureDetectReportProtect ??
                      'Capture · Detect · Report · Protect',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    letterSpacing: 1.8,
                    color: _C.textSec,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Live status bar ─────────────────────────────────────────────────────────
  Widget _buildStatusBar() {
    var loc = AppLocalizations.of(context);
    return Container(
      color: _C.bg,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: _pulseAnim,
            builder: (_, __) => Opacity(
              opacity: _pulseAnim.value,
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: _C.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            loc?.systemOnline ?? 'SYSTEM ONLINE',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: _C.red,
              letterSpacing: 2,
            ),
          ),
          const Spacer(),
          const Text(
            'ML KIT  ●  ACTIVE',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: _C.cyan,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ── Action grid ─────────────────────────────────────────────────────────────
  Widget _buildGridSection(BuildContext context, AppLocalizations? loc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 14),
            child: Text(
             loc?.selectOperation ?? 'SELECT OPERATION',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                letterSpacing: 3,
                color: _C.textSec,
              ),
            ),
          ),

          // Primary action — full width, amber highlight
          _PrimaryCard(
            icon: Icons.videocam_outlined,
            label: loc?.captureViolation ?? 'CAPTURE VIOLATION',
            sublabel: loc?.openCameraDetectReport ?? 'Open camera · detect · report',
            accent: _C.amber,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    CameraApp(
                      onLocaleChanged: widget.onLocaleChanged,
                      onThemeChanged: widget.onThemeChanged,
                    ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Secondary 2×2 grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.55,
            children: [
              _GridCard(
                icon: Icons.gavel_outlined,
                label: loc?.violations ?? 'Violations',
                tag: 'RECORDS',
                accent: _C.red,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ViolationReadPage()),
                ),
              ),
              _GridCard(
                icon: Icons.stars_outlined,
                label: loc?.points ??'Points',
                tag: 'REWARDS',
                accent: _C.amber,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PointsReadPage()),
                ),
              ),
              _GridCard(
                icon: Icons.article_outlined,
                label: loc?.contents ?? 'Contents',
                tag: 'INFO',
                accent: _C.cyan,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ContentReadPage()),
                ),
              ),
         
            ],
          ),
        ]
      ),
    );
  }

  // ── Footer ──────────────────────────────────────────────────────────────────
  Widget _buildFooter() {
    var loc =AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(width: 24, height: 1, color: _C.border),
          const SizedBox(width: 10),
           Text( loc?.footerText ??
            'TRAFFIC PATROL ENFORCEMENT SYSTEM  ©2025',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9,
              color: _C.textSec,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Container(height: 1, color: _C.border)),
        ],
      ),
    );
  }
}

// ─── Primary wide action card ─────────────────────────────────────────────────
class _PrimaryCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final String sublabel;
  final Color accent;
  final VoidCallback onTap;

  const _PrimaryCard({
    required this.icon,
    required this.label,
    required this.sublabel,
    required this.accent,
    required this.onTap,
  });

  @override
  State<_PrimaryCard> createState() => _PrimaryCardState();
}

class _PrimaryCardState extends State<_PrimaryCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          color: _pressed ? _C.surface.withValues(alpha: 0.6) : _C.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: widget.accent, width: 1.2),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: widget.accent.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(widget.icon, color: widget.accent, size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      letterSpacing: 2,
                      color: widget.accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    widget.sublabel,
                    style: const TextStyle(fontSize: 12, color: _C.textSec),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: widget.accent.withOpacity(0.6)),
          ],
        ),
      ),
    );
  }
}

// ─── Secondary grid card ──────────────────────────────────────────────────────
class _GridCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final String tag;
  final Color accent;
  final VoidCallback onTap;

  const _GridCard({
    required this.icon,
    required this.label,
    required this.tag,
    required this.accent,
    required this.onTap,
  });

  @override
  State<_GridCard> createState() => _GridCardState();
}

class _GridCardState extends State<_GridCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          color: _pressed ? _C.surface.withOpacity(0.5) : _C.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _C.border, width: 1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(widget.icon, color: widget.accent, size: 22),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: widget.accent.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.tag,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 8,
                      letterSpacing: 1.5,
                      color: widget.accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              widget.label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: _C.textPri,
              ),
            ),
          ],
        ),
      ),
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
