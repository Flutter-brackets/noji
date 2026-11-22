class OnboardingItem {
  final String overline;
  final String title;
  final String description;
  final String imagePath;

  const OnboardingItem({
    required this.overline,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  static const List<OnboardingItem> items = <OnboardingItem>[
    OnboardingItem(
      overline: 'نوجي',
      title: 'أناقة تُرتدى بثقة',
      description: 'عبايات مختارة بعناية، بتفاصيل تليق بكِ في كل مناسبة.',
      imagePath: 'assets/images/onboarding/slide_1.jpg',
    ),
    OnboardingItem(
      overline: 'تسوّقي بسهولة',
      title: 'تجربة سلسة من أول لمسة',
      description: 'تصفّحي، اختاري، واطلبي في دقائق من متجرك المفضل.',
      imagePath: 'assets/images/onboarding/slide_2.jpg',
    ),
    OnboardingItem(
      overline: 'نصلكِ أينما كنتِ',
      title: 'شحن سريع ودفع آمن',
      description: 'توصيل لجميع مناطق المملكة مع خيارات دفع موثوقة.',
      imagePath: 'assets/images/onboarding/slide_3.jpg',
    ),
  ];
}
