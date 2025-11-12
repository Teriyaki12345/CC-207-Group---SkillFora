import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skill_flora_app/screens/register.dart'; 

const Color primaryBlue = Color(0xFF0360D9);
const Color primaryYellow = Color(0xFFF2B705);
const Color inputBorderColor = Color(0xFFFFA000);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome!')),
      body: const Center(
        child: Text(
          'Login Successful!',
          style: TextStyle(fontSize: 24, color: primaryBlue),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _emailErrorText;
  String? _passwordErrorText;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  bool _validateAndSave() {
    setState(() {
      _emailErrorText = null;
      _passwordErrorText = null;
    });

    bool isValid = true;
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      _emailErrorText = 'Please enter a valid email.';
      isValid = false;
    }

    if (password.isEmpty) {
      _passwordErrorText = 'Password cannot be empty.';
      isValid = false;
    }
    
    setState(() {}); 
    return isValid;
  }

  void _handleLogin(BuildContext context) {
    if (_validateAndSave()) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 60),
              const Text(
                'Log in',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36, color: primaryBlue, fontWeight: FontWeight.w700),
              ),
              
              const SizedBox(height: 50),
              
              _buildInputField(
                  label: 'Email', 
                  hint: 'example@email.com', 
                  controller: _emailController,
                  errorText: _emailErrorText,
              ),
              
              const SizedBox(height: 20),
              
              _buildInputField(
                  label: 'Password', 
                  hint: '••••••••', 
                  isPassword: true, 
                  controller: _passwordController,
                  errorText: _passwordErrorText,
              ),
              
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(color: primaryBlue.withOpacity(0.75)),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              _buildPrimaryButton(text: 'Login'),
              
              const SizedBox(height: 40),
              
              _buildDividerWithText('or login with'),
              
              const SizedBox(height: 30),
              
              _buildSocialIconsRow(),
              
              const SizedBox(height: 60),
              
              _buildNoAccountLink(context),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    String? errorText,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword ? !_isPasswordVisible : false,
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: primaryBlue,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: inputBorderColor, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: primaryBlue, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryButton({required String text}) {
  return ElevatedButton(
    onPressed: () => _handleLogin(context),
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryYellow,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
    ),
    child: Text(
      text,
      style: const TextStyle(fontSize: 18, color: primaryBlue, fontWeight: FontWeight.w700),
    ),
  );
}

  Widget _buildDividerWithText(String text) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.black54)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(text, style: const TextStyle(color: Colors.black54)),
        ),
        const Expanded(child: Divider(color: Colors.black54)),
      ],
    );
  }

  Widget _buildSocialIconsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialIcon(icon: FontAwesomeIcons.google),
        const SizedBox(width: 20),
        _SocialIcon(icon: FontAwesomeIcons.facebookF),
        const SizedBox(width: 20),
        _SocialIcon(icon: FontAwesomeIcons.solidCommentDots),
      ],
    );
  }
  
  Widget _buildNoAccountLink(BuildContext context) {
    return Column(
      children: [
        const Text('No account yet?', style: TextStyle(color: Colors.black54)),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const RegistrationPage(), 
              ),
            );
          },
          child: const Text(
            'Create Account',
            style: TextStyle(color: primaryBlue),
          ),
        ),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  _SocialIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: primaryYellow,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }
}