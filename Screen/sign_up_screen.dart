import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos/Helper/pos_text_formfield.dart';
import 'package:pos/Screen/login_screen.dart';
import 'package:pos/Screen/UserRepository.dart'; // <-- import UserRepository

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _togglePasswordVisibility() =>
      setState(() => _obscurePassword = !_obscurePassword);

  void _toggleConfirmPasswordVisibility() =>
      setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);

  void _register() {
    if (_formKey.currentState!.validate()) {
      // ✅ save user in memory
      UserRepository.register(_emailController.text, _passwordController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration successful!")),
      );

      // Go back to Login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 80),
            Text(
              "Sign Up",
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 0, 103, 188),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Create your account to get started.',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 32),

            PosTextFormfield(
              controller: _emailController,
              label: "Email",
              hintText: "Enter your email",
              prefixIcon: const Icon(Icons.email, color: Colors.black),
              validator: (value) {
                if (value == null || value.isEmpty) return "Email required";
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                    .hasMatch(value)) return "Enter valid email";
                return null;
              },
            ),
            const SizedBox(height: 16),

            PosTextFormfield(
              controller: _phoneController,
              label: "Phone Number",
              hintText: "Enter phone",
              prefixIcon: const Icon(Icons.phone, color: Colors.black),
              validator: (value) {
                if (value == null || value.isEmpty) return "Phone required";
                if (!RegExp(r'^[0-9]+$').hasMatch(value))
                  return "Numbers only";
                if (value.length < 8) return "At least 8 digits";
                return null;
              },
            ),
            const SizedBox(height: 16),

            PosTextFormfield(
              controller: _passwordController,
              label: "Password",
              hintText: "Enter password",
              prefixIcon: const Icon(Icons.lock, color: Colors.black),
              isObscure: _obscurePassword,
              suffixIcon: IconButton(
                icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black),
                onPressed: _togglePasswordVisibility,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return "Password required";
                if (value.length < 6) return "Min 6 characters";
                return null;
              },
            ),
            const SizedBox(height: 16),

            PosTextFormfield(
              controller: _confirmPasswordController,
              label: "Confirm Password",
              hintText: "Re-enter password",
              prefixIcon: const Icon(Icons.lock_outline, color: Colors.black),
              isObscure: _obscureConfirmPassword,
              suffixIcon: IconButton(
                icon: Icon(_obscureConfirmPassword
                    ? Icons.visibility_off
                    : Icons.visibility),
                onPressed: _toggleConfirmPasswordVisibility,
              ),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "Confirm password";
                if (value != _passwordController.text)
                  return "Passwords do not match";
                return null;
              },
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 2, 103, 211),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: _register,
              child: Text(
                "Register",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? ",
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: Colors.grey[700])),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const LoginScreen()));
                  },
                  child: Text(
                    "Login",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 0, 84, 187),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
