import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/persistence/settings_persistence.dart';

class LoginPage extends StatefulWidget {
  const new({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = true;
  final formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  final _settingsPersistence = SettingsPersistence();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hasEditedCredentials = false;

  @override
  void initState() {
    super.initState();
    _loadSavedSettings();
  }

  Future<void> _loadSavedSettings() async {
    try {
      final settings = await _settingsPersistence.loadSettings();
      if (!mounted || _hasEditedCredentials) return;
      _usernameController.text = settings['username']!;
      _passwordController.text = settings['password']!;
    } on Exception catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Impossible de charger les identifiants : $error')),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        title: Image.asset('asset/logo_X.jpg', height: 30),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Entrez vos identifiants',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 20),

              TextFormField(
                controller: _usernameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez votre username';  
                  }
                  return null;
                },
                onSaved: (value) => username = value ?? '',
                onChanged: (_) => _hasEditedCredentials = true,
              ),

              SizedBox(height: 20),

              TextFormField(
                controller: _passwordController,
                obscureText: _isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),  
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez votre mot de passe';
                  }
                  if (value.length < 12) {
                    return 'Le mot de passe doit contenir au moins 12 caractères';
                  }
                  return null;
                },
                onSaved: (value) => password = value ?? '',
                onChanged: (_) => _hasEditedCredentials = true,
              ),

              Spacer(), // espacer en prenant tout l'espace disponible

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  
                ),
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      formKey.currentState?.save();
                      try {
                        await _settingsPersistence.saveSettings(
                          username,
                          password,
                        );
                      } on Exception catch (error) {
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Impossible d’enregistrer les identifiants : $error',
                            ),
                          ),
                        );
                        return;
                      }
                      if (!mounted) return;
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
                      // Handle login logic here
                    }
                      
                  },
                  child: const Text('Connexion'),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
