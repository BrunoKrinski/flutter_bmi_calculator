import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _result = 'Enter your data!';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();  
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();

  void _reset(){
    _weightController.text = "";
    _heightController.text = "";
    setState(() {
      _result = 'Enter your data!';
      _formKey = GlobalKey<FormState>();
    });
  }

  Padding _field(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter a value!';
          }
          return null;
        },
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.blueAccent,
          ),
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.blueAccent,
          fontSize: 25.0
        ),
      ),
    );
  }

  void _imc(){
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text) / 100;

    double imc = weight / (height * height);
    String result = "";

    if (imc  < 18.6) {
      result = "Under weight (${imc.toStringAsPrecision(2)})";
    } else if (imc >= 18.6 && imc < 24.9) {
      result = "Ideal weight (${imc.toStringAsPrecision(2)})";
    } else if (imc >= 24.9 && imc < 29.9) {
      result = "Slightly overweight (${imc.toStringAsPrecision(2)})";
    } else if (imc >= 29.9 && imc < 34.9) {
      result = "Obesity I (${imc.toStringAsPrecision(2)})";
    } else if (imc >= 34.9 && imc < 39.9) {
      result = "Obesity II (${imc.toStringAsPrecision(2)})";
    } else if (imc >= 39.9) {
      result = "Obesity III (${imc.toStringAsPrecision(2)})";
    }

    setState(() {
      _result = result;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BMI Calculator'),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh), 
              onPressed: _reset)
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _field('Height (cm)', _heightController),
                _field('Weight (kg)', _weightController),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                  child: Container(
                    height: 50.0,
                    child: ElevatedButton(
                      child: Text(
                        'Calculate',
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _imc();
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                      ),
                    ),
                  ),
                ),
                Text(
                  _result,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 30.0,
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}