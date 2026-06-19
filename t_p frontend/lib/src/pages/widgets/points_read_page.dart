import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';
import 'package:built_collection/built_collection.dart';

import 'package:traffic_patrol/src/pages/widgets/_read_list_item.dart';

class PointsReadPage extends StatefulWidget {
  const PointsReadPage({super.key});

  @override
  State<PointsReadPage> createState() => _PointsReadPageState();
}

class _PointsReadPageState extends State<PointsReadPage> {
  final Openapi _openapi = Openapi();

  bool _loading = true;
  String? _error;
  BuiltList<PointsDTO>? _items;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final response = await _openapi.getPointsResourceApi().getAllPoints(
        // backend supports filter; leaving null for now.
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Points')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(_error!),
              ),
            )
          : _items == null || _items!.isEmpty
          ? const Center(child: Text('No points found.'))
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView.separated(
                itemCount: _items!.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = _items![index];
                  final subtitle = [
                    'Earned: ${item.pointsEarned ?? '-'}',
                    'Uploaded: ${item.uploadDateTime?.toIso8601String()}',
                  ].where((e) => e.isNotEmpty && e != 'null').join(' • ');

                  return ReadListItem(
                    icon: Icons.stars_outlined,
                    title: 'Points #${item.id ?? '-'}',
                    subtitle: subtitle.isEmpty ? null : subtitle,
                  );
                },
              ),
            ),
    );
  }
}
