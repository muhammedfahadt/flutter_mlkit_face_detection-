import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';
import 'package:built_collection/built_collection.dart';
import 'package:traffic_patrol/src/pages/widgets/_read_list_item.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

// ─── Design tokens (same across all pages) ────────────────────────────────────
class _C {
  static const bg       = Color(0xFF0A0E1A);
  static const surface  = Color(0xFF111827);
  static const border   = Color(0xFF1E2D45);
  static const amber    = Color(0xFFF59E0B);
  static const amberDim = Color(0xFF78450A);
  static const red      = Color(0xFFEF4444);
  static const cyan     = Color(0xFF06B6D4);
  static const cyanDim  = Color(0xFF164E63);
  static const green    = Color(0xFF10B981);
  static const purple   = Color(0xFFA78BFA);
  static const textPri  = Color(0xFFE2E8F0);
  static const textSec  = Color(0xFF64748B);
  static const textMono = Color(0xFF94A3B8);
}
// ─────────────────────────────────────────────────────────────────────────────

class ContentReadPage extends StatefulWidget {
  const ContentReadPage({super.key});

  @override
  State<ContentReadPage> createState() => _ContentReadPageState();
}

class _ContentReadPageState extends State<ContentReadPage>
    with SingleTickerProviderStateMixin {
  final Openapi _openapi = Openapi();

  bool _loading = true;
  String? _error;
  BuiltList<ContentDTO>? _items;

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
      final response = await _openapi.getContentResourceApi().getAllContents(
        headers: {'Authorization': 'Bearer ${Openapi.bearerToken}'},
      );
      if (response.statusCode != 200) {
        throw Exception(
            'Failed to load contents (HTTP ${response.statusCode})');
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

  /// Count items by content type
  int _countByType(String type) =>
      _items?.where((i) =>
          (i.contentType ?? '').toLowerCase().contains(type.toLowerCase()))
          .length ?? 0;

  /// Icon per content type
  IconData _iconFor(String? type) {
    if (type == null) return Icons.insert_drive_file_outlined;
    final t = type.toLowerCase();
    if (t.contains('image') || t.contains('photo')) return Icons.image_outlined;
    if (t.contains('video'))                         return Icons.videocam_outlined;
    if (t.contains('audio'))                         return Icons.audiotrack_outlined;
    return Icons.insert_drive_file_outlined;
  }

  /// Accent colour per content type
  Color _accentFor(String? type) {
    if (type == null) return _C.textSec;
    final t = type.toLowerCase();
    if (t.contains('image') || t.contains('photo')) return _C.cyan;
    if (t.contains('video'))                         return _C.purple;
    if (t.contains('audio'))                         return _C.amber;
    return _C.cyan;
  }

  /// Status colour
  Color _statusColor(String? status) {
    if (status == null) return _C.textSec;
    final s = status.toLowerCase();
    if (s.contains('approved') || s.contains('active')) return _C.green;
    if (s.contains('pending') || s.contains('review'))  return _C.amber;
    if (s.contains('rejected') || s.contains('failed')) return _C.red;
    return _C.textSec;
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
          title: const Text('CONTENTS  //  UPLOADS'),
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
            if (!_loading && _error == null && _totalCount > 0)
              _buildTypeBar(),
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
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Row(
              children: [
                // ── LOTTIE / ICON PLACEHOLDER ─────────────────────────────
                // Replace this Container with your Lottie widget, e.g.:
                 LottieBuilder.asset('assets/reporting.json',
                   width: 72, height: 72),
             
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'UPLOADED CONTENT',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          letterSpacing: 3,
                          color: _C.cyan,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      _loading
                          ? const SizedBox(
                              width: 80,
                              height: 28,
                              child: LinearProgressIndicator(
                                color: _C.cyan,
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
                            : '$_totalCount file${_totalCount == 1 ? '' : 's'} on record',
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

  // ── Content type summary bar ───────────────────────────────────────────────
  Widget _buildTypeBar() {
    final images = _countByType('image');
    final videos = _countByType('video');
    final others = _totalCount - images - videos;

    return Container(
      color: _C.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          if (images > 0) ...[
            _TypeBadge(
                icon: Icons.image_outlined,
                label: '$images IMG',
                color: _C.cyan),
            const SizedBox(width: 8),
          ],
          if (videos > 0) ...[
            _TypeBadge(
                icon: Icons.videocam_outlined,
                label: '$videos VID',
                color: _C.purple),
            const SizedBox(width: 8),
          ],
          if (others > 0)
            _TypeBadge(
                icon: Icons.insert_drive_file_outlined,
                label: '$others FILE',
                color: _C.textSec),
          const Spacer(),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _C.cyan.withOpacity(0.08),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: _C.cyan.withOpacity(0.2)),
            ),
            child: Text(
              'TOTAL  $_totalCount',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 9,
                letterSpacing: 1.5,
                color: _C.cyan,
                fontWeight: FontWeight.w600,
              ),
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
                    color: _C.cyan, shape: BoxShape.circle),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'CONTENT FEED',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: _C.cyan,
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
        children: const [
          SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(
                color: _C.cyan, strokeWidth: 1.5),
          ),
          SizedBox(height: 16),
          Text(
            'LOADING CONTENT...',
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
                    border: Border.all(color: _C.cyan),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'RETRY',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      letterSpacing: 2,
                      color: _C.cyan,
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
          Icon(Icons.cloud_upload_outlined,
              size: 48, color: _C.textSec.withOpacity(0.4)),
          const SizedBox(height: 16),
          const Text(
            'NO CONTENT ON FILE',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: _C.textSec,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Capture a violation to upload content',
            style: TextStyle(fontSize: 13, color: _C.textSec),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    return RefreshIndicator(
      color: _C.cyan,
      backgroundColor: _C.surface,
      onRefresh: _load,
      child: ListView.separated(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        itemCount: _items!.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final item   = _items![index];
          final type   = item.contentType;
          final status = item.status;
          final date   = item.uploadDateTime?.toIso8601String() ?? '--';

          return _ContentCard(
            id:     item.id?.toString() ?? '-',
            type:   type ?? 'FILE',
            status: status ?? '--',
            date:   date,
            index:  index,
            icon:   _iconFor(type),
            accent: _accentFor(type),
            statusColor: _statusColor(status),
          );
        },
      ),
    );
  }
}

// ─── Content card ─────────────────────────────────────────────────────────────
class _ContentCard extends StatelessWidget {
  final String   id;
  final String   type;
  final String   status;
  final String   date;
  final int      index;
  final IconData icon;
  final Color    accent;
  final Color    statusColor;

  const _ContentCard({
    required this.id,
    required this.type,
    required this.status,
    required this.date,
    required this.index,
    required this.icon,
    required this.accent,
    required this.statusColor,
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
                // Type icon badge
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accent.withOpacity(0.3)),
                  ),
                  child: Icon(icon, color: accent, size: 26),
                ),

                const SizedBox(width: 14),

                // Main info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CONTENT #$id',
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          letterSpacing: 1.5,
                          color: _C.textPri,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          // Content type chip
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: accent.withOpacity(0.10),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: accent.withOpacity(0.25)),
                            ),
                            child: Text(
                              type.toUpperCase(),
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 8,
                                letterSpacing: 1.5,
                                color: accent,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Status chip
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.10),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              status.toUpperCase(),
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 8,
                                letterSpacing: 1.5,
                                color: statusColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
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

          // ── Date row ──────────────────────────────────────────────────────
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                const Icon(Icons.upload_outlined,
                    size: 11, color: _C.textSec),
                const SizedBox(width: 6),
                const Text(
                  'UPLOADED',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 9,
                    letterSpacing: 2,
                    color: _C.textSec,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    date,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: _C.textMono,
                      letterSpacing: 0.5,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Status dot
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Type summary badge ───────────────────────────────────────────────────────
class _TypeBadge extends StatelessWidget {
  final IconData icon;
  final String   label;
  final Color    color;

  const _TypeBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9,
              letterSpacing: 1.5,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
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