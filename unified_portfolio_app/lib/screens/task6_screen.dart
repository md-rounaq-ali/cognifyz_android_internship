import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Task6Screen extends StatefulWidget {
  const Task6Screen({super.key});

  @override
  State<Task6Screen> createState() => _Task6ScreenState();
}

class _Task6ScreenState extends State<Task6Screen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  String _role = 'Student';
  bool _agree = false;
  bool _isSubmitting = false;
  bool _isSubmitted = false;

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<double> _checkAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _checkAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.elasticOut));
  }

  @override
  void dispose() { _nameCtrl.dispose(); _emailCtrl.dispose(); _phoneCtrl.dispose(); _animCtrl.dispose(); super.dispose(); }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agree) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please agree to terms', style: GoogleFonts.outfit()), backgroundColor: const Color(0xFFFF6B6B), behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), margin: const EdgeInsets.all(16))); return; }
    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) { setState(() { _isSubmitting = false; _isSubmitted = true; }); _animCtrl.forward(); }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF13111C), Color(0xFF1E1B2E)])),
        child: SafeArea(
          child: _isSubmitted ? _success() : _form(),
        ),
      ),
    );
  }

  Widget _success() {
    return FadeTransition(opacity: _fadeAnim, child: Center(child: Padding(padding: const EdgeInsets.all(32), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      ScaleTransition(scale: _checkAnim, child: Container(width: 110, height: 110, decoration: BoxDecoration(shape: BoxShape.circle, gradient: const LinearGradient(colors: [Color(0xFF00D4AA), Color(0xFF6C63FF)]), boxShadow: [BoxShadow(color: const Color(0xFF00D4AA).withOpacity(0.4), blurRadius: 40)]),
        child: const Icon(Icons.check_rounded, color: Colors.white, size: 56))),
      const SizedBox(height: 28),
      Text('Submitted! 🎉', style: GoogleFonts.outfit(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800)),
      const SizedBox(height: 8),
      Text('Thank you, ${_nameCtrl.text}!\nYour form was received.', style: GoogleFonts.outfit(color: Colors.white54, fontSize: 14, height: 1.6), textAlign: TextAlign.center),
      const SizedBox(height: 28),
      SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: () { _animCtrl.reset(); _nameCtrl.clear(); _emailCtrl.clear(); _phoneCtrl.clear(); setState(() { _isSubmitted = false; _agree = false; _role = 'Student'; }); },
        icon: const Icon(Icons.refresh_rounded), label: Text('Submit Again', style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFA29BFE), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
      )),
    ]))));
  }

  Widget _form() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20))),
          const SizedBox(width: 16),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Task 6', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11)),
            Text('Simple Form', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
          ]),
        ]),
        const SizedBox(height: 28),
        Text('Contact Form', style: GoogleFonts.outfit(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800)),
        Text('Fill in your details below', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 13)),
        const SizedBox(height: 24),
        _field(_nameCtrl, 'Full Name', Icons.person_outline_rounded, validator: (v) => (v?.isEmpty ?? true) ? 'Required' : null),
        const SizedBox(height: 16),
        _field(_emailCtrl, 'Email Address', Icons.email_outlined, keyboard: TextInputType.emailAddress, validator: (v) { if (v?.isEmpty ?? true) return 'Required'; return v!.contains('@') ? null : 'Invalid email'; }),
        const SizedBox(height: 16),
        _field(_phoneCtrl, 'Phone Number', Icons.phone_outlined, keyboard: TextInputType.phone, validator: (v) { if (v?.isEmpty ?? true) return 'Required'; return v!.replaceAll(RegExp(r'[^0-9]'), '').length >= 10 ? null : 'Invalid phone'; }),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.white.withOpacity(0.12))),
          child: DropdownButtonFormField<String>(value: _role, dropdownColor: const Color(0xFF1E1B2E), style: GoogleFonts.outfit(color: Colors.white),
            decoration: InputDecoration(prefixIcon: const Icon(Icons.work_outline_rounded, color: Color(0xFFA29BFE), size: 20), border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(vertical: 14)),
            items: ['Student', 'Developer', 'Designer', 'Manager', 'Other'].map((r) => DropdownMenuItem(value: r, child: Text(r, style: GoogleFonts.outfit(color: Colors.white)))).toList(),
            onChanged: (v) => setState(() => _role = v!),
          ),
        ),
        const SizedBox(height: 20),
        Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Checkbox(value: _agree, onChanged: (v) => setState(() => _agree = v!), activeColor: const Color(0xFFA29BFE), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
          Expanded(child: Text('I agree to Terms & Conditions', style: GoogleFonts.outfit(color: Colors.white54, fontSize: 13))),
        ]),
        const SizedBox(height: 24),
        SizedBox(width: double.infinity, child: ElevatedButton(
          onPressed: _isSubmitting ? null : _submit,
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFA29BFE), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
          child: _isSubmitting
              ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)), const SizedBox(width: 12), Text('Submitting...', style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w600))])
              : Text('Submit Form', style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w700)),
        )),
      ])),
    );
  }

  Widget _field(TextEditingController ctrl, String hint, IconData icon, {TextInputType? keyboard, String? Function(String?)? validator}) {
    return TextFormField(controller: ctrl, keyboardType: keyboard, style: GoogleFonts.outfit(color: Colors.white), validator: validator,
      decoration: InputDecoration(hintText: hint, hintStyle: GoogleFonts.outfit(color: Colors.white24), prefixIcon: Icon(icon, color: const Color(0xFFA29BFE), size: 20),
        filled: true, fillColor: Colors.white.withOpacity(0.06),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: Colors.white.withOpacity(0.12))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: Colors.white.withOpacity(0.12))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFA29BFE), width: 1.5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ));
  }
}
