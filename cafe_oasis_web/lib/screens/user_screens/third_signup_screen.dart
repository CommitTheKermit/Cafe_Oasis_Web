import 'package:cafe_oasis_web/screens/user_screens/login_screen.dart';
import 'package:cafe_oasis_web/util/services/api_user.dart';
import 'package:cafe_oasis_web/widgets/consent_dialog.dart';
import 'package:flutter/material.dart';

class ThirdSignupScreen extends StatefulWidget {
  const ThirdSignupScreen({super.key});

  @override
  State<ThirdSignupScreen> createState() => _ThirdSignupScreenState();
}

class _ThirdSignupScreenState extends State<ThirdSignupScreen> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();

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
                        argText: '이름', hintText: '', argController: nameCtrl),
                    const SizedBox(
                      height: 10,
                    ),
                    loginField(
                      argText: '나이',
                      hintText: '숫자',
                      argController: ageCtrl,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    loginField(
                      argText: '전화번호',
                      hintText: '01012345678',
                      argController: phoneCtrl,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    roundButton(
                      onTap: () async {
                        if (nameCtrl.text.isNotEmpty &&
                            ageCtrl.text.isNotEmpty &&
                            phoneCtrl.text.isNotEmpty) {
                          LoginScreen.user.name = nameCtrl.text;
                          LoginScreen.user.age = ageCtrl.text;
                          LoginScreen.user.phoneNo = phoneCtrl.text;

                          ApiUser.signUp();

                          await consentDialog(
                              title: '반가워요!',
                              content: '회원가입이 완료되었습니다.',
                              context: context);

                          Navigator.pop(context);
                        }
                      },
                      inButtonText: '완료',
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
