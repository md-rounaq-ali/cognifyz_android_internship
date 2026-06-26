import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const FetchDataApp());
}

class FetchDataApp extends StatelessWidget {
  const FetchDataApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task 5 - Fetch and Display Data',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF48CAE4),
        brightness: Brightness.dark,
      ),
      home: const FetchDataScreen(),
    );
  }
}

class UserModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final String company;
  final String city;

  const UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.company,
    required this.city,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      company: json['company']?['name'] ?? '',
      city: json['address']?['city'] ?? '',
    );
  }
}

class FetchDataScreen extends StatefulWidget {
  const FetchDataScreen({super.key});

  @override
  State<FetchDataScreen> createState() => _FetchDataScreenState();
}

class _FetchDataScreenState extends State<FetchDataScreen> {
  List<UserModel> _users = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';

  final List<Color> _avatarColors = [
    const Color(0xFF6C63FF),
    const Color(0xFF00D4AA),
    const Color(0xFFFF6B6B),
    const Color(0xFFFFD700),
    const Color(0xFFFF9F43),
    const Color(0xFF48CAE4),
    const Color(0xFFA29BFE),
    const Color(0xFFFF7675),
    const Color(0xFF00CEC9),
    const Color(0xFFFDCB6E),
  ];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _users = data.map((json) => UserModel.fromJson(json)).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Server error: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to fetch data. Check your connection.\n${e.toString()}';
        _isLoading = false;
      });
    }
  }

  List<UserModel> get _filteredUsers {
    if (_searchQuery.isEmpty) return _users;
    return _users.where((u) =>
      u.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      u.email.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      u.company.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0A0E21), Color(0xFF1A1F36)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF48CAE4).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFF48CAE4).withOpacity(0.4)),
                          ),
                          child: Text('Level 3 • Advanced', style: GoogleFonts.outfit(color: const Color(0xFF48CAE4), fontSize: 11, fontWeight: FontWeight.w600)),
                        ),
                        const Spacer(),
                        if (!_isLoading)
                          IconButton(
                            onPressed: _fetchUsers,
                            icon: const Icon(Icons.refresh_rounded, color: Color(0xFF48CAE4)),
                            tooltip: 'Refresh Data',
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text('Live API Data', style: GoogleFonts.outfit(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800)),
                    Text('Fetched from JSONPlaceholder API', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 13)),
                    const SizedBox(height: 20),

                    // Stats Row
                    if (_users.isNotEmpty)
                      Row(
                        children: [
                          _miniStat('${_users.length}', 'Total Users', const Color(0xFF48CAE4)),
                          const SizedBox(width: 12),
                          _miniStat('${_filteredUsers.length}', 'Showing', const Color(0xFF6C63FF)),
                          const SizedBox(width: 12),
                          _miniStat('✅', 'API Live', const Color(0xFF00D4AA)),
                        ],
                      ),

                    const SizedBox(height: 16),

                    // Search Bar
                    if (_users.isNotEmpty)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: TextField(
                          style: GoogleFonts.outfit(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Search users...',
                            hintStyle: GoogleFonts.outfit(color: Colors.white38),
                            prefixIcon: const Icon(Icons.search_rounded, color: Colors.white38),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          ),
                          onChanged: (v) => setState(() => _searchQuery = v),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Body
              Expanded(
                child: _isLoading
                    ? _buildLoadingState()
                    : _error != null
                        ? _buildErrorState()
                        : _filteredUsers.isEmpty
                            ? _buildEmptyState()
                            : ListView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                itemCount: _filteredUsers.length,
                                itemBuilder: (context, index) {
                                  return _UserCard(
                                    user: _filteredUsers[index],
                                    color: _avatarColors[_filteredUsers[index].id % _avatarColors.length],
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

  Widget _miniStat(String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(value, style: GoogleFonts.outfit(color: color, fontWeight: FontWeight.w700, fontSize: 16)),
          Text(label, style: GoogleFonts.outfit(color: Colors.white38, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Color(0xFF48CAE4)),
          const SizedBox(height: 24),
          Text('Fetching users from API...', style: GoogleFonts.outfit(color: Colors.white54, fontSize: 14)),
          const SizedBox(height: 8),
          Text('jsonplaceholder.typicode.com', style: GoogleFonts.outfit(color: Colors.white24, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('❌', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 16),
            Text('Failed to load data', style: GoogleFonts.outfit(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(_error ?? '', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 12), textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _fetchUsers,
              icon: const Icon(Icons.refresh_rounded),
              label: Text('Retry', style: GoogleFonts.outfit()),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF48CAE4), foregroundColor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🔍', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          Text('No results for "$_searchQuery"', style: GoogleFonts.outfit(color: Colors.white54, fontSize: 14)),
        ],
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final UserModel user;
  final Color color;

  const _UserCard({required this.user, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(color: color.withOpacity(0.4), width: 2),
            ),
            child: Center(
              child: Text(
                user.name.substring(0, 2).toUpperCase(),
                style: GoogleFonts.outfit(color: color, fontWeight: FontWeight.w800, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.email_outlined, size: 12, color: Colors.white38),
                    const SizedBox(width: 4),
                    Expanded(child: Text(user.email, style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12), overflow: TextOverflow.ellipsis)),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.location_city_outlined, size: 12, color: Colors.white38),
                    const SizedBox(width: 4),
                    Text(user.city, style: GoogleFonts.outfit(color: Colors.white38, fontSize: 12)),
                    const SizedBox(width: 8),
                    const Icon(Icons.business_outlined, size: 12, color: Colors.white38),
                    const SizedBox(width: 4),
                    Expanded(child: Text(user.company, style: GoogleFonts.outfit(color: Colors.white38, fontSize: 12), overflow: TextOverflow.ellipsis)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text('#${user.id}', style: GoogleFonts.outfit(color: color, fontSize: 11, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}
