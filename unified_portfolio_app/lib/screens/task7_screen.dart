import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' hide Context, context;

class _DBHelper {
  static final _DBHelper _i = _DBHelper._();
  factory _DBHelper() => _i;
  _DBHelper._();
  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await openDatabase(join(await getDatabasesPath(), 'portfolio_users.db'), version: 1, onCreate: (db, v) async {
      await db.execute('CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, email TEXT NOT NULL, role TEXT NOT NULL, created_at TEXT NOT NULL)');
    });
    return _db!;
  }

  Future<int> insert(Map<String, dynamic> data) async => (await db).insert('users', data, conflictAlgorithm: ConflictAlgorithm.replace);
  Future<List<Map<String, dynamic>>> getAll() async => (await db).query('users', orderBy: 'created_at DESC');
  Future<int> delete(int id) async => (await db).delete('users', where: 'id = ?', whereArgs: [id]);
}

class Task7Screen extends StatefulWidget {
  const Task7Screen({super.key});

  @override
  State<Task7Screen> createState() => _Task7ScreenState();
}

class _Task7ScreenState extends State<Task7Screen> {
  final _db = _DBHelper();
  List<Map<String, dynamic>> _users = [];
  bool _isLoading = true;

  @override
  void initState() { super.initState(); _load(); }

  Future<void> _load() async {
    setState(() => _isLoading = true);
    final users = await _db.getAll();
    setState(() { _users = users; _isLoading = false; });
  }

