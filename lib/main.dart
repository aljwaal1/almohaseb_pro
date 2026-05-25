import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const AccountantProApp());
}

class AccountantProApp extends StatelessWidget {
  const AccountantProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'المحاسب المحترف',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        fontFamily: 'Arial',
      ),
      home: const HomePage(),
    );
  }
}

class QuizQuestion {
  final String question;
  final List<String> answers;
  final int correct;

  const QuizQuestion({
    required this.question,
    required this.answers,
    required this.correct,
  });
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget homeButton(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Widget page,
  ) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Icon(icon, size: 38, color: Colors.teal),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> openSuggestionsEmail(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'FASTUNLOKED2017@GMAIL.COM',
      queryParameters: {
        'subject': 'اقتراح أو ملاحظة على تطبيق المحاسب المحترف',
        'body': 'السلام عليكم،\n\nلدي الاقتراح أو الملاحظة التالية:\n\n',
      },
    );

    final ok = await launchUrl(emailUri, mode: LaunchMode.externalApplication);

    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لم يتم فتح تطبيق البريد على الجهاز')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: const Text('المحاسب المحترف'),
          centerTitle: true,
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              const SizedBox(height: 12),
              const Icon(Icons.account_balance, size: 82, color: Colors.teal),
              const SizedBox(height: 10),
              const Text(
                'تطبيق تعليمي وأدوات محاسبية',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'تعلم المحاسبة، اختبر نفسك، واستخدم أدوات مساعدة',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 22),
              homeButton(
                context,
                'الأدوات المحاسبية',
                'حاسبات وأدوات تساعدك في العمليات المحاسبية',
                Icons.calculate,
                const ToolsPage(),
              ),
              homeButton(
                context,
                'الاختبارات',
                'اختبار تدريبي مع تصحيح فوري',
                Icons.quiz,
                const QuizPage(),
              ),
              homeButton(
                context,
                'مكتبة PDF',
                'ملخصات وملفات تعليمية',
                Icons.picture_as_pdf,
                const PdfPage(),
              ),
              Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 14),
                child: ListTile(
                  onTap: () => openSuggestionsEmail(context),
                  trailing: const Icon(Icons.feedback, color: Colors.teal, size: 34),
                  title: const Text(
                    'اقتراحات وملاحظات',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    'أرسل اقتراحك أو ملاحظتك',
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'مساحة إعلانية',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ComingSoonBox extends StatelessWidget {
  final String title;

  const ComingSoonBox({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange.shade50,
      child: ListTile(
        trailing: const Icon(Icons.lock_clock, color: Colors.orange),
        title: Text(
          title,
          textAlign: TextAlign.right,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text('قريبًا', textAlign: TextAlign.right),
      ),
    );
  }
}

class ToolsPage extends StatefulWidget {
  const ToolsPage({super.key});

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  final fixedCosts = TextEditingController();
  final sellingPrice = TextEditingController();
  final variableCost = TextEditingController();

  final assetCost = TextEditingController();
  final salvageValue = TextEditingController();
  final usefulLife = TextEditingController();

  String breakEvenResult = '';
  String depreciationResult = '';

  Widget numberInput(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void calculateBreakEven() {
    double fixed = double.tryParse(fixedCosts.text) ?? 0;
    double price = double.tryParse(sellingPrice.text) ?? 0;
    double variable = double.tryParse(variableCost.text) ?? 0;

    if (fixed <= 0 || price <= 0 || variable < 0) {
      setState(() => breakEvenResult = 'أدخل أرقام صحيحة');
      return;
    }

    if (price <= variable) {
      setState(() => breakEvenResult = 'سعر البيع يجب أن يكون أكبر من التكلفة المتغيرة');
      return;
    }

    double result = fixed / (price - variable);
    setState(() => breakEvenResult = 'نقطة التعادل = ${result.toStringAsFixed(2)} وحدة');
  }

  void calculateDepreciation() {
    double cost = double.tryParse(assetCost.text) ?? 0;
    double salvage = double.tryParse(salvageValue.text) ?? 0;
    double life = double.tryParse(usefulLife.text) ?? 0;

    if (cost <= 0 || life <= 0 || salvage < 0) {
      setState(() => depreciationResult = 'أدخل أرقام صحيحة');
      return;
    }

    double result = (cost - salvage) / life;
    setState(() => depreciationResult = 'الإهلاك السنوي = ${result.toStringAsFixed(2)}');
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 12),
      child: Text(
        title,
        textAlign: TextAlign.right,
        style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.teal),
      ),
    );
  }

  Widget resultBox(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(top: 8, bottom: 14),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text.isEmpty ? 'النتيجة تظهر هنا' : text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  void dispose() {
    fixedCosts.dispose();
    sellingPrice.dispose();
    variableCost.dispose();
    assetCost.dispose();
    salvageValue.dispose();
    usefulLife.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الأدوات المحاسبية'),
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            sectionTitle('حاسبة نقطة التعادل'),
            numberInput('التكاليف الثابتة', fixedCosts),
            numberInput('سعر البيع للوحدة', sellingPrice),
            numberInput('التكلفة المتغيرة للوحدة', variableCost),
            ElevatedButton(onPressed: calculateBreakEven, child: const Text('احسب نقطة التعادل')),
            resultBox(breakEvenResult),
            const Divider(height: 35),
            sectionTitle('حاسبة الإهلاك بالقسط الثابت'),
            numberInput('تكلفة الأصل', assetCost),
            numberInput('القيمة المتبقية', salvageValue),
            numberInput('العمر الإنتاجي بالسنوات', usefulLife),
            ElevatedButton(onPressed: calculateDepreciation, child: const Text('احسب الإهلاك')),
            resultBox(depreciationResult),
            const Divider(height: 35),
            const ComingSoonBox(title: 'حاسبة الضريبة'),
            const ComingSoonBox(title: 'حاسبة الرواتب'),
            const ComingSoonBox(title: 'حاسبة هامش الربح'),
            const ComingSoonBox(title: 'تحليل النسب المالية'),
          ],
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late List<QuizQuestion> examQuestions;
  int current = 0;
  int score = 0;
  bool answered = false;
  int? selectedAnswer;
  String feedback = '';

  @override
  void initState() {
    super.initState();
    startNewExam();
  }

  QuizQuestion shuffleAnswers(QuizQuestion question) {
    final combined = <Map<String, Object>>[];

    for (int i = 0; i < question.answers.length; i++) {
      combined.add({
        'text': question.answers[i],
        'correct': i == question.correct,
      });
    }

    combined.shuffle(Random());

    return QuizQuestion(
      question: question.question,
      answers: combined.map((e) => e['text'] as String).toList(),
      correct: combined.indexWhere((e) => e['correct'] == true),
    );
  }

  void startNewExam() {
    final all = List<QuizQuestion>.from(buildQuestionBank());
    all.shuffle(Random());

    examQuestions = all.take(10).map(shuffleAnswers).toList();

    current = 0;
    score = 0;
    answered = false;
    selectedAnswer = null;
    feedback = '';
  }

  void chooseAnswer(int index) {
    if (answered) return;

    final correct = examQuestions[current].correct;

    setState(() {
      answered = true;
      selectedAnswer = index;

      if (index == correct) {
        score++;
        feedback = 'إجابة صحيحة';
      } else {
        feedback = 'إجابة خاطئة — الصحيح: ${examQuestions[current].answers[correct]}';
      }
    });
  }

  void nextQuestion() {
    setState(() {
      if (current < examQuestions.length - 1) {
        current++;
        answered = false;
        selectedAnswer = null;
        feedback = '';
      } else {
        showResultDialog();
      }
    });
  }

  void showResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: const Text('نتيجة الاختبار'),
            content: Text('حصلت على $score من ${examQuestions.length}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    startNewExam();
                  });
                },
                child: const Text('اختبار جديد'),
              ),
            ],
          ),
        );
      },
    );
  }

  Color? buttonColor(int i) {
    if (!answered) return null;
    final correct = examQuestions[current].correct;
    if (i == correct) return Colors.green.shade100;
    if (i == selectedAnswer) return Colors.red.shade100;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final q = examQuestions[current];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الاختبارات'),
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              tooltip: 'اختبار جديد',
              onPressed: () {
                setState(() => startNewExam());
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'السؤال ${current + 1} من ${examQuestions.length}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              Text(
                q.question,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 22),
              ...List.generate(q.answers.length, (i) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: buttonColor(i)),
                    onPressed: () => chooseAnswer(i),
                    child: Text(q.answers[i], textAlign: TextAlign.center),
                  ),
                );
              }),
              const SizedBox(height: 14),
              Text(
                feedback,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: answered ? nextQuestion : null,
                child: Text(current == examQuestions.length - 1 ? 'عرض النتيجة' : 'السؤال التالي'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PdfPage extends StatelessWidget {
  const PdfPage({super.key});

  final List<String> pdfFiles = const [
    'ملخص معايير IFRS',
    'أساسيات المحاسبة المالية',
    'قيود يومية جاهزة',
    'ملخص محاسبة التكاليف',
    'مراجعة وتدقيق',
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('مكتبة PDF'),
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: pdfFiles.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                trailing: const Icon(Icons.picture_as_pdf, color: Colors.red, size: 34),
                title: Text(
                  pdfFiles[index],
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('قريبًا', textAlign: TextAlign.right),
              ),
            );
          },
        ),
      ),
    );
  }
}

