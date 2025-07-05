import 'package:flutter/material.dart';

void main() {
  runApp(BiodataApp());
}

class BiodataApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biodata Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BiodataForm(),
    );
  }
}

class BiodataForm extends StatefulWidget {
  @override
  _BiodataFormState createState() => _BiodataFormState();
}

class _BiodataFormState extends State<BiodataForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _addressController = TextEditingController();
  final _hobbyController = TextEditingController();

  List<String> hobbies = [];
  bool _showBiodata = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _addressController.dispose();
    _hobbyController.dispose();
    super.dispose();
  }

  void _addHobby() {
    if (_hobbyController.text.trim().isNotEmpty) {
      setState(() {
        hobbies.add(_hobbyController.text.trim());
        _hobbyController.clear();
      });
    }
  }

  void _removeHobby(int index) {
    setState(() {
      hobbies.removeAt(index);
    });
  }

  void _generateBiodata() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _showBiodata = true;
      });
    }
  }

  void _resetForm() {
    setState(() {
      _showBiodata = false;
      hobbies.clear();
      _nameController.clear();
      _phoneController.clear();
      _ageController.clear();
      _heightController.clear();
      _weightController.clear();
      _addressController.clear();
      _hobbyController.clear();
    });
  }

  double _calculateBMI() {
    if (_heightController.text.isEmpty || _weightController.text.isEmpty)
      return 0.0;
    try {
      double height =
          double.parse(_heightController.text) / 100; // Convert cm to m
      double weight = double.parse(_weightController.text);
      return weight / (height * height);
    } catch (e) {
      return 0.0;
    }
  }

  String _getBMICategory() {
    double bmi = _calculateBMI();
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal weight';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  Widget _buildInputForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Personal Information',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[700],
                              ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        String cleanPhone =
                            value.replaceAll(RegExp(r'[\s\-\(\)\+]'), '');
                        if (cleanPhone.length < 10 ||
                            !RegExp(r'^[0-9]+$').hasMatch(cleanPhone)) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _ageController,
                            decoration: InputDecoration(
                              labelText: 'Age',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.cake),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your age';
                              }
                              int? age = int.tryParse(value);
                              if (age == null || age < 1 || age > 120) {
                                return 'Please enter a valid age (1-120)';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _heightController,
                            decoration: InputDecoration(
                              labelText: 'Height (cm)',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.height),
                            ),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your height';
                              }
                              double? height = double.tryParse(value);
                              if (height == null ||
                                  height < 50 ||
                                  height > 300) {
                                return 'Please enter a valid height (50-300 cm)';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _weightController,
                      decoration: InputDecoration(
                        labelText: 'Weight (kg)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.monitor_weight),
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your weight';
                        }
                        double? weight = double.tryParse(value);
                        if (weight == null || weight < 20 || weight > 500) {
                          return 'Please enter a valid weight (20-500 kg)';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.home),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Hobbies',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _hobbyController,
                            decoration: InputDecoration(
                              labelText: 'Enter a hobby',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.sports_esports),
                            ),
                            onFieldSubmitted: (_) => _addHobby(),
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _addHobby,
                          child: Text('Add'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      child: Wrap(
                        spacing: 8.0,
                        children: hobbies.asMap().entries.map((entry) {
                          int index = entry.key;
                          String hobby = entry.value;
                          return Chip(
                            label: Text(hobby),
                            deleteIcon: Icon(Icons.close, size: 18),
                            onDeleted: () => _removeHobby(index),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _generateBiodata,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                '✨ Generate Biodata',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBiodata() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 6,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      '📄 BIODATA',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800],
                              ),
                    ),
                  ),
                  Divider(thickness: 2, color: Colors.blue[300]),
                  SizedBox(height: 16),
                  _buildInfoRow('Name', _nameController.text),
                  _buildInfoRow('Phone', _phoneController.text),
                  _buildInfoRow('Age', '${_ageController.text} years'),
                  _buildInfoRow('Height', '${_heightController.text} cm'),
                  _buildInfoRow('Weight', '${_weightController.text} kg'),
                  _buildInfoRow('Address', _addressController.text),
                  SizedBox(height: 16),
                  Text(
                    'Hobbies:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  if (hobbies.isEmpty)
                    Text('No hobbies listed',
                        style: TextStyle(color: Colors.grey))
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: hobbies.asMap().entries.map((entry) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Text('• ${entry.value}',
                              style: TextStyle(fontSize: 14)),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Card(
            elevation: 4,
            color: Colors.blue[50],
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Quick Stats',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                  SizedBox(height: 12),
                  _buildStatRow('BMI',
                      '${_calculateBMI().toStringAsFixed(1)} (${_getBMICategory()})'),
                  _buildStatRow('Number of hobbies', '${hobbies.length}'),
                  _buildStatRow(
                      'Generated on', DateTime.now().toString().split('.')[0]),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _resetForm,
                icon: Icon(Icons.refresh),
                label: Text('Create New'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _showBiodata = false;
                  });
                },
                icon: Icon(Icons.edit),
                label: Text('Edit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Text(': ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(color: Colors.blue[600])),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biodata Generator'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: _showBiodata ? _buildBiodata() : _buildInputForm(),
    );
  }
}
