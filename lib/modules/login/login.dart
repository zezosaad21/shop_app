import 'package:flutter/material.dart';
import 'package:shop_app/modules/register/register_screen.dart';

class LoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('LOGIN',style: TextStyle(
                fontSize: 28.0,

              ),

              ),Text('Login now to browse our offers',style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,

              ),
              ),
              SizedBox(height: 30.0,),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (String value){
                  if(value.isEmpty){
                    return 'the email is not empty';
                  }
                  return '';
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email Address',

                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),SizedBox(height: 20.0,),
              TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                validator: (String value){
                  if(value.isEmpty){
                    return 'the password is not empty';
                  }else if(value.isNotEmpty && value.length<=4){
                    return 'password short must be 4 carchater';
                  }
                  return '';
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock_open_rounded),
                  suffixIcon: Icon(Icons.visibility_outlined)
                ),
              ),
              // ElevatedButton(
              //
              //   onPressed: (){},
              //
              //   child: Text('Login'),
              // ),
              SizedBox(height: 40.0,),
              Container(
                width: 400,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(child: Text('Login',style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),),),
              ),
              SizedBox(height: 20.0,),
              Row(
                children: [
                  Text('Dont have an account? ', style: TextStyle(
                    fontSize: 15.0
                  ),),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterScreen()),);
                    },
                    child: Text('REGISTER', style: TextStyle(
                        fontSize: 15.0,
                      decoration: TextDecoration.underline,
                      color: Colors.teal,
                    ),),
                  ),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
