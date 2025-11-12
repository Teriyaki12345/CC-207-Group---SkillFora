import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const Color primaryBlue = Color(0xFF0360D9);
const Color primaryYellow = Color(0xFFF2B705);
const Color inputBorderColor = Color(0xFFFFA000);

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _agreedToTerms = false;
  bool _isPasswordVisible = false;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _firstNameErrorText;
  String? _lastNameErrorText;
  String? _emailErrorText;
  String? _passwordErrorText;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  bool _validateAndSave() {
    setState(() {
      _firstNameErrorText = null;
      _lastNameErrorText = null;
      _emailErrorText = null;
      _passwordErrorText = null;
    });

    bool isValid = true;
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (firstName.isEmpty) {
      _firstNameErrorText = 'First name is required.';
      isValid = false;
    }
    if (lastName.isEmpty) {
      _lastNameErrorText = 'Last name is required.';
      isValid = false;
    }
    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      _emailErrorText = 'Please enter a valid email.';
      isValid = false;
    }
    if (password.length < 6) {
      _passwordErrorText = 'Password must be at least 6 characters.';
      isValid = false;
    }
    if (!_agreedToTerms) {
        isValid = false;
    }
    
    setState(() {}); 
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBFBFB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Create Account',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36, color: primaryBlue, fontWeight: FontWeight.w700),
              ),
              
              const SizedBox(height: 50),
              
              _buildInputField(
                  label: 'First Name*', 
                  hint: 'Jane', 
                  controller: _firstNameController,
                  errorText: _firstNameErrorText
              ),
              
              const SizedBox(height: 20),
              
              _buildInputField(
                  label: 'Last Name*', 
                  hint: 'Doe', 
                  controller: _lastNameController,
                  errorText: _lastNameErrorText
              ),
              
              const SizedBox(height: 20),
              
              _buildInputField(
                  label: 'Email', 
                  hint: 'example@email.com', 
                  controller: _emailController,
                  errorText: _emailErrorText
              ),
              
              const SizedBox(height: 20),
              
              _buildInputField(
                  label: 'Password', 
                  hint: '••••••••', 
                  isPassword: true, 
                  controller: _passwordController,
                  errorText: _passwordErrorText
              ),
              
              const SizedBox(height: 10),

              Row(
                children: [
                  Checkbox(
                    value: _agreedToTerms,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _agreedToTerms = newValue ?? false;
                      });
                    },
                    activeColor: primaryBlue,
                  ),
                  const Text('Agree with '),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Terms & Conditions',
                      style: TextStyle(color: primaryBlue, decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 30),
              
              _buildPrimaryButton(text: 'Sign Up', isEnabled: _agreedToTerms),
              
              const SizedBox(height: 40),
              
              _buildDividerWithText('or sign up with'),
              
              const SizedBox(height: 30),
              
              _buildSocialIconsRow(),

              const SizedBox(height: 40),
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

  Widget _buildPrimaryButton({required String text, required bool isEnabled}) {
  return ElevatedButton(
    onPressed: isEnabled ? () { 
      if (_validateAndSave()) {
        Navigator.of(context).pop(); 
      }
    } : null,
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryYellow,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      disabledBackgroundColor: primaryYellow.withOpacity(0.5)
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18, 
        color: isEnabled ? primaryBlue : primaryBlue.withOpacity(0.5),
        fontWeight: FontWeight.w700, 
      ),
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