import 'app_assets.dart';

class AppConstants {
  AppConstants._();
  static const List<Map<String, String>> onboardingData = [
    {
      'image': AppAssets.onboard1,
      'title': 'استمتع بتسوق سلس',
      'description':
          'تسوق بسهولة واستمتع بتجربة تسوق مريحة في أي وقت وأي مكان، مع آلاف المنتجات المتاحة لك!'
    },
    {
      'image': AppAssets.onboard2,
      'title': 'تسوق من هاتفك',
      'description':
          'اكتشف أحدث المنتجات والعروض الحصرية في متجرنا. اطلب كل ما تحتاجه بضغطة زر من هاتفك!'
    },
    {
      'image': AppAssets.onboard3,
      'title': 'توصيل سريع وموثوق',
      'description':
          'استلم طلباتك بسرعة مع خيارات توصيل مرنة تناسب جدولك الزمني!'
    },
  ];
}
