import 'package:cafe_oasis_web/screens/user_screens/login_screen.dart';
import 'package:cafe_oasis_web/screens/user_screens/second_signup_screen.dart';
import 'package:cafe_oasis_web/util/services/api_user.dart';
import 'package:cafe_oasis_web/util/services/change_screen.dart';
import 'package:cafe_oasis_web/widgets/consent_dialog.dart';
import 'package:cafe_oasis_web/widgets/toast.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isEmailSent = false;

  String _email = '';

  String _code = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image/oasis_logo.png',
                    width: 100,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "Cafe  Oasis",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 96,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff6ca3c9),
                      height: 116 / 96,
                    ),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
              const Divider(
                color: Color(0xffCCCCCC),
                thickness: 1,
              ),
              const SizedBox(
                height: 90,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: const Color(0xffCCCCCC),
                    )),
                width: 520,
                height: 540,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 90, right: 90),
                  child: Column(
                    children: [
                      const Text(
                        "회원가입",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000),
                          height: 48 / 40,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      loginField(
                        argText: '이메일',
                        hintText: '예) abc@gmail.com',
                        onSaved: (value) => _email = value!,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '이메일을 입력해주세요.';
                          }
                          if (!_isValidEmail(value)) {
                            return '올바른 이메일 형식을 입력해주세요.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      roundButton(
                        onTap: () async {
                          _formKey.currentState!.save();
                          isEmailSent = await ApiUser.emailSend(_email);

                          if (isEmailSent) {
                            consentDialog(
                                title: '성공',
                                content: '메일함을 확인해보세요',
                                context: context);
                          }
                          setState(() {});
                        },
                        inButtonText: '인증 코드 전송',
                        buttonColor: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      loginField(
                        argText: '인증 코드',
                        hintText: '6자리 인증 코드',
                        onSaved: (value) => _code = value!,
                        validator: (value) {
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      roundButton(
                        onTap: () async {
                          bool result = false;

                          _formKey.currentState!.save();
                          result = await ApiUser.emailVerify(_email, _code);

                          if (result) {
                            changeScreen(
                                context: context,
                                nextScreen: const SecondSignUpScreen(),
                                isReplace: true);
                            LoginScreen.user.email = _email;
                            toast(argText: '인증 성공');
                          } else {
                            toast(argText: '인증 실패');
                          }
                        },
                        inButtonText: '인증 코드 확인',
                        buttonColor: isEmailSent
                            ? Theme.of(context).primaryColor
                            : const Color(0xFF939393),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector roundButton({
    required void Function()? onTap,
    required String inButtonText,
    Color? buttonColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 520,
        height: 35,
        decoration: ShapeDecoration(
          color: buttonColor ?? const Color(0xFF939393),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Center(
            child: Text(
          inButtonText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Noto Sans KR',
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        )),
      ),
    );
  }

  Column loginField({
    required String argText,
    required String hintText,
    required FormFieldValidator<String> validator,
    required FormFieldSetter<String> onSaved,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          argText,
          style: const TextStyle(
            fontFamily: "Noto Sans KR",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xff000000),
            height: 21 / 16,
          ),
          textAlign: TextAlign.left,
        ),
        Container(
          width: 340,
          height: 50,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFFAEAEAE)),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              onSaved: onSaved,
              validator: validator,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool _isValidEmail(String email) {
    final RegExp regex =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
    return regex.hasMatch(email);
  }
}
