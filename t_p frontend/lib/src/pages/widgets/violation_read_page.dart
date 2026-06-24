import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';
import 'package:built_collection/built_collection.dart';

import 'package:traffic_patrol/src/pages/widgets/_read_list_item.dart';

import 'package:flutter/material.dart';

// ─── Design tokens (same as AppHomePage & PointsReadPage) ────────────────────
class _C {
  static const bg       = Color(0xFF0A0E1A);
  static const surface  = Color(0xFF111827);
  static const border   = Color(0xFF1E2D45);
  static const amber    = Color(0xFFF59E0B);
  static const amberDim = Color(0xFF78450A);
  static const red      = Color(0xFFEF4444);
  static const redDim   = Color(0xFF7F1D1D);
  static const cyan     = Color(0xFF06B6D4);
  static const green    = Color(0xFF10B981);
  static const textPri  = Color(0xFFE2E8F0);
  static const textSec  = Color(0xFF64748B);
  static const textMono = Color(0xFF94A3B8);
}
// ─────────────────────────────────────────────────────────────────────────────

class ViolationReadPage extends StatefulWidget {
  const ViolationReadPage({super.key});

  @override
  State<ViolationReadPage> createState() => _ViolationReadPageState();
}

class _ViolationReadPageState extends State<ViolationReadPage>
    with SingleTickerProviderStateMixin {
  final Openapi _openapi = Openapi();

  bool _loading = true;
  String? _error;
  BuiltList<ViolationDTO>? _items;

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
      _error   = null;
    });
    try {
      final response = await _openapi
          .getViolationResourceApi()
          .getAllViolations(
            headers: {'Authorization': 'Bearer ${Openapi.bearerToken}'},
          );
      if (response.statusCode != 200) {
        throw Exception(
            'Failed to load violations (HTTP ${response.statusCode})');
      }
      setState(() {
        _items   = response.data;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error   = e.toString();
        _loading = false;
      });
    }
  }

  // ── Helpers ────────────────────────────────────────────────────────────────
  int get _totalCount => _items?.length ?? 0;

  /// Colour-code by violation type string
  Color _accentFor(String? type) {
    if (type == null) return _C.textSec;
    final t = type.toLowerCase();
    if (t.contains('helmet') || t.contains('overload')) return _C.red;
    if (t.contains('signal') || t.contains('light'))    return _C.amber;
    if (t.contains('speed'))                             return _C.cyan;
    return _C.red; // default — all violations are critical
  }

  String _severityLabel(String? type) {
    if (type == null) return 'UNKNOWN';
    final t = type.toLowerCase();
    if (t.contains('helmet') || t.contains('overload')) return 'HIGH';
    if (t.contains('signal') || t.contains('speed'))    return 'MED';
    return 'HIGH';
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
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('VIOLATIONS  //  RECORDS'),
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
            padding:
                const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Row(
              children: [
                // ── LOTTIE / ICON PLACEHOLDER ───────────────────────────────
                // Replace this Container with your Lottie widget, e.g.:
                // LottieBuilder.asset('assets/lottie/violation.json',
                //   width: 72, height: 72)
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: _C.redDim, width: 1.5),
                    color: _C.bg,
                  ),
                  child: const Center(
                    child: Icon(Icons.gavel_outlined,
                        color: _C.red, size: 32),
                  ),
                ),
                // ── END LOTTIE PLACEHOLDER ───────────────────────────────────

                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'VIOLATION RECORDS',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          letterSpacing: 3,
                          color: _C.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      _loading
                          ? const SizedBox(
                              width: 80,
                              height: 28,
                              child: LinearProgressIndicator(
                                color: _C.red,
                                backgroundColor: _C.border,
                              ),
                            )
                          : Text(
                              '$_totalCount',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: _C.textPri,
                                letterSpacing: -0.5,
                              ),
                            ),
                      const SizedBox(height: 4),
                      Text(
                        _loading
                            ? 'Loading...'
                            : '$_totalCount violation${_totalCount == 1 ? '' : 's'} detected',
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

                // Alert indicator — flashes red when records exist
                if (!_loading && _totalCount > 0)
                  AnimatedBuilder(
                    animation: _pulseAnim,
                    builder: (_, __) => Opacity(
                      opacity: _pulseAnim.value,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: _C.red.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: _C.red.withOpacity(0.4)),
                        ),
                        child: const Text(
                          '⚠ ALERT',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 9,
                            letterSpacing: 2,
                            color: _C.red,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
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
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                    color: _C.red, shape: BoxShape.circle),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'MONITORING ACTIVE',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: _C.red,
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

  // ── Body ───────────────────────────────────────────────────────────────────
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
                color: _C.red, strokeWidth: 1.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'SCANNING RECORDS...',
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
                style:
                    const TextStyle(fontSize: 12, color: _C.textSec),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _load,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: _C.red),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'RETRY',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      letterSpacing: 2,
                      color: _C.red,
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
          Icon(Icons.check_circle_outline,
              size: 48, color: _C.green.withOpacity(0.6)),
          const SizedBox(height: 16),
          const Text(
            'NO VIOLATIONS DETECTED',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: _C.textSec,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'All clear — no records on file',
            style: TextStyle(fontSize: 13, color: _C.textSec),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    return RefreshIndicator(
      color: _C.red,
      backgroundColor: _C.surface,
      onRefresh: _load,
      child: ListView.separated(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        itemCount: _items!.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final item    = _items![index];
          final content = item.content;
          final type    = item.violationType;
          final date    = content?.uploadDateTime?.toIso8601String() ?? '--';
          final contentType = content?.contentType ?? '--';

          return _ViolationCard(
            id:          item.id?.toString() ?? '-',
            type:        type ?? 'UNKNOWN',
            contentId:   content?.id?.toString() ?? '-',
            contentType: contentType,
            date:        date,
            index:       index,
            accent:      _accentFor(type),
            severity:    _severityLabel(type),
          );
        },
      ),
    );
  }
}

