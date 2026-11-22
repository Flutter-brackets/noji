import 'package:flutter_test/flutter_test.dart';
import 'package:noji/core/constants/app_constants.dart';
import 'package:noji/core/services/cache_helper.dart';
import 'package:noji/features/splash/presentation/screens/splash_screen.dart';
import 'package:noji/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{
      AppConstants.onboardingCacheKey: false,
    });
    await CacheHelper.init();
  });

  testWidgets('App starts with SplashScreen and navigates to Onboarding',
      (WidgetTester tester) async {
    await tester.pumpWidget(const NojiApp());
    expect(find.byType(SplashScreen), findsOneWidget);

    // Advance past splash delay
    await tester.pump(const Duration(milliseconds: 2400));
    await tester.pumpAndSettle();

    // Verifies transition to onboarding slides
    expect(find.text('أناقة تُرتدى بثقة'), findsOneWidget);
  });
}
