import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/widgets/custom_button.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/res/assets_res.dart';
import 'package:tasky/screens/main_screen.dart';
import '../core/utils/app_style.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AssetsRes.LOGO,
                      width: 42,
                      height: 42,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Tasky',
                      style: AppStyle.regular28,
                    ),
                  ],
                ),
                const SizedBox(height: 108),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome To Tasky',
                      style: AppStyle.regular24,
                    ),
                    const SizedBox(width: 8),
                    SvgPicture.asset(
                      AssetsRes.WAVING_HAND,
                      width: 28,
                      height: 28,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your productivity journey starts here.',
                  style: AppStyle.regular16,
                ),
                const SizedBox(height: 24),
                SvgPicture.asset(
                  AssetsRes.WELCOME,
                  width: 214,
                  height: 204,
                ),
                const SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Full Name',
                        style: AppStyle.regular16,
                      ),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: _controller,
                        validator: (value) {
                          if (value?.trim().isEmpty ?? false) {
                            return 'Please Enter Your Name';
                          }
                          return null;
                        },
                        onChanged: (value) {},
                        hintText: 'e.g. Sarah Khalid',
                      ),
                      const SizedBox(height: 24),
                      CustomButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString(
                                'name', _controller.value.text);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainScreen(),
                              ),
                            );
                          }
                        },
                        title: 'Let’s Get Started',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
