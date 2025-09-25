import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/widgets/custom_text_field.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class ContactWidget extends StatefulWidget {
  const ContactWidget({super.key});

  @override
  State<ContactWidget> createState() => _ContactWidgetState();
}

class _ContactWidgetState extends State<ContactWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 800;

  Future<void> _sendEmail() async {
    if (_formKey.currentState!.validate()) {
      final serviceId = "service_xxn5c2i"; // 👈 حط الـ Service ID هنا
      final templateId = "template_214uzc8"; // 👈 حط الـ Template ID هنا
      final publicKey = "6vozV6SYRUcSk72ie"; // 👈 حط الـ Public Key هنا

      final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
      final response = await http.post(
        url,
        headers: {
          "origin": "http://localhost",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "service_id": serviceId,
          "template_id": templateId,
          "user_id": publicKey,
          "template_params": {
            "user_name": _nameController.text,
            "user_email": _emailController.text,
            "user_message": _messageController.text,
          },
        }),
      );

      if (response.statusCode == 200) {
        log("Email sent successfully!");
        showDialog(
          context: context,
          builder: (context) {
            final isMobile = MediaQuery.of(context).size.width < 600;
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: CustomColor.bgLight1,
              contentPadding: const EdgeInsets.all(24),
              content: SizedBox(
                width: isMobile ? double.maxFinite : 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: CustomColor.yellowPrimary,
                      size: isMobile ? 48 : 64,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Message sent successfully!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 18 : 22,
                        fontWeight: FontWeight.bold,
                        color: CustomColor.whitePrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Thank you for reaching out. I'll get back to you soon.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        color: CustomColor.whitePrimary.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColor.yellowPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          "Close",
                          style: TextStyle(
                            color: CustomColor.scaffoldBg,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        log("Failed to send email: ${response.body}");
        showDialog(
          context: context,
          builder: (context) {
            final isMobile = MediaQuery.of(context).size.width < 600;
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: CustomColor.bgLight1,
              contentPadding: const EdgeInsets.all(24),
              content: SizedBox(
                width: isMobile ? double.maxFinite : 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.redAccent,
                      size: isMobile ? 48 : 64,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Failed to send message!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 18 : 22,
                        fontWeight: FontWeight.bold,
                        color: CustomColor.whitePrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Please try again later or check your internet connection.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        color: CustomColor.whitePrimary.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          "Close",
                          style: TextStyle(
                            color: CustomColor.scaffoldBg,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    }
  }

  Widget _buildContactForm() {
    final mobile = isMobile(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          mobile
              ? Column(
                  children: [
                    CustomTextField(
                      hintText: "Your Name",
                      controller: _nameController,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      hintText: "Your Email",
                      controller: _emailController,
                    ),
                  ],
                )
              : Row(
                  children: [
                    Flexible(
                      child: CustomTextField(
                        hintText: "Your Name",
                        controller: _nameController,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: CustomTextField(
                        hintText: "Your Email",
                        controller: _emailController,
                      ),
                    ),
                  ],
                ),
          const SizedBox(height: 20),
          CustomTextField(
            hintText: "Your Message",
            maxLines: 15,
            controller: _messageController,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: _sendEmail,
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColor.yellowPrimary,
                padding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "GET IN TOUCH",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: CustomColor.whitePrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);

    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 60),
      color: CustomColor.bgLight1,
      child: Column(
        children: [
          Text(
            "Get In Touch",
            style: TextStyle(
              fontSize: mobile ? 24 : 32,
              color: CustomColor.whitePrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 50),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: mobile
                ? Column(
                    children: [
                      Image.asset(
                        "assets/images/portoflio_logo.png",
                        height: 200,
                      ),
                      const SizedBox(height: 40),
                      _buildContactForm(),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Flexible(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Center(
                            child: Image(
                              width: double.maxFinite,
                              image: AssetImage(
                                "assets/images/portoflio_logo.png",
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 50),
                      Flexible(flex: 2, child: _buildContactForm()),
                    ],
                  ),
          ),
          const SizedBox(height: 50),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: const Divider(),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 20,
            alignment: WrapAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  final uri = Uri.parse("https://github.com/AhmedRasmy1");
                  if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
                    log('Could not launch $uri');
                  }
                },
                child: Image.asset(
                  "assets/images/github_icon.png",
                  height: 20,
                  width: 20,
                  color: CustomColor.whitePrimary,
                ),
              ),
              InkWell(
                onTap: () async {
                  final uri = Uri.parse(
                    "https://www.linkedin.com/in/ahmed-rasmy-340680236/",
                  );
                  if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
                    log('Could not launch $uri');
                  }
                },
                child: Image.asset(
                  "assets/images/linkedin_logo.png",
                  height: 20,
                  width: 20,
                ),
              ),
              InkWell(
                onTap: () async {
                  final uri = Uri.parse(
                    "https://www.instagram.com/ahmedhishammido?igsh=NmRtampnYm15emVl&utm_source=qr",
                  );
                  if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
                    log('Could not launch $uri');
                  }
                },
                child: Image.asset(
                  "assets/images/instagram_logo.png",
                  height: 20,
                  width: 20,
                  color: CustomColor.whitePrimary,
                ),
              ),
              InkWell(
                onTap: () async {
                  final uri = Uri.parse("https://t.me/Midorasmy");
                  if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
                    log('Could not launch $uri');
                  }
                },
                child: Image.asset(
                  "assets/images/telegram_logo.png",
                  height: 20,
                  width: 20,
                ),
              ),
              InkWell(
                onTap: () async {
                  final uri = Uri.parse(
                    "https://www.facebook.com/share/1GSPZ6TZww/?mibextid=wwXIfr",
                  );
                  if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
                    log('Could not launch $uri');
                  }
                },
                child: Image.asset(
                  "assets/images/facebook_logo.png",
                  height: 20,
                  width: 20,
                ),
              ),
              InkWell(
                onTap: () async {
                  final uri = Uri.parse(
                    "https://x.com/ahmedhishamrsmy?s=21&t=YZr6AgTbJ7LlmzcKqdlgFQ",
                  );
                  if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
                    log('Could not launch $uri');
                  }
                },
                child: Image.asset(
                  "assets/images/x_logo.png",
                  height: 20,
                  width: 20,
                  color: CustomColor.whitePrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
