import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';
import 'package:built_collection/built_collection.dart';

import 'package:traffic_patrol/src/pages/widgets/_read_list_item.dart';

class ViolationReadPage extends StatefulWidget {
  const ViolationReadPage({super.key});

  @override
  State<ViolationReadPage> createState() => _ViolationReadPageState();
}

class _ViolationReadPageState extends State<ViolationReadPage> {
  final Openapi _openapi = Openapi();

  bool _loading = true;
  String? _error;
  BuiltList<ViolationDTO>? _items;

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
      final response = await _openapi
          .getViolationResourceApi()
          .getAllViolations(
            headers: {'Authorization': 'Bearer ${Openapi.bearerToken}'},
          );

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to load violations (HTTP ${response.statusCode})',
        );
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
      appBar: AppBar(title: const Text('Violations')),
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
          ? const Center(child: Text('No violations found.'))
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView.separated(
                itemCount: _items!.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = _items![index];
                  final content = item.content;

                  final subtitle =
                      [
                            item.violationType,
                            'Content #${content?.id ?? '-'}',
                            content?.contentType,
                            content?.uploadDateTime?.toIso8601String(),
                          ]
                          .where((e) => e != null && e.toString().isNotEmpty)
                          .join(' • ');

                  return ReadListItem(
                    icon: Icons.warning_amber_outlined,
                    title: 'Violation #${item.id ?? '-'}',
                    subtitle: subtitle.isEmpty ? null : subtitle,
                  );
                },
              ),
            ),
    );
  }
}
