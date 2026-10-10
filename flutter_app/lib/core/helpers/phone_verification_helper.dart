import 'package:flutter/foundation.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class PhoneVerificationHelper {

  static String getValidPhoneNumber(String number, {bool withCountryCode = false}) {
    bool isValid = false;
    String phone = "";

    try{
      PhoneNumber phoneNumber = PhoneNumber.parse(number);
      isValid = phoneNumber.isValid(type: PhoneNumberType.mobile);
      if(isValid){
        phone =  withCountryCode ? "+${phoneNumber.countryCode}${phoneNumber.nsn}" : phoneNumber.nsn.toString();
        if (kDebugMode) {
          debugPrint("Phone Number : $phone");
        }
      }
    }catch(e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
    return phone;
  }


}
