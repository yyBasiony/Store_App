import 'package:flutter/material.dart';

import '../resources/app_constants.dart';
import '../resources/app_routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final _pageController = PageController();

  void _nextPage() {
    if (_currentPage < AppConstants.onboardingData.length - 1) {
      _pageController.animateToPage(++_currentPage, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.welcomeScreen);
    }
  }

  @override
  void dispose() => {_pageController.dispose(), super.dispose()};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(children: [_buildBody(), const SizedBox(height: 60), _buildNextButton()]),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        TextButton(
          child: const Text('تخطي', style: TextStyle(fontSize: 16)),
          onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.welcomeScreen),
        )
      ],
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: AppConstants.onboardingData.length,
        itemBuilder: (_, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppConstants.onboardingData[index].image, height: 250),
              const SizedBox(height: 30),
              Text(
                textAlign: TextAlign.center,
                AppConstants.onboardingData[index].title,
                style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Text(
                textAlign: TextAlign.center,
                AppConstants.onboardingData[index].description,
                style: const TextStyle(fontSize: 14, color: Color(0xff6c7376)),
              ),
              const SizedBox(height: 60),
              Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(AppConstants.onboardingData.length, _buildDotIndicator),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDotIndicator(int index) {
    return Container(
      height: 10,
      width: _currentPage == index ? 25 : 10,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: _currentPage == index ? const Color(0xFF005B50) : Colors.grey,
      ),
    );
  }

  Widget _buildNextButton() {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: ElevatedButton(
        onPressed: _nextPage,
        style: const ButtonStyle(
          shape: WidgetStatePropertyAll(CircleBorder()),
          minimumSize: WidgetStatePropertyAll(Size.square(50)),
        ),
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
