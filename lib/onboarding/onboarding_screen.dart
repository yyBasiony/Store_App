import 'package:flutter/material.dart';
import 'package:store_app_api/presentation/resources/app_constants.dart';
import '../presentation/welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  void _nextPage() {
    if (_currentPage < AppConstants.onboardingData.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Column(children: [
        Expanded(
            child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: AppConstants.onboardingData.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppConstants.onboardingData[index]['image']!,
                              height: 250,
                            ),
                            const SizedBox(height: 30),
                            Text(
                              AppConstants.onboardingData[index]['title']!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              AppConstants.onboardingData[index]
                                  ['description']!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xff6c7376),
                              ),
                              textAlign: TextAlign.center,
                            )
                          ]));
                })),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                AppConstants.onboardingData.length,
                (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 10,
                    width: _currentPage == index ? 25 : 10,
                    decoration: BoxDecoration(
                        color: _currentPage == index
                            ? const Color(0xFF005B50)
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(5))))),
        const SizedBox(height: 60)
      ]),
      Positioned(
          top: 40,
          right: 20,
          child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()));
              },
              child: const Text('تخطي',
                  style: TextStyle(
                    color: Color(0xFF005B50),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )))),
      Positioned(
          bottom: 30,
          right: 20,
          child: FloatingActionButton(
              onPressed: _nextPage,
              backgroundColor: const Color(0xFF005B50),
              shape: const CircleBorder(),
              child: const Icon(Icons.arrow_forward_ios, color: Colors.white)))
    ]));
  }
}
