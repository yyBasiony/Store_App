import 'package:flutter/material.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إرسال رسالتك بنجاح!')));

      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("اتصل بنا")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Card(
            elevation: 4,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'الاسم الكامل',
                          prefixIcon: Icon(Icons.person, color: Color(0xff005B50)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال اسمك الكامل';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'البريد الإلكتروني',
                          prefixIcon: Icon(Icons.email, color: Color(0xff005B50)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال بريدك الإلكتروني';
                          } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}").hasMatch(value)) {
                            return 'يرجى إدخال بريد إلكتروني صالح';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          labelText: 'الرسالة',
                          prefixIcon: Icon(Icons.message, color: Color(0xff005B50)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                        ),
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال رسالتك';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      FloatingActionButton(
                        onPressed: _submitForm,
                        backgroundColor: const Color(0xff005B50),
                        child: const Icon(Icons.send, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
