import 'package:cafe_oasis_web/model/user_model.dart';
import 'package:cafe_oasis_web/screens/main_screens/cafe_search_screen.dart';
import 'package:cafe_oasis_web/screens/user_screens/signup_screen.dart';
import 'package:cafe_oasis_web/util/services/change_screen.dart';
import 'package:cafe_oasis_web/widgets/consent_dialog.dart';
import 'package:cafe_oasis_web/util/services/api_user.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();

  static UserModel user = UserModel();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Center(
          child: Stack(
            children: [
              Column(
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
                    height: 450,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 50, left: 90, right: 90),
                      child: Column(
                        children: [
                          const Text(
                            "로그인",
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
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          loginField(
                            argText: '비밀번호',
                            hintText: 'password',
                            onSaved: (value) => _password = value!,
                            isObscure: true,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          loginButton(
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });
                              formKey.currentState!.save();

                              bool result = await ApiUser.login(
                                email: _email,
                                password: _password,
                              );

                              setState(() {
                                isLoading = false;
                              });

                              if (result == true) {
                                changeScreen(
                                  context: context,
                                  nextScreen: const CafeSearchScreen(),
                                  isReplace: false,
                                );
                              } else {
                                changeScreen(
                                  context: context,
                                  nextScreen: const LoginScreen(),
                                  isReplace: true,
                                );

                                consentDialog(
                                  title: '실패',
                                  content: '아이디와 비밀번호를 다시 확인해보세요',
                                  context: context,
                                );
                              }
                            },
                            inButtonText: '로그인',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          loginButton(
                            onTap: () {
                              changeScreen(
                                context: context,
                                nextScreen: const SignUpScreen(),
                                isReplace: false,
                              );
                            },
                            inButtonText: '회원가입',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // SizedBox(
                          //   width: 340,
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       SizedBox(
                          //         width: 155,
                          //         height: 38,
                          //         child: Image.asset('assets/image/kakao_login.png'),
                          //       ),
                          //       SizedBox(
                          //         width: 155,
                          //         height: 38,
                          //         child: Image.asset('assets/image/naver_login.png'),
                          //       )
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              if (isLoading)
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(
                      0.5,
                    ),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector loginButton({
    required Function() onTap,
    required String inButtonText,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 340,
        height: 40,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFAEAEAE)),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Center(
          child: Text(
            inButtonText,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Noto Sans KR',
              fontWeight: FontWeight.w400,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }

  Column loginField({
    required String argText,
    required String hintText,
    required FormFieldSetter<String> onSaved,
    bool isObscure = false,
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
              obscureText: isObscure,
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
