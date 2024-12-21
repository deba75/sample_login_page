import 'package:flutter/material.dart';
import 'package:login_page/registration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate a login process
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });

        // Perform actual login logic (e.g., Firebase Auth or API call)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful')),
        );
      });
    }
  }

  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      
      body: Stack(
      
        children: <Widget>[
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/welcome-page.jpg', // Replace with your background image path
              fit: BoxFit.cover,
            ),
          ),
          // Transparent layer to dim the background (optional)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3), // Adjust opacity as needed
            ),
          ),
          // Login form on top of the background
          Center(
            
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          
                          controller: _emailController,
                          decoration: const InputDecoration(
                           
                            labelText: 'Email',

                            prefixIcon: Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login,
                      child: const Text('Login'),
                    ),
              const SizedBox(height: 12.0),
               
               Positioned(
                bottom: 20,
                left: MediaQuery.of(context).size.width * 0.25,
                right: MediaQuery.of(context).size.width * 0.25,
                child: FloatingActionButton.extended(
                  onPressed: (){
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=> const RegistrationPage()),
                    );
                  },
                   label: const Text("Don't Have an Account? Sign Up"))
               )

            ],
          ),
        ),),
      ),
      ],),);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
