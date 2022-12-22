import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

import '../firebase/firebase_methods.dart';
import '../widgets/custom_button.dart';
import '../utils/snackBar.dart';

class PhoneLogScreen extends StatefulWidget {
  const PhoneLogScreen({Key? key}) : super(key: key);

  @override
  State<PhoneLogScreen> createState() => _PhoneLogScreenState();
}

class _PhoneLogScreenState extends State<PhoneLogScreen> {
  final TextEditingController phoneNoController = TextEditingController();

  Country selectCountry = Country(
    phoneCode: '+91',
    countryCode: 'IN',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'India',
    example: 'India',
    displayName: 'India',
    displayNameNoCountryCode: 'IN',
    e164Key: '',
  );

  countryPicker() {
    showCountryPicker(
        countryListTheme: const CountryListThemeData(bottomSheetHeight: 400),
        context: context,
        onSelect: (selectedCountryValue) {
          setState(() {
            selectCountry = selectedCountryValue;
          });
        });
  }

  phoneLog() async {
    String result = await FireBaseMethods().phoneSignIn(
        '${selectCountry.phoneCode} ${phoneNoController.text}', context);

    if (result == 'success') {
      showSnackBar('OTP sent successfully');
    } else {
      showSnackBar(result);
    }
  }

  showSnackBar(String content) {
    snackBar(context, content);
  }

  _logOut() {
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    phoneNoController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneNoController.text.length,
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blueAccent,
                Colors.deepOrangeAccent,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Phone Login',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
                keyboardType: TextInputType.number,
                controller: phoneNoController,
                cursorColor: Colors.black87,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0),
                  hintText: 'Enter Phone number',
                  hintStyle: const TextStyle(
                    fontSize: 17,
                    height: 1.5,
                    color: Colors.black54,
                  ),
                  border: const OutlineInputBorder(

                      // borderSide: Divider.createBorderSide(context),
                      ),
                  enabledBorder: const OutlineInputBorder(
                      // borderSide: Divider.createBorderSide(context),
                      ),
                  focusedBorder: const OutlineInputBorder(
                      // borderSide: Divider.createBorderSide(context),
                      ),
                  prefixIcon: Container(
                    padding: const EdgeInsetsDirectional.only(start: 0),
                    width: 95,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: countryPicker,
                          child: const Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.white70,
                            size: 28,
                          ),
                        ),
                        Text(
                          '${selectCountry.flagEmoji} ${selectCountry.phoneCode}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  suffixIcon: phoneNoController.text.length > 9
                      ? Container(
                          height: 10,
                          width: 10,
                          margin: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white70,
                          ),
                          child: const Icon(
                            Icons.done,
                            size: 18,
                            color: Colors.red,
                          ),
                        )
                      : null,
                ),
                onChanged: (value) {
                  setState(() {
                    phoneNoController.text = value;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                child: CustomButton(
                  text: 'Send OTP',
                  onPressed: phoneLog,
                ),
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              Container(
                width: double.infinity,
                child: CustomButton(
                  text: 'Back',
                  onPressed: _logOut,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
