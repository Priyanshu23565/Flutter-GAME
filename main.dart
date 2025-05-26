import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Enhanced Math App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          elevation: 5,
          titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      home: const MathHomePage(),
    );
  }
}

class MathHomePage extends StatefulWidget {
  const MathHomePage({super.key});
  @override
  State<MathHomePage> createState() => _MathHomePageState();
}

class _MathHomePageState extends State<MathHomePage> with TickerProviderStateMixin {
  String selectedOption = 'Multiplication Table';

  // Controllers
  final TextEditingController inputController = TextEditingController();
  final TextEditingController rangeController = TextEditingController();

  final TextEditingController percentValueController = TextEditingController();
  final TextEditingController totalValueController = TextEditingController();

  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();

  List<String> result = [];

  final List<String> options = [
    'Multiplication Table',
    'Additive Table',
    'Square',
    'Cube',
    'Root',
    'Percentage',
    'Arithmetic',
  ];

  // Animation controller for result switcher
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _animationController.dispose();
    inputController.dispose();
    rangeController.dispose();
    percentValueController.dispose();
    totalValueController.dispose();
    num1Controller.dispose();
    num2Controller.dispose();
    super.dispose();
  }

  void generate() {
    List<String> output = [];
    double num;
    int range;

    switch (selectedOption) {
      case 'Multiplication Table':
        num = double.tryParse(inputController.text) ?? 0;
        range = int.tryParse(rangeController.text) ?? 10;
        for (int i = 1; i <= range; i++) {
          output.add('$num × $i = ${num * i}');
        }
        break;

      case 'Additive Table':
        num = double.tryParse(inputController.text) ?? 0;
        range = int.tryParse(rangeController.text) ?? 10;
        double sum = 0;
        for (int i = 1; i <= range; i++) {
          sum += num;
          output.add(sum.toStringAsFixed(0));
        }
        break;

      case 'Square':
        num = double.tryParse(inputController.text) ?? 0;
        output.add('Square of $num = ${num * num}');
        break;

      case 'Cube':
        num = double.tryParse(inputController.text) ?? 0;
        output.add('Cube of $num = ${num * num * num}');
        break;

      case 'Root':
        num = double.tryParse(inputController.text) ?? 0;
        if (num < 0) {
          output.add('Root of negative number is not real');
        } else {
          output.add('√$num = ${sqrt(num).toStringAsFixed(3)}');
        }
        break;

      case 'Percentage':
        double total = double.tryParse(totalValueController.text) ?? 0;
        double percent = double.tryParse(percentValueController.text) ?? 0;
        double res = (total * percent) / 100;
        output.add('$percent% of $total = ${res.toStringAsFixed(3)}');
        break;

      case 'Arithmetic':
        output.add('Enter numbers and press operation button');
        break;
    }

    _animationController.forward(from: 0);
    setState(() {
      result = output;
    });
  }

  // Arithmetic Operations
  void doAddition() {
    double a = double.tryParse(num1Controller.text) ?? 0;
    double b = double.tryParse(num2Controller.text) ?? 0;
    setState(() {
      result = ['Addition: $a + $b = ${a + b}'];
    });
  }

  void doSubtraction() {
    double a = double.tryParse(num1Controller.text) ?? 0;
    double b = double.tryParse(num2Controller.text) ?? 0;
    setState(() {
      result = ['Subtraction: $a - $b = ${a - b}'];
    });
  }

  void doMultiplication() {
    double a = double.tryParse(num1Controller.text) ?? 0;
    double b = double.tryParse(num2Controller.text) ?? 0;
    setState(() {
      result = ['Multiplication: $a × $b = ${a * b}'];
    });
  }

  void doDivision() {
    double a = double.tryParse(num1Controller.text) ?? 0;
    double b = double.tryParse(num2Controller.text) ?? 0;
    setState(() {
      if (b == 0) {
        result = ['Division by zero not allowed!'];
      } else {
        result = ['Division: $a ÷ $b = ${(a / b).toStringAsFixed(3)}'];
      }
    });
  }

  Widget buildInputFields() {
    switch (selectedOption) {
      case 'Multiplication Table':
      case 'Additive Table':
        return Column(
          children: [
            TextField(
              controller: inputController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calculate),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: rangeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter range',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.format_list_numbered),
              ),
            ),
          ],
        );

      case 'Square':
      case 'Cube':
      case 'Root':
        return TextField(
          controller: inputController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Enter number',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.numbers),
          ),
        );

      case 'Percentage':
        return Column(
          children: [
            TextField(
              controller: totalValueController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter total value',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.stacked_line_chart),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: percentValueController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter percentage (%)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.percent),
              ),
            ),
          ],
        );

      case 'Arithmetic':
        return Column(
          children: [
            TextField(
              controller: num1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'First number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.looks_one),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: num2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Second number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.looks_two),
              ),
            ),
          ],
        );

      default:
        return Container();
    }
  }

  Widget buildArithmeticButtons() {
    if (selectedOption != 'Arithmetic') return Container();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Wrap(
        spacing: 15,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Add'),
            onPressed: doAddition,
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.remove),
            label: const Text('Subtract'),
            onPressed: doSubtraction,
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.clear),
            label: const Text('Multiply'),
            onPressed: doMultiplication,
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.horizontal_rule),
            label: const Text('Divide'),
            onPressed: doDivision,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enhanced Math App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Dropdown with nicer style
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.deepPurple[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.deepPurple, width: 1.5),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedOption,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.deepPurple),
                  items: options.map((String val) {
                    return DropdownMenuItem(
                      value: val,
                      child: Text(val, style: const TextStyle(fontWeight: FontWeight.w600)),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedOption = val!;
                      inputController.clear();
                      rangeController.clear();
                      percentValueController.clear();
                      totalValueController.clear();
                      num1Controller.clear();
                      num2Controller.clear();
                      result.clear();
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Input fields
            buildInputFields(),

            const SizedBox(height: 20),

            // Arithmetic buttons or generate button
            selectedOption == 'Arithmetic'
                ? buildArithmeticButtons()
                : ElevatedButton.icon(
              icon: const Icon(Icons.play_arrow),
              label: const Text('Generate'),
              onPressed: generate,
            ),

            const SizedBox(height: 30),

            // Animated result display
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: result.isEmpty
                    ? Center(
                  key: const ValueKey('empty'),
                  child: Text(
                    'Result will be shown here',
                    style: TextStyle(color: Colors.grey[500], fontSize: 18),
                  ),
                )
                    : ListView.builder(
                  key: ValueKey(result.join()),
                  itemCount: result.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[50],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurple.withOpacity(0.15),
                            blurRadius: 6,
                            offset: const Offset(2, 2),
                          )
                        ],
                      ),
                      child: Text(
                        result[index],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.deepPurple,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
