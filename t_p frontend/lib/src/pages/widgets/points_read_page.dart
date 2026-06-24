import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:openapi/openapi.dart';
import 'package:built_collection/built_collection.dart';


import 'package:flutter/material.dart';
import 'dart:typed_data';


// ─── Design tokens (same as AppHomePage) ─────────────────────────────────────
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

class PointsReadPage extends StatefulWidget {
  const PointsReadPage({super.key});

  @override
  State<PointsReadPage> createState() => _PointsReadPageState();
}

class _PointsReadPageState extends State<PointsReadPage>
    with SingleTickerProviderStateMixin {
  final Openapi _openapi = Openapi();

  bool _loading = true;
  String? _error;
  BuiltList<PointsDTO>? _items;

  // Pulse animation for the live indicator dot
  late final AnimationController _pulse;
  late final Animation<double> _pulseAnim;

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
    _load();
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final response = await _openapi.getPointsResourceApi().getAllPoints(
        headers: {'Authorization': 'Bearer ${Openapi.bearerToken}'},
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to load points (HTTP ${response.statusCode})');
      }
      setState(() {
        _items = response.data;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  // ── Total points helper ────────────────────────────────────────────────────
  int get _totalPoints =>
      _items?.fold<int>(0, (sum, item) => sum + (item.pointsEarned ?? 0)) ?? 0;

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
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('POINTS  //  REWARDS'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 16, color: _C.textSec),
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
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  // ── Header with Lottie placeholder + total ─────────────────────────────────
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
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Row(
              children: [
                // ── LOTTIE / ICON PLACEHOLDER ────────────────────────────────
                // Replace this Container with your Lottie widget, e.g.:
                 LottieBuilder.asset('assets/Confetti Day.json',
                   width: 72, height: 72),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'REWARD POINTS',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          letterSpacing: 3,
                          color: _C.amber,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      _loading
                          ? const SizedBox(
                              width: 80,
                              height: 28,
                              child: LinearProgressIndicator(
                                color: _C.amber,
                                backgroundColor: _C.border,
                              ),
                            )
                          : Text(
                              '$_totalPoints pts',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: _C.textPri,
                                letterSpacing: -0.5,
                              ),
                            ),
                      const SizedBox(height: 4),
                      Text(
                        '${_items?.length ?? 0} entries recorded',
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                          color: _C.textSec,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: _pulseAnim,
            builder: (_, __) => Opacity(
              opacity: _pulseAnim.value,
              child: Container(
                width: 7, height: 7,
                decoration: const BoxDecoration(
                    color: _C.green, shape: BoxShape.circle),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'LIVE DATA',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: _C.green,
              letterSpacing: 2,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: _load,
            child: const Row(
              children: [
                Icon(Icons.refresh, size: 13, color: _C.textSec),
                SizedBox(width: 4),
                Text(
                  'REFRESH',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: _C.textSec,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Body: loading / error / list ───────────────────────────────────────────
  Widget _buildBody() {
    if (_loading) return _buildLoading();
    if (_error != null) return _buildError();
    if (_items == null || _items!.isEmpty) return _buildEmpty();
    return _buildList();
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(
              color: _C.amber,
              strokeWidth: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'FETCHING RECORDS...',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: _C.textSec,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _C.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _C.red.withOpacity(0.4)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: _C.red, size: 36),
              const SizedBox(height: 12),
              const Text(
                'CONNECTION ERROR',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  letterSpacing: 2,
                  color: _C.red,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: _C.textSec),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _load,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: _C.amber),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'RETRY',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      letterSpacing: 2,
                      color: _C.amber,
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

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.stars_outlined,
              size: 48, color: _C.textSec.withOpacity(0.4)),
          const SizedBox(height: 16),
          const Text(
            'NO POINTS RECORDED',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: _C.textSec,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Report violations to earn reward points',
            style: TextStyle(fontSize: 13, color: _C.textSec),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    return RefreshIndicator(
      color: _C.amber,
      backgroundColor: _C.surface,
      onRefresh: _load,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        itemCount: _items!.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final item = _items![index];
          final pts = item.pointsEarned ?? 0;
          final date = item.uploadDateTime?.toIso8601String() ?? '--';

          return _PointsCard(
            id: item.id?.toString() ?? '-',
            points: pts,
            date: date,
            index: index,
          );
        },
      ),
    );
  }
}

// ─── Points card ──────────────────────────────────────────────────────────────
class _PointsCard extends StatelessWidget {
  final String id;
  final int points;
  final String date;
  final int index;

  const _PointsCard({
    required this.id,
    required this.points,
    required this.date,
    required this.index,
  });

  // Color-code based on points earned
  Color get _accentColor {
    if (points >= 100) return _C.amber;
    if (points >= 50)  return _C.cyan;
    return _C.green;
  }

  String get _tier {
    if (points >= 100) return 'GOLD';
    if (points >= 50)  return 'SILVER';
    return 'BRONZE';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _C.border),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          // Points badge
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: _accentColor.withOpacity(0.10),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _accentColor.withOpacity(0.3)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$points',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: _accentColor,
                    height: 1,
                  ),
                ),
                Text(
                  'PTS',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 8,
                    letterSpacing: 1,
                    color: _accentColor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 14),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'ENTRY #$id',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        letterSpacing: 1.5,
                        color: _C.textPri,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: _accentColor.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _tier,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 8,
                          letterSpacing: 1.5,
                          color: _accentColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.access_time,
                        size: 11, color: _C.textSec),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        date,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          color: _C.textSec,
                          letterSpacing: 0.5,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Rank index
          Text(
            '${(index + 1).toString().padLeft(2, '0')}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: _C.textSec.withOpacity(0.4),
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Scanline grid painter (same as home page) ────────────────────────────────
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