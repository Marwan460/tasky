import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/utils/app_style.dart';
import 'package:tasky/core/widgets/custom_button.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';

class UserDetailsScreen extends StatefulWidget {
  final String userName;
  final String motivationQuote;
  const UserDetailsScreen({super.key, required this.userName, required this.motivationQuote});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController motivationQuoteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userNameController.text = widget.userName;
    motivationQuoteController.text = widget.motivationQuote;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'User Name',
                style: AppStyle.regular16,
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                onChanged: (String value) {},
                controller: userNameController,
                hintText: 'User Name',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please Enter User Name';
                  }
                  return null;
                }
              ),
              const SizedBox(height: 20),
              const Text(
                'Motivation Quote',
                style: AppStyle.regular16,
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                maxLines: 5,
                onChanged: (String value) {},
                controller: motivationQuoteController,
                hintText: 'Enter Your Motivation Quote',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please Enter Motivation Quote';
                  }
                  return null;
                }
              ),
              const Spacer(),
              CustomButton(onPressed: () async{
                if(formKey.currentState!.validate()) {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('name', userNameController.value.text);
                  await prefs.setString('motivation_quote', motivationQuoteController.value.text);
                  Navigator.pop(context, true);
                }
              }, title: 'Save Changes'),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
