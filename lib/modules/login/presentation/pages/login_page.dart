import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/core/app_colors.dart';
import 'package:flutter_dev_test/core/app_sizes.dart';
import 'package:flutter_dev_test/modules/login/presentation/cubits/login_cubit.dart';
import 'package:flutter_dev_test/modules/login/presentation/cubits/login_state.dart';
import 'package:flutter_dev_test/widget/default_button.dart';
import 'package:flutter_dev_test/widget/default_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginCubit cubit;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<LoginCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.pushReplacementNamed(context, '/home');
        }
        if (state is LoginNavigateRecoverSecretState) {
          Navigator.pushNamed(context, '/recover_secret');
        } else if (state is LoginErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
          );
        }
      },
      child: BlocBuilder(
        bloc: cubit,
        builder: (context, state) {
          if (state is LoginLoadingState) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.all(AppSizes.marginMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: AppSizes.marginBig * 2,
                  ),
                  Container(
                    child: Image.asset(
                      'assets/images/greek_statue.png',
                      height: MediaQuery.of(context).size.height / 3.5,
                    ),
                  ),
                  const SizedBox(
                    height: AppSizes.marginMedium,
                  ),
                  DefaultTextField(
                    hint: 'E-mail',
                    controller: emailController,
                    onChanged: cubit.setUserName,
                  ),
                  const SizedBox(height: AppSizes.marginSmall),
                  DefaultTextField(
                    hint: 'Senha',
                    controller: passwordController,
                    onChanged: cubit.setPassword,
                  ),
                  const SizedBox(height: AppSizes.marginMedium),
                  DefaultButton(
                      label: 'Entrar',
                      isEnable:
                          state is LoginInitialState && state.isButtonEnable,
                      onTap: () {
                        cubit.makeLogin();
                        emailController.clear();
                        passwordController.clear();
                      }),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/recover_secret');
                    },
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          child: Center(
                            child: Text(
                              'Esqueci a senha',
                              style: TextStyle(color: AppColors.brown),
                            ),
                          ),
                        )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
