import 'package:cafe_oasis_web/model/user_model.dart';
import 'package:cafe_oasis_web/screens/user_screens/login_screen.dart';
import 'package:cafe_oasis_web/screens/user_screens/third_signup_screen.dart';
import 'package:cafe_oasis_web/util/services/change_screen.dart';
import 'package:cafe_oasis_web/widgets/consent_dialog.dart';
import 'package:flutter/material.dart';

class SecondSignUpScreen extends StatefulWidget {
  const SecondSignUpScreen({super.key});

  @override
  State<SecondSignUpScreen> createState() => _SecondSignUpScreenState();
}

class _SecondSignUpScreenState extends State<SecondSignUpScreen> {
  final TextEditingController pwController = TextEditingController();
  final TextEditingController pwCheckController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                        argText: '비밀번호',
                        hintText: 'password',
                        argController: pwController),
                    const SizedBox(
                      height: 10,
                    ),
                    loginField(
                      argText: '비밀번호 확인',
                      hintText: 'password check',
                      argController: pwCheckController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    roundButton(
                      onTap: () {
                        if (pwController.text != pwCheckController.text) {
                          consentDialog(
                              title: '실패',
                              content: '입력값을 다시 확인해보세요',
                              context: context);
                          pwController.text = '';
                          pwCheckController.text = '';
                        } else {
                          LoginScreen.user.password = pwController.text;

                          changeScreen(
                            context: context,
                            nextScreen: const ThirdSignupScreen(),
                            isReplace: true,
                          );
                        }
                      },
                      inButtonText: '다음',
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
    );
  }

  GestureDetector roundButton({
    required Function() onTap,
    required String inButtonText,
    Color buttonColor = const Color(0xFF8FC1E4),
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 520,
        height: 35,
        decoration: ShapeDecoration(
          color: buttonColor,
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
    required TextEditingController argController,
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
              controller: argController,
              obscureText: true,
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
}
