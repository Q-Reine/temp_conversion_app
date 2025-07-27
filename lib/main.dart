import 'package:flutter/material.dart';

void main() => runApp(TempConverterApp());

class TempConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF3F3FF),
        // Define a global theme for all input fields
        inputDecorationTheme: const InputDecorationTheme(
          // Style for the border when the input field is focused
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 6, 76, 20), // Active green color
              width: 2.0,
            ),
          ),
          // Style for the label (e.g., 'Celsius') when the field is focused
          floatingLabelStyle: TextStyle(
            color: Color.fromARGB(255, 6, 76, 20), // Active green color
          ),
        ),
      ),
      home: TempConverterAppPage(),
    );
  }
}

class TempConverterAppPage extends StatefulWidget {
  @override
  _TempConverterAppPageState createState() => _TempConverterAppPageState();
}

class _TempConverterAppPageState extends State<TempConverterAppPage> {
  final TextEditingController _tempController = TextEditingController();
  bool _isFahrenheitToCelsius = true;
  String _convertedTemp = "0.00";
  List<String> _conversionHistory = [];

  void _convertTemperature() {
    setState(() {
      if (_tempController.text.isEmpty) {
        return;
      }

      double inputTemp = double.tryParse(_tempController.text) ?? 0;
      double result;
      String historyEntry;

      if (_isFahrenheitToCelsius) {
        result = (inputTemp - 32) * 5 / 9;
        historyEntry =
            'F to C: $inputTemp°F => ${result.toStringAsFixed(2)}°C';
      } else {
        result = inputTemp * 9 / 5 + 32;
        historyEntry =
            'C to F: $inputTemp°C => ${result.toStringAsFixed(2)}°F';
      }

      _convertedTemp = result.toStringAsFixed(2);
      _conversionHistory.insert(0, historyEntry);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Converter',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 2, 86, 45),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildConverterPanel(),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildHistoryPanel(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConverterPanel() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Conversion:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              _buildConversionRadio(
                  title: 'Fahrenheit to Celsius', value: true),
              _buildConversionRadio(
                  title: 'Celsius to Fahrenheit', value: false),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _tempController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText:
                            _isFahrenheitToCelsius ? 'Fahrenheit' : 'Celsius',
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                    child: Text('=',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    child: _buildOutputField(),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _convertTemperature,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 1, 74, 11),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'CONVERT',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConversionRadio({required String title, required bool value}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      leading: Radio<bool>(
        value: value,
        groupValue: _isFahrenheitToCelsius,
        onChanged: (bool? newValue) {
          setState(() {
            _isFahrenheitToCelsius = newValue!;
            _tempController.clear();
            _convertedTemp = '0.00';
          });
        },
        activeColor: const Color.fromARGB(255, 6, 76, 20),
      ),
    );
  }

  Widget _buildOutputField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 9.5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _isFahrenheitToCelsius ? 'Celsius' : 'Fahrenheit',
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
          const SizedBox(height: 5),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: _convertedTemp,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: _isFahrenheitToCelsius ? ' °C' : ' °F',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryPanel() {
    return Container(
      height: 500,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Conversion History:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),
          Expanded(
            child: _conversionHistory.isEmpty
                ? const Center(
                    child: Text(
                      'No conversions yet',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _conversionHistory.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          _conversionHistory[index],
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}