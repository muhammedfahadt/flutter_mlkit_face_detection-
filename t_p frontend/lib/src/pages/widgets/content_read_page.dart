import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';
import 'package:built_collection/built_collection.dart';
import 'package:traffic_patrol/src/pages/widgets/_read_list_item.dart';

class ContentReadPage extends StatefulWidget {
  const ContentReadPage({super.key});

  @override
  State<ContentReadPage> createState() => _ContentReadPageState();
}

class _ContentReadPageState extends State<ContentReadPage> {
  final Openapi _openapi = Openapi();

  bool _loading = true;
  String? _error;
  BuiltList<ContentDTO>? _items;

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
      final response = await _openapi.getContentResourceApi().getAllContents(
        headers: {'Authorization': 'Bearer ${Openapi.bearerToken}'},
      );

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to load contents (HTTP ${response.statusCode})',
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
      appBar: AppBar(title: const Text('Contents')),
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
          ? const Center(child: Text('No contents found.'))
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView.separated(
                itemCount: _items!.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = _items![index];
                  return ReadListItem(
                    icon: Icons.image_outlined,
                    title: 'Content #${item.id ?? '-'}',
                    subtitle:
                        [
                              item.contentType,
                              item.uploadDateTime?.toIso8601String(),
                              item.status,
                            ]
                            .where((e) => e != null && e.toString().isNotEmpty)
                            .join(' • '),
                  );
                },
              ),
            ),
    );
  }
}
