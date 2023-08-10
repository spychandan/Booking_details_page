import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:hooks_riverpod/hooks_riverpod.dart';

final bookingDetailProvider = ChangeNotifierProvider((ref) {
  return BookingDetail();
});

class BookingDetail extends ChangeNotifier {

  Future<dynamic> fetchBookingDetails() async {
    const String apiUrl = 'https://v1.checkprojectstatus.com/cityroom/api/vender-booking-detail';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWY2NjU5ODc4M2QyZTU1MDcxZjA5NTA4N2YyNjEzMjcwYWMwYTdkYjg3N2ZiOWFmNjU2ODk2YmI4MzJkZWM2YzU0YmY2ODhjY2ZlNjZjYjYiLCJpYXQiOjE2ODIwNjMyOTQuODUyMTQ5LCJuYmYiOjE2ODIwNjMyOTQuODUyMTUyLCJleHAiOjE3MTM2ODU2OTQuODQzOTY1LCJzdWIiOiI5Iiwic2NvcGVzIjpbXX0.cONsPfzJ-ujMbeqT_cOst75Symc8YNj8m-bdKm88MMTgWE8cvUySOOyhbUG-gWevxT9kH6LO1U3XSQ3O1K_MPDh3DS9OwsjPFKrke1eQfvkqnnlEwM53rxAXPljpNj73kCHvGl4UUB17yv_fukSo_xyj46VPzv3n-4aDSEzq0sqXXW4EFFht7kFQ0u1otb3Rkxg2ZKl2JTt1DaPSvbHnc3Cqe-iYRQu6xRFiYmfwqJpVitu1cdumDpdXsiDhG-Lg-3TNgt9D2K93obQe2HnpJ8MtvRKiTtgbHO1oTjMB2L9Sg13lJy1WWtpWDp7fHAJhe_iMcH52-IvL0-D_9RpP1uuYJWhaz42fwMcMW2ag-NxBsTsrRnORP70iPRqwEhwW4gFIGPxNfU_-_EwufYtHyDf4yqd4P02BOk7Dodi3zk0meW7e2Jwnb661Jo8bleNdMkoI55pMZKfJuhipITC5VImu95eKc1omvQ2MXutFz-lf0KAuQcN_DNf_kNJCVT3ggPvjdCagLBusNa8lU0v4kcmJTdDlehRsERXfsBVR5fD43hOqUmAAaTMf075ZTp1udqbzu7mkc6V8APR3LkJW3-xV6VU7Vt8omkiYoeH5uvjrpZ-0r7kMGzIi87VXqQlvx0DbcldRmqyk8Pu0QdCjnf3XldG3rUFqFRHKsmwDxfY',
      },
      body: {
        'booking_id': '88',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
    notifyListeners();
    return data;
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }
}