// ─── Violation card ───────────────────────────────────────────────────────────
class _ViolationCard extends StatelessWidget {
  final String id;
  final String type;
  final String contentId;
  final String contentType;
  final String date;
  final int    index;
  final Color  accent;
  final String severity;

  const _ViolationCard({
    required this.id,
    required this.type,
    required this.contentId,
    required this.contentType,
    required this.date,
    required this.index,
    required this.accent,
    required this.severity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _C.border),
      ),
      child: Column(
        children: [
          // ── Top row ──────────────────────────────────────────────────────
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // Severity badge
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: accent.withOpacity(0.3)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.warning_amber_rounded,
                          color: accent, size: 22),
                      Text(
                        severity,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 7,
                          letterSpacing: 1,
                          color: accent.withOpacity(0.8),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 14),

                // Main info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'VIOLATION #$id',
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
                              color: accent.withOpacity(0.10),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              severity,
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 8,
                                letterSpacing: 1.5,
                                color: accent,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        type.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                          letterSpacing: 1,
                          color: accent,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Row index
                Text(
                  (index + 1).toString().padLeft(2, '0'),
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: _C.textSec.withOpacity(0.4),
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),

          // ── Divider ───────────────────────────────────────────────────────
          Container(height: 1, color: _C.border),

          // ── Meta row ──────────────────────────────────────────────────────
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                _MetaChip(
                  icon: Icons.folder_outlined,
                  label: 'Content #$contentId',
                ),
                const SizedBox(width: 10),
                _MetaChip(
                  icon: Icons.category_outlined,
                  label: contentType,
                ),
                const Spacer(),
                _MetaChip(
                  icon: Icons.access_time,
                  label: date.length > 16 ? date.substring(0, 16) : date,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Small meta chip ──────────────────────────────────────────────────────────
class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 11, color: _C.textSec),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 10,
            color: _C.textSec,
            letterSpacing: 0.5,
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