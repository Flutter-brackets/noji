class PolicySection {
  final String number;
  final String title;
  final List<String> paragraphs;
  final List<String> bullets;

  const PolicySection({
    required this.number,
    required this.title,
    this.paragraphs = const <String>[],
    this.bullets = const <String>[],
  });
}
