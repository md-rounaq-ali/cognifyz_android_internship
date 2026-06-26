import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Task5Screen extends StatefulWidget {
  const Task5Screen({super.key});

  @override
  State<Task5Screen> createState() => _Task5ScreenState();
}

class _Task5ScreenState extends State<Task5Screen> {
  List<dynamic> _users = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';

  final List<Color> _colors = [
    const Color(0xFF6C63FF), const Color(0xFF00D4AA), const Color(0xFFFF6B6B),
    const Color(0xFFFFD700), const Color(0xFFFF9F43), const Color(0xFF48CAE4),
    const Color(0xFFA29BFE), const Color(0xFFFF7675), const Color(0xFF00CEC9), const Color(0xFFFDCB6E),
  ];

  @override
  void initState() { super.initState(); _fetch(); }

  Future<void> _fetch() async {
    setState(() { _isLoading = true; _error = null; });
    try {
      final res = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users')).timeout(const Duration(seconds: 10));
      if (res.statusCode == 200) { setState(() { _users = jsonDecode(res.body); _isLoading = false; }); }
      else { setState(() { _error = 'Server error: ${res.statusCode}'; _isLoading = false; }); }
    } catch (e) { setState(() { _error = 'Failed to fetch. Check your connection.'; _isLoading = false; }); }
  }

  List<dynamic> get _filtered => _searchQuery.isEmpty ? _users : _users.where((u) =>
    (u['name'] as String).toLowerCase().contains(_searchQuery.toLowerCase()) ||
    (u['email'] as String).toLowerCase().contains(_searchQuery.toLowerCase())).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF0A0E21), Color(0xFF1A1F36)])),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20))),
                    const SizedBox(width: 16),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Task 5', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11)),
                      Text('Fetch & Display Data', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                    ]),
                    const Spacer(),
                    if (!_isLoading) IconButton(onPressed: _fetch, icon: const Icon(Icons.refresh_rounded, color: Color(0xFF48CAE4))),
                  ]),
                  const SizedBox(height: 16),
                  if (_users.isNotEmpty) Container(
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.white.withOpacity(0.1))),
                    child: TextField(
                      style: GoogleFonts.outfit(color: Colors.white),
                      decoration: InputDecoration(hintText: 'Search users...', hintStyle: GoogleFonts.outfit(color: Colors.white38), prefixIcon: const Icon(Icons.search_rounded, color: Colors.white38), border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
                      onChanged: (v) => setState(() => _searchQuery = v),
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: _isLoading
                    ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const CircularProgressIndicator(color: Color(0xFF48CAE4)), const SizedBox(height: 16), Text('Fetching from API...', style: GoogleFonts.outfit(color: Colors.white54))]))
                    : _error != null
                        ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                            const Text('❌', style: TextStyle(fontSize: 48)), const SizedBox(height: 12),
                            Text(_error!, style: GoogleFonts.outfit(color: Colors.white54), textAlign: TextAlign.center),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(onPressed: _fetch, icon: const Icon(Icons.refresh_rounded), label: Text('Retry', style: GoogleFonts.outfit()), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF48CAE4), foregroundColor: Colors.white)),
                          ]))
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            itemCount: _filtered.length,
                            itemBuilder: (ctx, i) {
                              final u = _filtered[i];
                              final color = _colors[(u['id'] as int) % _colors.length];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.08))),
                                child: Row(children: [
                                  Container(width: 46, height: 46, decoration: BoxDecoration(color: color.withOpacity(0.2), shape: BoxShape.circle, border: Border.all(color: color.withOpacity(0.4), width: 2)),
                                    child: Center(child: Text((u['name'] as String).substring(0, 2).toUpperCase(), style: GoogleFonts.outfit(color: color, fontWeight: FontWeight.w800, fontSize: 15)))),
                                  const SizedBox(width: 14),
                                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Text(u['name'] as String, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
                                    Text(u['email'] as String, style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12), overflow: TextOverflow.ellipsis),
                                    Text((u['company'] as Map)['name'] as String, style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11), overflow: TextOverflow.ellipsis),
                                  ])),
                                  Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(8)), child: Text('#${u['id']}', style: GoogleFonts.outfit(color: color, fontSize: 11, fontWeight: FontWeight.w700))),
                                ]),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
