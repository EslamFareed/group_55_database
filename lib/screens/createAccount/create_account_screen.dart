import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_55_database/core/colors/app_color.dart';
import 'package:group_55_database/core/components/default_button.dart';
import 'package:group_55_database/core/components/default_text_field.dart';
import 'package:group_55_database/core/utils/show_message.dart';
import 'package:group_55_database/cubits/auth/auth_cubit.dart';
import 'package:group_55_database/screens/home/home_screen.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({super.key});

  final nameCtr = TextEditingController();
  final emailCtr = TextEditingController();
  final passCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 25),
              const Text(
                "Sign up with Email",
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
                  "Get chatting with friends and family today by signing up for our chat app!",
                  textAlign: TextAlign.center,
                ),
              ),
              DefaultTextField(
                controller: nameCtr,
                label: "Name",
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
                  if (state is ErrorCreateAccountState) {
                    ShowMessage.showSnMessage(
                        "Created Error,Please try again", context);
                  }
                  if (state is SuccessCreateAccountState) {
                    ShowMessage.showSnMessage("Created Success", context);
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
                  if (state is LoadingCreateAccountState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return DefaultButton(
                    label: "Create Account",
                    onPress: () {
                      AuthCubit.get(context).createAccount(
                          nameCtr.text, emailCtr.text, passCtr.text);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
