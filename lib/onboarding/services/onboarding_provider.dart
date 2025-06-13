import 'package:flutter/material.dart';
import '../../authentication/screens/phone_auth_page.dart';

class OnboardingProvider extends ChangeNotifier {
  final PageController controller = PageController();
  int currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      "image": "assets/animations/slide_jobs.json",
      "title": "Find Global Jobs",
      "subtitle":
          "Explore exciting job opportunities across the world. Build your international career with just a few taps.",
      "icon": "assets/onboarding/icons/icon1.png",
      "button": "Next",
    },
    {
      "image": "assets/animations/slide_jobs2.json",
      "title": "Hassle-Free Applications",
      "subtitle":
          "Apply to your dream job abroad with ease. One profile, multiple applications, all streamlined for your success.",
      "icon": "assets/onboarding/icons/icon2.png",
      "button": "Next",
    },
    {
      "image": "assets/animations/meeting.json",
      "title": "Connect Globally",
      "subtitle":
          "Join interviews, chat with recruiters, and land your next role—no matter where you are in the world.",
      "icon": "assets/onboarding/icons/icon3.png",
      "button": "Get Started",
    },
  ];

  void nextPage(BuildContext context) {
    if (currentPage < pages.length - 1) {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PhoneAuthPage()),
      );
    }
  }

  void updatePage(int index) {
    currentPage = index;
    notifyListeners();
  }

  void skipToEnd() {
    controller.jumpToPage(pages.length - 1);
  }
}