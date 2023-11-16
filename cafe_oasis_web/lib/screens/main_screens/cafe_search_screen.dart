import 'package:cafe_oasis_web/screens/user_screens/login_screen.dart';
import 'package:cafe_oasis_web/util/services/api_util.dart';
import 'package:flutter/material.dart';

class CafeSearchScreen extends StatefulWidget {
  const CafeSearchScreen({super.key});

  @override
  State<CafeSearchScreen> createState() => _CafeSearchScreenState();
}

class _CafeSearchScreenState extends State<CafeSearchScreen> {
  final TextEditingController searchBarCtrl = TextEditingController();

  final TextEditingController cafeNameCtrl = TextEditingController();
  final TextEditingController cafeAddrCtrl = TextEditingController();
  final TextEditingController cafeHourCtrl = TextEditingController();
  final TextEditingController cafePhoneCtrl = TextEditingController();
  final TextEditingController cafeDescCtrl = TextEditingController();
  var result = [];
  Map currentCafe = {};
  @override
  Widget build(BuildContext context) {
    cafeNameCtrl.text = '';
    cafeAddrCtrl.text = '';
    cafeHourCtrl.text = '';
    cafePhoneCtrl.text = '';
    cafeDescCtrl.text = '';
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Center(
                  child: Text(
                    'Cafe  Oasis',
                    style: TextStyle(
                      color: const Color(0xFF6CA3C9),
                      fontSize: MediaQuery.of(context).size.width * 0.02,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: 75,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFFC0C0C0)),
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: Center(
                    child: TextField(
                      controller: searchBarCtrl,
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: MediaQuery.of(context).size.width * 0.02,
                            right: MediaQuery.of(context).size.width * 0.02,
                            bottom: 10,
                          ),
                          child: Image.asset(
                            'assets/image/oasis_logo.png',
                            width: MediaQuery.of(context).size.width * 0.04,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 0,
                            right: 0,
                            bottom: 10,
                          ),
                          child: IconButton(
                            iconSize: MediaQuery.of(context).size.width * 0.06,
                            onPressed: () async {
                              result =
                                  await ApiUtil.cafeSearch(searchBarCtrl.text);
                              // print(result);
                              setState(() {});
                            },
                            icon: Image.asset(
                              'assets/image/magnifier.png',
                            ),
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.02),
                  child: Text(
                    '사용자 이름 : ${LoginScreen.user.name}',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.015,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Color(0xffCCCCCC),
            thickness: 1,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: const Color(0xffCCCCCC),
                    )),
                height: MediaQuery.of(context).size.height - 130,
                width: MediaQuery.of(context).size.width * 0.45,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: currentCafe['cafe_name'] == null
                      ? const SizedBox.shrink()
                      : Column(
                          children: [
                            Image.network(
                              currentCafe['cafe_image'],
                              height: MediaQuery.of(context).size.height * 0.35,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/image/oasis_logo.png',
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                );
                              },
                            ),
                            detailText(
                              isEnable: false,
                              hintText: currentCafe['cafe_name'],
                              argController: cafeNameCtrl,
                              argFontSize: 25,
                            ),
                            detailText(
                              isEnable: false,
                              hintText: currentCafe['address'] ?? "주소 없음",
                              argController: cafeAddrCtrl,
                              argFontSize: 20,
                            ),
                            detailText(
                              hintText: currentCafe['business_hours'].isEmpty
                                  ? "영업시간 없음"
                                  : currentCafe['business_hours'],
                              argController: cafeHourCtrl,
                              argFontSize: 20,
                            ),
                            detailText(
                              hintText:
                                  "${currentCafe['cafe_phone_no']}".isNotEmpty
                                      ? "${currentCafe['cafe_phone_no']}"
                                      : "전화번호 없음",
                              argController: cafePhoneCtrl,
                              argFontSize: 20,
                            ),
                            detailText(
                              hintText: "${currentCafe['cafe_info']}".isNotEmpty
                                  ? "${currentCafe['cafe_info']}"
                                  : "카페설명 없음",
                              argController: cafeDescCtrl,
                              argFontSize: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                ApiUtil.cafeUpdate(
                                  cafeName: currentCafe['cafe_name'],
                                  phone: cafePhoneCtrl.text.isEmpty
                                      ? currentCafe['cafe_phone_no']
                                      : cafePhoneCtrl.text,
                                  desc: cafeDescCtrl.text.isEmpty
                                      ? currentCafe['cafe_info']
                                      : cafeDescCtrl.text,
                                  openHour: cafeHourCtrl.text.isEmpty
                                      ? currentCafe['business_hours']
                                      : cafeHourCtrl.text,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff6ca3c9),
                              ),
                              child: SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: const Center(
                                  child: Text(
                                    '수정',
                                    style: TextStyle(
                                      fontFamily: "Noto Sans KR",
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 130,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      for (var cafe in result)
                        singleLine(
                          url: cafe["cafe_image"],
                          cafeName: cafe["cafe_name"],
                          cafeAddress: cafe["address"],
                          onTap: () {
                            currentCafe = cafe;
                            setState(() {});
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget detailText({
    required double argFontSize,
    required TextEditingController argController,
    required String hintText,
    bool? isEnable = true,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFAEAEAE)),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: TextField(
          enabled: isEnable,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
              fontFamily: "Noto Sans KR",
              fontSize: argFontSize,
              fontWeight: FontWeight.w500,
              color: const Color(0xff000000),
            ),
          ),
          controller: argController,
          style: TextStyle(
            fontSize: argFontSize,
          ),
        ),
      ),
    );
  }

  Widget singleLine({
    required String url,
    required String cafeName,
    required String cafeAddress,
    required void Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: const Color(0xffCCCCCC),
            )),
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width * 0.55,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                url,
                width: MediaQuery.of(context).size.width * 0.15,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/image/oasis_logo.png',
                    width: MediaQuery.of(context).size.width * 0.15,
                  );
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 8),
                      child: Text(
                        cafeName,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 8),
                      child: Text(
                        cafeAddress,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
