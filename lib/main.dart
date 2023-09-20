import 'package:flutter/material.dart';

void main() => runApp(const BMICalculator());

class BMICalculator extends StatelessWidget {
  const BMICalculator({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        primaryColorDark: Color.fromARGB(255, 55, 162, 107),
        fontFamily: 'Roboto',
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('BMI Calculator'),
        ),
        body: BMIHomePage(),
      ),
    );
  }
}

class BMIHomePage extends StatefulWidget {
  @override
  _BMIHomePageState createState() => _BMIHomePageState();
}

class _BMIHomePageState extends State<BMIHomePage> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  String result = '';
  Color backgroundColor = Colors.white; // Background color for the animation
  double bmi = 0.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'BMI Calculator',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 20),
              buildTextField(heightController, 'Height (cm)'),
              SizedBox(height: 20),
              buildTextField(weightController, 'Weight (kg)'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: calculateBMIAndDisplayResult,
                child: Text('Calculate BMI'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColorDark,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
              Text(
                result,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to create a TextField widget with given controller and label
  Widget buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  // Function to calculate BMI and display the result
  void calculateBMIAndDisplayResult() {
    double height = double.parse(heightController.text);
    double weight = double.parse(weightController.text);
    bmi = calculateBMI(height, weight);
    setState(() {
      if (bmi < 18.5) {
        result =
            'Your BMI: ${bmi.toStringAsFixed(1)}\nYou are underweight. It might be a good idea to gain some weight.';
      } else if (bmi < 24.9) {
        result =
            'Your BMI: ${bmi.toStringAsFixed(1)}\nCongratulations! You have a normal BMI. Keep up the good work.';
      } else if (bmi < 29.9) {
        result =
            'Your BMI: ${bmi.toStringAsFixed(1)}\nYou are overweight. Consider maintaining a healthy diet and exercising regularly.';
      } else {
        result =
            'Your BMI: ${bmi.toStringAsFixed(1)}\nYou are obese. It is recommended to consult a healthcare professional for guidance.';
      }
      backgroundColor = getColorForBMI(bmi);
    });
  }

  // Function to calculate BMI based on height and weight
  double calculateBMI(double height, double weight) {
    double heightInMeters = height / 100;
    return weight / (heightInMeters * heightInMeters);
  }

  // Function to determine background color based on BMI
  Color getColorForBMI(double bmi) {
    if (bmi < 18.5) {
      return Colors.yellow;
    } else if (bmi < 24.9) {
      return Colors.green;
    } else if (bmi < 29.9) {
      return Color.fromARGB(255, 151, 183, 215);
    } else {
      return Colors.red;
    }
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }
}
