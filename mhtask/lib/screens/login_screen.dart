import 'package:flutter/material.dart';
import 'package:mhtask/class_users/users_login.dart';
import 'package:mhtask/screens/home_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool showPassword = false;
  IconData icon = Icons.lock;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool checkUser(String email, String password){
    bool foundUser = false;
    for (int i = 0; i < users.length; i++){
      if(email == users[i].email && password == users[i].password) {
        foundUser = true;
        break;
      }
}
    return foundUser;
  }

  @override
  Widget build(BuildContext context) {

    var height= MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;





    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey ,
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                    
               const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  'welcome',
                  style: TextStyle(
                    fontSize: 50,
                    
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                    
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'email is empty';
                    }

                  },
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'please enter your text',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                    
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'password is empty';
                    }
                    else if(value.length < 6){
                      return 'password too weak';

                    }

                  },
                  controller: passwordController,
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    hintText: 'please enter your password',
                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                        onPressed:(){
                 setState(() {
                   showPassword=!showPassword;
                   if(showPassword){
                     icon = Icons.remove_red_eye;
                   }
                   else {
                     icon = Icons.lock;
                   }
                 });
                        } ,
                        icon: Icon(icon),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    
                    
                    
                    
                    
                    
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: (){
                      if(formKey.currentState!.validate()){


                        if(checkUser(emailController.text, passwordController.text)) {
                          SnackBar snackBar = const SnackBar(
                            content: Text('login successfully'),
                            backgroundColor: Colors.green,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                  email: emailController
                                      .text), // Pass the email to home screen

                            ),
                          );
                        }
                        else{
                          SnackBar snackBar = const SnackBar(
                              content: Text('wrong'),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }


                         print('email is valid');
                      }
                      else
                      {
                        print('email is invalid');
                      }
                    },
                    child:  const Text('Login'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(width,height*0.06),
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                ),
                    
              ],
            ),
          ),
        ),
      ),

    );
  }
}
