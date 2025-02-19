import 'app_assets.dart';

class AppConstants {
  AppConstants._();

  static const List<OnboardingData> onboardingData = [
    (
      title: 'استمتع بتسوق سلس',
      image: AppAssets.onboarding1,
      description: '،تسوق بسهولة واستمتع بتجربة تسوق مريحة في أي وقت وأي مكان\n!مع آلاف المنتجات المتاحة لك'
    ),
    (
      title: 'تسوق من هاتفك',
      image: AppAssets.onboarding2,
      description: 'اكتشف أحدث المنتجات والعروض الحصرية في متجرنا\n!اطلب كل ما تحتاجه بضغطة زر من هاتفك'
    ),
    (title: 'توصيل سريع وموثوق', image: AppAssets.onboarding3, description: '!استلم طلباتك بسرعة مع خيارات توصيل مرنة تناسب جدولك الزمني')
  ];
}

typedef OnboardingData = ({String title, String image, String description});