  Future<void> _delete(int id, String name) async {
    final confirmed = await showDialog<bool>(context: context, builder: (ctx) => AlertDialog(
      backgroundColor: const Color(0xFF1E1B2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text('Delete "$name"?', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700)),
      content: Text('This will be removed from the database.', style: GoogleFonts.outfit(color: Colors.white60)),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text('Cancel', style: GoogleFonts.outfit(color: Colors.white54))),
        ElevatedButton(onPressed: () => Navigator.pop(ctx, true), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF6B6B), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), child: Text('Delete', style: GoogleFonts.outfit())),
      ],
    ));
    if (confirmed == true) { await _db.delete(id); _load(); }
  }

  void _showAdd() {
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    String role = 'Developer';
    final fKey = GlobalKey<FormState>();

    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (ctx) => StatefulBuilder(builder: (ctx, setS) => Container(
      padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: MediaQuery.of(ctx).viewInsets.bottom + 24),
      decoration: const BoxDecoration(color: Color(0xFF1E1B2E), borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      child: Form(key: fKey, child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)))),
        const SizedBox(height: 20),
        Text('Add User to DB', style: GoogleFonts.outfit(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(height: 20),
        _sheetField(nameCtrl, 'Full Name', Icons.person_rounded, validator: (v) => (v?.isEmpty ?? true) ? 'Required' : null),
        const SizedBox(height: 12),
        _sheetField(emailCtrl, 'Email', Icons.email_rounded, keyboard: TextInputType.emailAddress, validator: (v) { if (v?.isEmpty ?? true) return 'Required'; return v!.contains('@') ? null : 'Invalid'; }),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white.withOpacity(0.1))),
          child: DropdownButtonFormField<String>(value: role, dropdownColor: const Color(0xFF1E1B2E), style: GoogleFonts.outfit(color: Colors.white),
            decoration: const InputDecoration(prefixIcon: Icon(Icons.work_outline_rounded, color: Color(0xFFFF6B6B), size: 20), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 12)),
            items: ['Developer', 'Designer', 'Manager', 'Intern', 'Student'].map((r) => DropdownMenuItem(value: r, child: Text(r, style: GoogleFonts.outfit(color: Colors.white)))).toList(),
            onChanged: (v) => setS(() => role = v!),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(width: double.infinity, child: ElevatedButton.icon(
          onPressed: () async {
            if (fKey.currentState!.validate()) {
              await _db.insert({'name': nameCtrl.text.trim(), 'email': emailCtrl.text.trim(), 'role': role, 'created_at': DateTime.now().toIso8601String()});
              if (mounted) Navigator.pop(ctx);
              _load();
            }
          },
          icon: const Icon(Icons.add_rounded), label: Text('Save to Database', style: GoogleFonts.outfit(fontWeight: FontWeight.w700)),
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF6B6B), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
        )),
      ])),
    )));
  }

  Widget _sheetField(TextEditingController ctrl, String hint, IconData icon, {TextInputType? keyboard, String? Function(String?)? validator}) {
    return TextFormField(controller: ctrl, keyboardType: keyboard, style: GoogleFonts.outfit(color: Colors.white), validator: validator,
      decoration: InputDecoration(hintText: hint, hintStyle: GoogleFonts.outfit(color: Colors.white24), prefixIcon: Icon(icon, color: const Color(0xFFFF6B6B), size: 20),
        filled: true, fillColor: Colors.white.withOpacity(0.06),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFFF6B6B), width: 1.5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF1A0A0F), Color(0xFF1E1220)])),
        child: SafeArea(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(padding: const EdgeInsets.fromLTRB(24, 20, 24, 0), child: Row(children: [
              GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20))),
              const SizedBox(width: 16),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Task 7', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11)),
                Text('Database Usage', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
              ]),
              const Spacer(),
              Text('${_users.length} records', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 12)),
              const SizedBox(width: 8),
              IconButton(onPressed: _load, icon: const Icon(Icons.refresh_rounded, color: Colors.white54, size: 20)),
            ])),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading ? const Center(child: CircularProgressIndicator(color: Color(0xFFFF6B6B)))
                : _users.isEmpty ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text('🗄️', style: TextStyle(fontSize: 52)),
                    const SizedBox(height: 16),
                    Text('Database is empty', style: GoogleFonts.outfit(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w600)),
                    Text('Tap + to add records', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 13)),
                  ]))
                : ListView.builder(padding: const EdgeInsets.symmetric(horizontal: 24), itemCount: _users.length, itemBuilder: (ctx, i) {
                    final u = _users[i];
                    const colors = [Color(0xFF6C63FF), Color(0xFF00D4AA), Color(0xFFFF9F43), Color(0xFF48CAE4), Color(0xFFA29BFE)];
                    final color = colors[i % colors.length];
                    final dt = DateTime.tryParse(u['created_at'] as String);
                    final dateStr = dt != null ? '${dt.day}/${dt.month}/${dt.year}' : '';
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.08))),
                      child: Row(children: [
                        Container(width: 44, height: 44, decoration: BoxDecoration(color: color.withOpacity(0.15), shape: BoxShape.circle),
                          child: Center(child: Text((u['name'] as String).substring(0, 1).toUpperCase(), style: GoogleFonts.outfit(color: color, fontWeight: FontWeight.w800, fontSize: 18)))),
                        const SizedBox(width: 12),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(u['name'] as String, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
                          Text(u['email'] as String, style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11), overflow: TextOverflow.ellipsis),
                          Row(children: [
                            Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(6)), child: Text(u['role'] as String, style: GoogleFonts.outfit(color: color, fontSize: 10, fontWeight: FontWeight.w600))),
                            const SizedBox(width: 8),
                            Text(dateStr, style: GoogleFonts.outfit(color: Colors.white24, fontSize: 10)),
                          ]),
                        ])),
                        GestureDetector(onTap: () => _delete(u['id'] as int, u['name'] as String),
                          child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFFFF6B6B).withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.delete_outline_rounded, color: Color(0xFFFF6B6B), size: 18))),
                      ]),
                    );
                  }),
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: _showAdd, icon: const Icon(Icons.add_rounded), label: Text('Add User', style: GoogleFonts.outfit(fontWeight: FontWeight.w600)), backgroundColor: const Color(0xFFFF6B6B), foregroundColor: Colors.white),
    );
  }
}