List<QuizQuestion> buildQuestionBank() {
  return [
    q('ما الطرفان الأساسيان في القيد المحاسبي؟', 'مدين ودائن', 'أصل وخصم', 'إيراد ومصروف', 'نقد وبنك'),
    q('أين تظهر الأصول؟', 'الميزانية العمومية', 'قائمة الدخل', 'قائمة التدفقات النقدية', 'دفتر الأستاذ'),
    q('طبيعة المصروفات عادة تكون:', 'مدينة', 'دائنة', 'لا طبيعة لها', 'رأسمالية دائمًا'),
    q('طبيعة الإيرادات عادة تكون:', 'دائنة', 'مدينة', 'أصول', 'خصوم'),
    q('معادلة المحاسبة الأساسية هي:', 'الأصول = الخصوم + حقوق الملكية', 'الأصول = الإيرادات - المصروفات', 'الخصوم = الأصول + الإيرادات', 'المبيعات = الأرباح'),
    q('دفتر اليومية يستخدم لتسجيل:', 'العمليات حسب تاريخ حدوثها', 'الأصول فقط', 'الموظفين فقط', 'الضرائب فقط'),
    q('دفتر الأستاذ يستخدم من أجل:', 'ترحيل وتصنيف الحسابات', 'كتابة العقود', 'حفظ الصور', 'إدارة الرواتب فقط'),
    q('ميزان المراجعة يهدف إلى:', 'التحقق من تساوي المدين والدائن', 'حساب الضريبة فقط', 'إصدار الفواتير', 'فتح حساب بنكي'),
    q('قائمة الدخل تقيس:', 'الربح أو الخسارة', 'الأصول فقط', 'النقدية فقط', 'المخزون فقط'),
    q('الميزانية العمومية تعرض:', 'المركز المالي', 'نتيجة الأعمال فقط', 'المبيعات اليومية', 'عدد الموظفين'),
    q('قائمة التدفقات النقدية تبين:', 'حركة النقدية', 'عدد العملاء', 'المخزون فقط', 'الديون المعدومة فقط'),
    q('الأصل هو:', 'مورد تملكه المنشأة وتتوقع منه منفعة', 'دين على المنشأة فقط', 'مصروف شهري', 'إيراد مؤجل دائمًا'),
    q('الخصم هو:', 'التزام على المنشأة', 'مورد تملكه المنشأة', 'ربح صافي', 'مصروف مدفوع'),
    q('حقوق الملكية تمثل:', 'حق الملاك في صافي الأصول', 'ديون الموردين', 'مصروفات التشغيل', 'المخزون'),
    q('الإيراد هو:', 'زيادة في المنافع الاقتصادية', 'نقص في الأصول دائمًا', 'دين على الشركة', 'شراء أصل'),
    q('المصروف هو:', 'نقص في المنافع الاقتصادية', 'زيادة في حقوق الملكية دائمًا', 'إيراد مقدم', 'أصل ثابت'),
    q('صافي الربح يساوي:', 'الإيرادات - المصروفات', 'الأصول - الخصوم', 'النقدية - المخزون', 'رأس المال - الأصول'),
    q('إذا زادت الإيرادات عن المصروفات تكون النتيجة:', 'ربح', 'خسارة', 'خصم', 'أصل'),
    q('الإهلاك يطبق غالبًا على:', 'الأصول الثابتة', 'النقدية', 'الموردين', 'رأس المال'),
    q('القسط الثابت للإهلاك يحسب بـ:', 'تكلفة الأصل ناقص القيمة المتبقية ÷ العمر الإنتاجي', 'المبيعات ÷ المخزون', 'الأصول ÷ الخصوم', 'الربح ÷ رأس المال'),
    q('الأرض عادة:', 'لا تستهلك محاسبيًا', 'تستهلك دائمًا', 'تسجل كمصروف فورًا', 'تسجل كإيراد'),
    q('مجمع الإهلاك حساب طبيعته:', 'دائن', 'مدين', 'إيراد', 'مصروف نقدي'),
    q('مصروف الإهلاك يظهر في:', 'قائمة الدخل', 'كشف البنك', 'عقد الإيجار', 'دفتر الحضور'),
    q('شراء آلة للاستخدام الطويل يعتبر:', 'أصل ثابت', 'مصروف يومي', 'إيراد', 'خصم متداول'),
    q('الصيانة العادية للآلة غالبًا تعتبر:', 'مصروف', 'أصل ثابت جديد', 'إيراد', 'رأس مال'),
    q('القيمة الدفترية للأصل تساوي:', 'التكلفة - مجمع الإهلاك', 'الإيرادات - المصروفات', 'النقدية + البنك', 'الأصول + الخصوم'),
    q('العمر الإنتاجي هو:', 'مدة استفادة المنشأة من الأصل', 'مدة القرض فقط', 'فترة الضريبة فقط', 'عدد العملاء'),
    q('القيمة المتبقية هي:', 'القيمة المتوقعة للأصل في نهاية عمره', 'قيمة المبيعات', 'قيمة المصروفات', 'قيمة رأس المال'),
    q('نقطة التعادل هي مستوى تكون عنده:', 'الإيرادات تساوي التكاليف', 'الإيرادات صفر', 'التكاليف صفر', 'الأرباح أعلى ما يمكن'),
    q('هامش المساهمة للوحدة يساوي:', 'سعر البيع - التكلفة المتغيرة للوحدة', 'التكلفة الثابتة - السعر', 'الإيراد - الأصل', 'الأصول - الخصوم'),
    q('زيادة التكاليف الثابتة تؤدي غالبًا إلى:', 'زيادة نقطة التعادل', 'نقص نقطة التعادل', 'عدم التأثير دائمًا', 'إلغاء المبيعات'),
    q('زيادة سعر البيع مع ثبات التكاليف يؤدي إلى:', 'انخفاض نقطة التعادل', 'زيادة نقطة التعادل', 'عدم التأثير', 'زيادة الخصوم'),
    q('التكلفة المتغيرة تتغير مع:', 'حجم الإنتاج', 'اسم الشركة', 'تاريخ التأسيس', 'عدد الشركاء فقط'),
    q('الإيجار الشهري غالبًا يعتبر:', 'تكلفة ثابتة', 'تكلفة متغيرة', 'إيراد', 'أصل متداول'),
    q('عمولة المبيعات غالبًا تعتبر:', 'تكلفة متغيرة', 'تكلفة ثابتة', 'أصل ثابت', 'خصم طويل الأجل'),
    q('التكاليف المختلطة تحتوي على:', 'جزء ثابت وجزء متغير', 'إيراد فقط', 'أصل فقط', 'رأس مال فقط'),
    q('تحليل التعادل يساعد الإدارة في:', 'تحديد حجم المبيعات اللازم لتغطية التكاليف', 'اختيار لون الشعار', 'تعيين الموظفين فقط', 'كتابة العقود'),
    q('المخزون يظهر ضمن:', 'الأصول المتداولة', 'الخصوم طويلة الأجل', 'حقوق الملكية فقط', 'الإيرادات'),
    q('تكلفة البضاعة المباعة تظهر في:', 'قائمة الدخل', 'الميزانية فقط', 'كشف البنك فقط', 'قائمة الرواتب'),
    q('المشتريات الآجلة تؤدي إلى:', 'زيادة المخزون وزيادة الموردين', 'زيادة النقدية فقط', 'نقص الموردين', 'زيادة رأس المال'),
    q('الموردون يمثلون:', 'خصوم', 'أصول', 'إيرادات', 'مصروفات'),
    q('العملاء المدينون يمثلون:', 'أصول', 'خصوم', 'مصروفات', 'حقوق ملكية'),
    q('البيع الآجل يؤدي إلى زيادة:', 'العملاء', 'الموردين', 'القروض', 'المصروفات فقط'),
    q('تحصيل من عميل يؤدي إلى:', 'زيادة النقدية ونقص العملاء', 'زيادة العملاء', 'نقص النقدية', 'زيادة الموردين'),
    q('سداد لمورد يؤدي إلى:', 'نقص النقدية ونقص الموردين', 'زيادة الموردين', 'زيادة الإيراد', 'زيادة العملاء'),
    q('مردودات المبيعات تقلل:', 'صافي المبيعات', 'الأصول الثابتة', 'الموردين فقط', 'رأس المال مباشرة'),
    q('المصروف المدفوع مقدمًا يعتبر:', 'أصل', 'خصم', 'إيراد', 'ربح'),
    q('الإيراد المقبوض مقدمًا يعتبر:', 'خصم', 'أصل', 'مصروف', 'خسارة'),
    q('المصروف المستحق يعتبر:', 'خصم', 'أصل', 'إيراد', 'رأس مال'),
    q('الإيراد المستحق يعتبر:', 'أصل', 'خصم', 'مصروف', 'مخزون'),
    q('التسوية المحاسبية تتم عادة في:', 'نهاية الفترة المالية', 'بداية كل يوم فقط', 'عند تأسيس الشركة فقط', 'عند فتح البنك فقط'),
    q('الهدف من قيود التسوية هو:', 'تحميل الفترة بما يخصها من إيرادات ومصروفات', 'زيادة النقدية دائمًا', 'إلغاء الأصول', 'حذف الدفاتر'),
    q('مبدأ الاستحقاق يعني الاعتراف بالعمليات:', 'عند تحققها وليس فقط عند قبض أو دفع النقد', 'عند الدفع فقط', 'عند القبض فقط', 'في نهاية السنة فقط'),
    q('مبدأ المقابلة يربط بين:', 'الإيرادات والمصروفات المتعلقة بها', 'الأصول والموظفين', 'البنك والصندوق فقط', 'الضرائب والرواتب فقط'),
    q('النقدية في الصندوق تعتبر:', 'أصل متداول', 'خصم', 'إيراد', 'مصروف'),
    q('كشف حساب البنك يستخدم للمساعدة في:', 'تسوية البنك', 'حساب الإهلاك فقط', 'قياس المخزون فقط', 'حساب الرواتب فقط'),
    q('الإيداعات بالطريق تعني:', 'مبالغ أودعت ولم تظهر بعد في كشف البنك', 'ديون معدومة', 'إهلاك', 'رأس مال جديد'),
    q('الرقابة على النقدية تهدف إلى:', 'حماية النقدية من الأخطاء والاختلاس', 'زيادة الضرائب', 'إلغاء الفواتير', 'تغيير اسم المنشأة'),
    q('العهدة النثرية تستخدم للمصروفات:', 'الصغيرة', 'الرأسمالية الكبيرة فقط', 'الضرائب فقط', 'القروض فقط'),
    q('رأس المال يظهر ضمن:', 'حقوق الملكية', 'الأصول', 'المصروفات', 'الموردين'),
    q('المسحوبات الشخصية تقلل:', 'حقوق الملكية', 'الأصول الثابتة فقط', 'الإيرادات', 'الموردين'),
    q('زيادة رأس المال نقدًا تؤدي إلى:', 'زيادة النقدية وزيادة حقوق الملكية', 'نقص النقدية', 'زيادة المصروفات', 'نقص الأصول'),
    q('توزيع الأرباح على الملاك يؤدي إلى:', 'نقص حقوق الملكية', 'زيادة الإيرادات', 'زيادة الأصول دائمًا', 'إلغاء الخصوم'),
    q('الخسارة الصافية تؤدي إلى:', 'نقص حقوق الملكية', 'زيادة حقوق الملكية', 'زيادة الإيرادات', 'نقص المصروفات'),
    q('الأرباح المحتجزة تمثل:', 'أرباح لم توزع', 'ديون بنكية', 'مخزون تالف', 'مصروفات مقدمة'),
    q('القرض البنكي يمثل:', 'خصم', 'أصل', 'إيراد', 'مصروف'),
    q('فوائد القرض تعتبر:', 'مصروف فوائد', 'أصل ثابت', 'إيراد فوائد للمدين', 'رأس مال'),
    q('سداد جزء من القرض يؤدي إلى:', 'نقص النقدية ونقص الخصوم', 'زيادة الخصوم', 'زيادة الإيرادات', 'زيادة رأس المال'),
    q('القروض طويلة الأجل تصنف ضمن:', 'الخصوم غير المتداولة', 'الأصول المتداولة', 'الإيرادات', 'المصروفات'),
    q('الأجور المستحقة تعتبر:', 'خصم', 'أصل', 'إيراد', 'رأس مال'),
    q('الضرائب المستحقة تعتبر:', 'خصم', 'أصل', 'إيراد', 'مسحوبات'),
    q('الالتزامات المتداولة تستحق غالبًا خلال:', 'سنة أو دورة تشغيل', 'عشر سنوات فقط', 'لا تستحق أبدًا', 'يوم واحد دائمًا'),
    q('التدفقات التشغيلية ترتبط بـ:', 'نشاط التشغيل الأساسي', 'شراء الأسهم فقط', 'القروض فقط', 'شراء المباني فقط'),
    q('شراء آلة نقدًا يظهر غالبًا ضمن:', 'أنشطة استثمارية', 'أنشطة تشغيلية', 'أنشطة تمويلية فقط', 'لا يظهر'),
    q('الحصول على قرض نقدي يظهر ضمن:', 'أنشطة تمويلية', 'أنشطة تشغيلية', 'أنشطة استثمارية', 'مصروفات'),
    q('بيع أصل ثابت نقدًا يظهر ضمن:', 'أنشطة استثمارية', 'أنشطة تشغيلية فقط', 'حقوق ملكية', 'مخزون'),
    q('دفع رواتب نقدًا يظهر ضمن:', 'أنشطة تشغيلية', 'أنشطة استثمارية', 'أنشطة تمويلية', 'أصول ثابتة'),
    q('قائمة التدفقات تساعد في تقييم:', 'قدرة المنشأة على توليد النقد', 'لون الشعار', 'عدد الفروع فقط', 'أسماء الموردين فقط'),
    q('المراجعة تهدف بشكل عام إلى:', 'إبداء رأي حول القوائم المالية', 'إعداد الفواتير فقط', 'بيع المنتجات', 'تعيين الموظفين'),
    q('الاستقلالية مهمة للمراجع لأنها:', 'تعزز موضوعية الرأي', 'تزيد المبيعات', 'تقلل المخزون', 'تلغي الحاجة للدليل'),
    q('أدلة المراجعة يجب أن تكون:', 'كافية وملائمة', 'كثيرة فقط', 'شفوية فقط', 'قديمة دائمًا'),
    q('المخاطر الرقابية ترتبط بـ:', 'فشل الرقابة الداخلية في منع أو اكتشاف الأخطاء', 'سعر البيع', 'عدد المنتجات', 'رأس المال فقط'),
    q('الرقابة الداخلية الجيدة تساعد على:', 'تقليل الأخطاء والاحتيال', 'زيادة الأخطاء', 'إلغاء السجلات', 'منع المبيعات'),
    q('المصادقات الخارجية تستخدم غالبًا للتحقق من:', 'الأرصدة مثل العملاء والبنوك', 'لون المكتب', 'عدد الموظفين فقط', 'الإعلانات'),
    q('الجرد الفعلي للمخزون يساعد على التحقق من:', 'وجود المخزون', 'الإيرادات فقط', 'الرواتب فقط', 'رأس المال فقط'),
    q('الأهمية النسبية تعني:', 'حجم أو طبيعة الخطأ المؤثر على قرارات المستخدمين', 'عدد الصفحات فقط', 'اسم الشركة', 'تاريخ الفاتورة فقط'),
    q('تقرير المراجع يتضمن عادة:', 'رأي المراجع', 'قائمة الطعام', 'إعلانات الشركة', 'رواتب الموظفين بالتفصيل'),
    q('العينة في المراجعة تستخدم عندما:', 'يصعب فحص كل العمليات', 'لا توجد عمليات', 'كل العمليات خاطئة', 'لا توجد دفاتر'),
    q('المبيعات النقدية تزيد:', 'النقدية والإيرادات', 'الموردين والمصروفات', 'القروض فقط', 'الإهلاك فقط'),
    q('الشراء النقدي لبضاعة يؤدي إلى:', 'زيادة المخزون ونقص النقدية', 'زيادة الإيرادات', 'زيادة العملاء', 'نقص الموردين فقط'),
    q('الربح الإجمالي يساوي:', 'صافي المبيعات - تكلفة البضاعة المباعة', 'الأصول - الخصوم', 'النقدية - البنك', 'رأس المال - المسحوبات'),
    q('الخصم التجاري يسجل عادة:', 'بالصافي في الفاتورة', 'كقرض طويل الأجل', 'كمصروف إهلاك', 'كرأس مال'),
    q('الخصم النقدي يرتبط غالبًا بـ:', 'السداد المبكر', 'شراء أصل ثابت', 'إهلاك الأرض', 'زيادة رأس المال'),
    q('طريقة الوارد أولًا صادر أولًا تعرف باسم:', 'FIFO', 'LIFO', 'AVG', 'ROI'),
    q('طريقة المتوسط المرجح تستخدم في:', 'تقييم المخزون', 'حساب الرواتب فقط', 'تحديد الإيجار', 'تسوية البنك فقط'),
    q('الديون المعدومة تمثل:', 'مبالغ لا يتوقع تحصيلها من العملاء', 'أصول ثابتة جديدة', 'مبيعات نقدية', 'قروض جديدة'),
    q('مخصص الديون المشكوك فيها طبيعته:', 'دائن', 'مدين', 'إيراد', 'أصل نقدي'),
    q('المدينون يظهرون ضمن:', 'الأصول المتداولة', 'الخصوم المتداولة', 'حقوق الملكية', 'المصروفات'),
    q('الإيراد المؤجل يعني:', 'مبلغ قبض قبل تقديم الخدمة', 'مصروف نقدي', 'أصل ثابت', 'رأس مال جديد'),
    q('المصروف المستحق يعني:', 'مصروف يخص الفترة ولم يدفع بعد', 'إيراد تم قبضه', 'أصل تم بيعه', 'قرض تم سداده'),
    q('المخزون آخر المدة يؤثر على:', 'تكلفة البضاعة المباعة', 'رأس المال فقط', 'القروض فقط', 'الأصول الثابتة فقط'),
    q('زيادة مخزون آخر المدة تؤدي إلى:', 'نقص تكلفة البضاعة المباعة', 'زيادة تكلفة البضاعة المباعة', 'نقص الأصول', 'زيادة الخصوم'),
    q('المحاسبة المالية تهتم غالبًا بـ:', 'إعداد القوائم المالية للمستخدمين', 'تصميم الشعارات', 'الصيانة الفنية', 'التسويق فقط'),
    q('محاسبة التكاليف تساعد في:', 'قياس تكلفة المنتجات والخدمات', 'تصميم الموقع', 'توظيف العمال فقط', 'إدارة الإعلانات فقط'),
    q('الموازنة التقديرية هي:', 'خطة مالية مستقبلية', 'فاتورة شراء', 'كشف بنك فقط', 'قيد إقفال'),
    q('الانحراف في التكاليف يعني:', 'الفرق بين الفعلي والمخطط', 'زيادة الأصول فقط', 'نقص الخصوم فقط', 'فتح حساب جديد'),
    q('تكلفة المواد المباشرة تدخل في:', 'تكلفة الإنتاج', 'المصروفات الإدارية فقط', 'القروض', 'رأس المال'),
    q('الأجور المباشرة تعتبر:', 'تكلفة إنتاج', 'إيراد', 'خصم طويل الأجل', 'أصل نقدي'),
    q('التكاليف الصناعية غير المباشرة تشمل:', 'تكاليف إنتاج لا تنسب مباشرة لوحدة محددة', 'المبيعات فقط', 'القروض فقط', 'حقوق الملكية فقط'),
    q('هامش الربح يساوي غالبًا:', 'الربح ÷ المبيعات', 'الأصول ÷ الخصوم', 'النقدية ÷ البنك', 'المخزون ÷ العملاء'),
    q('نسبة التداول تقيس:', 'قدرة المنشأة على سداد الالتزامات قصيرة الأجل', 'ربحية السهم فقط', 'قيمة الأرض', 'عدد الفواتير'),
    q('نسبة الدين تقيس:', 'اعتماد المنشأة على التمويل بالديون', 'عدد العملاء', 'حجم المخزون فقط', 'عدد الموظفين'),
    q('العائد على الأصول يقيس:', 'كفاءة استخدام الأصول في تحقيق الربح', 'قيمة القرض فقط', 'عدد الموردين', 'الإعلانات'),
    q('إقفال الإيرادات يتم بنقلها إلى:', 'ملخص الدخل', 'الصندوق', 'المخزون', 'الموردين'),
    q('إقفال المصروفات يتم بنقلها إلى:', 'ملخص الدخل', 'العملاء', 'البنك فقط', 'الأصول الثابتة'),
  ];
}

QuizQuestion q(String question, String correct, String a2, String a3, String a4) {
  return QuizQuestion(
    question: question,
    answers: [correct, a2, a3, a4],
    correct: 0,
  );
}
