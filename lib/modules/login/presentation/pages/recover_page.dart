import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/core/app_colors.dart';
import 'package:flutter_dev_test/core/app_sizes.dart';
import 'package:flutter_dev_test/modules/login/presentation/cubits/login_cubit.dart';
import 'package:flutter_dev_test/modules/login/presentation/cubits/recover_cubit.dart';
import 'package:flutter_dev_test/modules/login/presentation/cubits/recover_state.dart';
import 'package:flutter_dev_test/widget/default_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class RecoverPage extends StatefulWidget {
  const RecoverPage({super.key});

  @override
  State<RecoverPage> createState() => _RecoverPageState();
}

class _RecoverPageState extends State<RecoverPage> {
  late final RecoverCubit cubit;

  @override
  void initState() {
    super.initState();

    cubit = BlocProvider.of<RecoverCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecoverCubit, RecoverState>(
      listener: (context, state) {
        if (state is RecoverErrorState) {
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
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.chevron_left,
                      color: AppColors.brown,
                    )),
              ),
              body: Padding(
                padding: EdgeInsets.all(AppSizes.marginMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Verificação',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text('Insira o código que foi enviado:'),
                    SizedBox(height: AppSizes.marginBig * 2),
                    PinCodeTextField(
                      length: 6,
                      obscureText: false,
                      appContext: context,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.fade,
                      enableActiveFill: true,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: 50,
                        fieldWidth: 50,
                        activeFillColor: AppColors.textfieldBorderGrey,
                        inactiveFillColor: AppColors.textfieldBGGrey,
                        selectedFillColor: Colors.white,
                        activeColor: AppColors.lightBrown,
                        inactiveColor: AppColors.textfieldBorderGrey,
                        selectedColor: AppColors.brown,
                      ),
                      onChanged: cubit.setcode,
                      onCompleted: (value) {
                        print("PIN Completo: $value");
                      },
                    ),
                    SizedBox(height: AppSizes.marginBig),
                    DefaultButton(
                      label: 'Confirmar',
                      onTap: () => cubit.makeRecover(context),
                    ),
                    SizedBox(height: AppSizes.marginBig),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/vectors/message_question.svg'),
                        SizedBox(width: AppSizes.marginSmall),
                        Text('Não recebi o código')
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
