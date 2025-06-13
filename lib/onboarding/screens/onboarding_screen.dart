import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/onboarding_provider.dart';
import '../widgets/onboarding_page.dart';

class OnboardingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OnboardingProvider>(
        builder: (context, onboardingProvider, child) {
          return Stack(
            children: [
              PageView.builder(
                controller: onboardingProvider.controller,
                itemCount: onboardingProvider.pages.length,
                onPageChanged: onboardingProvider.updatePage,
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    data: onboardingProvider.pages[index],
                    currentPage: onboardingProvider.currentPage,
                    totalPages: onboardingProvider.pages.length,
                    onNext: () => onboardingProvider.nextPage(context),
                    onSkip: onboardingProvider.skipToEnd,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

