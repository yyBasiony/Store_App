import 'package:flutter/material.dart';
import '../presentation/welcome_screen.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'image': 'assets/onbord1.png',
      'title': 'استمتع بتسوق سلس',
      'description':
          'تسوق بسهولة واستمتع بتجربة تسوق مريحة في أي وقت وأي مكان، مع آلاف المنتجات المتاحة لك!'
    },
    {
      'image': 'assets/onbord2.png',
      'title': 'تسوق من هاتفك',
      'description':
          'اكتشف أحدث المنتجات والعروض الحصرية في متجرنا. اطلب كل ما تحتاجه بضغطة زر من هاتفك!'
    },
    {
      'image': 'assets/onbord3.png',
      'title': 'توصيل سريع وموثوق',
      'description':
          'استلم طلباتك بسرعة مع خيارات توصيل مرنة تناسب جدولك الزمني!'
    },
  ];

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _onboardingData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            _onboardingData[index]['image']!,
                            height: 250,
                          ),
                          const SizedBox(height: 30),
                          Text(
                            _onboardingData[index]['title']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 15),
                          Text(
                            _onboardingData[index]['description']!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff6c7376),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _onboardingData.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 10,
                    width: _currentPage == index ? 25 : 10,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? const Color(0xFF005B50)
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                );
              },
              child: const Text(
                'تخطي',
                style: TextStyle(
                  color: Color(0xFF005B50),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 20,
            child: FloatingActionButton(
              onPressed: _nextPage,
              backgroundColor: const Color(0xFF005B50),
              shape: const CircleBorder(),
              child: const Icon(Icons.arrow_forward, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
