import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widgets/custom_button.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/res/assets_res.dart';
import 'package:tasky/screens/main_screen.dart';

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
                  const CustomSvgPicture.withColorFilter(assetName: AssetsRes.LOGO),
                    const SizedBox(width: 8),
                    Text(
                      'Tasky',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 108),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                      'Welcome To Tasky',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(width: 8),
                    const CustomSvgPicture.withColorFilter(assetName: AssetsRes.WAVING_HAND),
                  ],
                ),
                const SizedBox(height: 8),
                 Text(
                  'Your productivity journey starts here.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                const CustomSvgPicture.withColorFilter(assetName: AssetsRes.WELCOME),
                const SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        'Full Name',
                        style: Theme.of(context).textTheme.bodyMedium,
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
                            await PreferencesManager().setString('name', _controller.value.text);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainScreen(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please Enter Your Name'),
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
