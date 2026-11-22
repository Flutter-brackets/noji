import 'package:noji/features/privacy/data/policy_section.dart';
import 'package:noji/features/privacy/data/privacy_policy_content_2.dart';

abstract final class PrivacyPolicyContent {
  static const String lastUpdated = '22 نوفمبر 2026';
  static const String supportEmail = 'support@nojiksa.com';
  static const String supportPhone = '+966XXXXXXXXX';

  static const String intro =
      'نحن في «نوجي» نحترم خصوصيتكِ ونلتزم بحماية بياناتك الشخصية وفق نظام '
      'حماية البيانات الشخصية في المملكة العربية السعودية. توضح هذه السياسة ما '
      'نجمعه من معلومات، وكيف نستخدمها ونحميها عند استخدامكِ تطبيق نوجي '
      '(متجر عبايات إلكتروني).';

  static const List<PolicySection> sectionsPart1 = <PolicySection>[
    PolicySection(
      number: '٠١',
      title: 'المعلومات التي نجمعها',
      bullets: <String>[
        'بيانات الحساب: الاسم ورقم الجوال والبريد الإلكتروني.',
        'بيانات التوصيل: العنوان والمدينة ومعلومات الاستلام.',
        'بيانات الطلبات: المنتجات المشتراة وحالة الطلب وسجل المشتريات.',
        'بيانات الجهاز والاستخدام: نوع الجهاز ونظام التشغيل وطريقة تفاعلكِ مع التطبيق، لتحسين الأداء.',
      ],
    ),
    PolicySection(
      number: '٠٢',
      title: 'كيف نستخدم معلوماتك',
      bullets: <String>[
        'معالجة طلباتكِ وتوصيلها والتواصل معكِ بشأنها.',
        'إدارة حسابكِ وتسجيل الدخول.',
        'تحسين التطبيق وتجربة التسوق.',
        'إرسال عروض وإشعارات عند موافقتكِ، ويمكنكِ إيقافها في أي وقت.',
        'الالتزام بالمتطلبات النظامية.',
      ],
    ),
    PolicySection(
      number: '٠٣',
      title: 'المدفوعات',
      paragraphs: <String>[
        'تتم عمليات الدفع عبر بوابات دفع معتمدة وآمنة. لا يقوم «نوجي» بتخزين بيانات بطاقتكِ البنكية على خوادمه أو داخل التطبيق.',
      ],
    ),
    PolicySection(
      number: '٠٤',
      title: 'مشاركة المعلومات',
      paragraphs: <String>[
        'لا نبيع بياناتكِ الشخصية ولا نؤجرها. قد نشاركها فقط مع: منصة المتجر الإلكتروني (زد) لتشغيل المتجر والحساب والطلبات، وشركات الشحن لتوصيل طلباتكِ، وبوابات الدفع لإتمام الشراء، والجهات الرسمية عند وجود التزام نظامي.',
      ],
    ),
    PolicySection(
      number: '٠٥',
      title: 'أذونات التطبيق',
      bullets: <String>[
        'الكاميرا والصور: تُطلب فقط عند رغبتكِ برفع صورة داخل المتجر، ولا نصل إليها دون موافقتكِ.',
        'الإنترنت: ضروري لتشغيل التطبيق وتصفح المتجر.',
      ],
    ),
    PolicySection(
      number: '٠٦',
      title: 'ملفات تعريف الارتباط والتخزين',
      paragraphs: <String>[
        'نستخدم ملفات تعريف الارتباط والتخزين المحلي للحفاظ على تسجيل دخولكِ ومحتويات سلتكِ وتفضيلاتكِ.',
      ],
    ),
  ];

  static List<PolicySection> get allSections => <PolicySection>[
        ...sectionsPart1,
        ...PrivacyPolicyContent2.sectionsPart2,
      ];
}
