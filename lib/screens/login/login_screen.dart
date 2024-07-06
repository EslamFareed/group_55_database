import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_55_database/core/colors/app_color.dart';
import 'package:group_55_database/core/components/default_button.dart';
import 'package:group_55_database/core/components/default_text_field.dart';
import 'package:group_55_database/core/utils/show_message.dart';
import 'package:group_55_database/cubits/auth/auth_cubit.dart';
import 'package:group_55_database/screens/createAccount/create_account_screen.dart';
import 'package:group_55_database/screens/home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailCtr = TextEditingController();
  final passCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              const Text(
                "Log in to Chatbox",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: const Text(
                  "Welcome back! Sign in using your social account or email to continue us",
                  textAlign: TextAlign.center,
                ),
              ),
              DefaultTextField(
                controller: emailCtr,
                label: "Email Address",
              ),
              DefaultTextField(
                controller: passCtr,
                label: "Password",
              ),
              const SizedBox(height: 25),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is ErrorLoginState) {
                    ShowMessage.showSnMessage(
                        "Login Error,Please try again", context);
                  }
                  if (state is SuccessLoginState) {
                    ShowMessage.showSnMessage("Login Success", context);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                      (route) => false,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LoadingLoginState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return DefaultButton(
                    label: "Log In",
                    onPress: () {
                      AuthCubit.get(context).login(emailCtr.text, passCtr.text);
                    },
                  );
                },
              ),
              const SizedBox(height: 25),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateAccountScreen(),
                      ));
                },
                child: const Text(
                  "Create new account",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
