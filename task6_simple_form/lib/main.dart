import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const SimpleFormApp());
}

class SimpleFormApp extends StatelessWidget {
  const SimpleFormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task 6 - Simple Form',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFFA29BFE),
        brightness: Brightness.dark,
      ),
      home: const SimpleFormScreen(),
    );
  }
}

class SimpleFormScreen extends StatefulWidget {
  const SimpleFormScreen({super.key});

  @override
  State<SimpleFormScreen> createState() => _SimpleFormScreenState();
}

class _SimpleFormScreenState extends State<SimpleFormScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  String _selectedRole = 'Student';
  bool _agreeToTerms = false;
  bool _isSubmitting = false;
  bool _isSubmitted = false;

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<double> _checkAnim;

  final List<String> _roles = ['Student', 'Developer', 'Designer', 'Manager', 'Other'];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _checkAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    _animController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please agree to the terms & conditions', style: GoogleFonts.outfit()),
          backgroundColor: const Color(0xFFFF6B6B),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isSubmitting = false;
        _isSubmitted = true;
      });
      _animController.forward();
    }
  }

  void _resetForm() {
    _animController.reset();
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _messageController.clear();
    setState(() {
      _isSubmitted = false;
      _agreeToTerms = false;
      _selectedRole = 'Student';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF13111C), Color(0xFF1E1B2E)],
          ),
        ),
        child: SafeArea(
          child: _isSubmitted ? _buildSuccessScreen() : _buildFormScreen(),
        ),
      ),
    );
  }

  Widget _buildSuccessScreen() {
    return FadeTransition(
      opacity: _fadeAnim,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _checkAnim,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00D4AA), Color(0xFF6C63FF)],
                    ),
                    boxShadow: [
                      BoxShadow(color: const Color(0xFF00D4AA).withOpacity(0.4), blurRadius: 40),
                    ],
                  ),
                  child: const Icon(Icons.check_rounded, color: Colors.white, size: 60),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Form Submitted!',
                style: GoogleFonts.outfit(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),
              Text(
                'Thank you, ${_nameController.text}!\nYour message has been received.',
                style: GoogleFonts.outfit(color: Colors.white54, fontSize: 15, height: 1.6),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              _buildSubmitSummary(),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _resetForm,
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text('Submit Another Response', style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA29BFE),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          _summaryRow(Icons.person_rounded, 'Name', _nameController.text),
          _summaryRow(Icons.email_rounded, 'Email', _emailController.text),
          _summaryRow(Icons.phone_rounded, 'Phone', _phoneController.text),
          _summaryRow(Icons.work_rounded, 'Role', _selectedRole),
        ],
      ),
    );
  }

  Widget _summaryRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: const Color(0xFFA29BFE)),
          const SizedBox(width: 10),
          Text('$label: ', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 13)),
          Expanded(child: Text(value, style: GoogleFonts.outfit(color: Colors.white70, fontSize: 13), overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }

  Widget _buildFormScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFA29BFE).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFA29BFE).withOpacity(0.4)),
                  ),
                  child: Text('Level 3 • Advanced', style: GoogleFonts.outfit(color: const Color(0xFFA29BFE), fontSize: 11, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Contact Form', style: GoogleFonts.outfit(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800)),
            Text('Fill in your details below', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 14)),

            const SizedBox(height: 32),

            // Name Field
            _buildLabel('Full Name', Icons.person_rounded),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _nameController,
              hint: 'Enter your full name',
              icon: Icons.person_outline_rounded,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Name is required';
                if (v.trim().length < 2) return 'Name must be at least 2 characters';
                return null;
              },
            ),

            const SizedBox(height: 20),

            // Email Field
            _buildLabel('Email Address', Icons.email_rounded),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _emailController,
              hint: 'example@email.com',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Email is required';
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(v.trim())) return 'Enter a valid email address';
                return null;
              },
            ),

            const SizedBox(height: 20),

            // Phone Field
            _buildLabel('Phone Number', Icons.phone_rounded),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _phoneController,
              hint: '+91 XXXXX XXXXX',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Phone number is required';
                final digits = v.replaceAll(RegExp(r'[^0-9]'), '');
                if (digits.length < 10) return 'Enter a valid phone number';
                return null;
              },
            ),

            const SizedBox(height: 20),

            // Role Dropdown
            _buildLabel('Role', Icons.work_rounded),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white.withOpacity(0.12)),
              ),
              child: DropdownButtonFormField<String>(
                value: _selectedRole,
                dropdownColor: const Color(0xFF1E1B2E),
                style: GoogleFonts.outfit(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.work_outline_rounded, color: Color(0xFFA29BFE)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
                items: _roles.map((r) => DropdownMenuItem(
                  value: r,
                  child: Text(r, style: GoogleFonts.outfit(color: Colors.white)),
                )).toList(),
                onChanged: (v) => setState(() => _selectedRole = v!),
              ),
            ),

            const SizedBox(height: 20),

            // Message Field
            _buildLabel('Message', Icons.message_rounded),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _messageController,
              hint: 'Write your message here...',
              icon: Icons.message_outlined,
              maxLines: 4,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Message is required';
                if (v.trim().length < 10) return 'Message must be at least 10 characters';
                return null;
              },
            ),

            const SizedBox(height: 24),

            // Terms Checkbox
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: _agreeToTerms,
                  onChanged: (v) => setState(() => _agreeToTerms = v!),
                  activeColor: const Color(0xFFA29BFE),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.outfit(color: Colors.white54, fontSize: 13),
                        children: const [
                          TextSpan(text: 'I agree to the '),
                          TextSpan(text: 'Terms & Conditions', style: TextStyle(color: Color(0xFFA29BFE), fontWeight: FontWeight.w600)),
                          TextSpan(text: ' and '),
                          TextSpan(text: 'Privacy Policy', style: TextStyle(color: Color(0xFFA29BFE), fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA29BFE),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 8,
                  shadowColor: const Color(0xFFA29BFE).withOpacity(0.4),
                ),
                child: _isSubmitting
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
                          const SizedBox(width: 12),
                          Text('Submitting...', style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w600)),
                        ],
                      )
                    : Text('Submit Form', style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
              ),
            ),

            const SizedBox(height: 24),

            Center(child: Text('Cognifyz IT Solutions Pvt. Ltd.', style: GoogleFonts.outfit(color: Colors.white24, fontSize: 11))),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 14, color: const Color(0xFFA29BFE)),
        const SizedBox(width: 6),
        Text(text, style: GoogleFonts.outfit(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: GoogleFonts.outfit(color: Colors.white),
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.outfit(color: Colors.white24),
        prefixIcon: maxLines == 1 ? Icon(icon, color: const Color(0xFFA29BFE), size: 20) : null,
        filled: true,
        fillColor: Colors.white.withOpacity(0.06),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.12)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.12)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFA29BFE), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFFF6B6B), width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
