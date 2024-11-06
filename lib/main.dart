import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = '0';
  double firstNum = 0;
  double secondNum = 0;
  String operation = '';

  TextEditingController firstNumController = TextEditingController();
  TextEditingController secondNumController = TextEditingController();

  void calculateResult() {
    setState(() {
      if (firstNumController.text.isEmpty || secondNumController.text.isEmpty) {
        displayText = 'Enter both numbers';
        return;
      }

      firstNum = double.parse(firstNumController.text);
      secondNum = double.parse(secondNumController.text);

      switch (operation) {
        case '+':
          displayText = (firstNum + secondNum).toString();
          break;
        case '-':
          displayText = (firstNum - secondNum).toString();
          break;
        case '×':
          displayText = (firstNum * secondNum).toString();
          break;
        case '÷':
          displayText =
              secondNum != 0 ? (firstNum / secondNum).toString() : 'Error';
          break;
        default:
          displayText = 'Select an operation';
      }
    });
  }

  void clearInput() {
    setState(() {
      firstNumController.clear();
      secondNumController.clear();
      displayText = '0';
      firstNum = 0;
      secondNum = 0;
      operation = '';
    });
  }

  Widget buildOperationButton(Icon icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: IconButton(
        icon: icon,
        onPressed: () {
          setState(() {
            operation = icon.icon.toString();
            if (icon.icon == Icons.add) operation = '+';
            if (icon.icon == Icons.remove) operation = '-';
            if (icon.icon == Icons.close) operation = '×';
            if (icon.icon == Icons.show_chart) operation = '÷';
          });
        },
        iconSize: 40,
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              child: Text(
                displayText,
                style:
                    const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  child: Column(
                    children: [
                      TextField(
                        controller: firstNumController,
                        decoration: const InputDecoration(
                          labelText: "Enter first number",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 50),
                      TextField(
                        controller: secondNumController,
                        decoration: const InputDecoration(
                          labelText: "Enter second number",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    buildOperationButton(
                        const Icon(Icons.add), Colors.orangeAccent),
                    buildOperationButton(
                        const Icon(Icons.remove), Colors.blueAccent),
                    buildOperationButton(
                        const Icon(Icons.close), Colors.greenAccent),
                    buildOperationButton(
                        const Icon(Icons.show_chart), Colors.redAccent),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateResult,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 50.0),
                backgroundColor: const Color.fromARGB(255, 187, 148, 255),
              ),
              child: const Text(
                "=",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: clearInput,
              style: TextButton.styleFrom(
                foregroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 50.0),
              ),
              child: const Text(
                "Clear",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
