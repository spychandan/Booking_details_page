import 'package:booking_details_page/viewmodels/bookingDetails.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BookingScreen extends ConsumerStatefulWidget {
  const BookingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  late BookingDetail _bookingDetail;

  Widget customTable(String label, String value) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 247, 214, 225),
        border: Border.all(
            color: const Color.fromARGB(255, 245, 106, 152)), // Add pink border
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Table(
          // Remove the border property to remove vertical lines
          children: [
            TableRow(
              children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment
                      .middle, // Align vertically in the middle
                  child: Align(
                    alignment: Alignment.centerLeft, // Align text to the left
                    child: Text(label),
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment
                      .middle, // Align vertically in the middle
                  child: Align(
                    alignment: Alignment.centerLeft, // Align text to the left
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _bookingDetail = ref.watch(bookingDetailProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.transparent, // Set the background color to transparent
        elevation: 0, // Remove the shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Booking Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<dynamic>(
          future: _bookingDetail.fetchBookingDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child:
                      CircularProgressIndicator()); // Show loading indicator while data is being fetched
            } else if (snapshot.hasError) {
              return SnackBar(content: Text('Error: ${snapshot.error}'));
            } else {
              Map<String, dynamic> data = snapshot.data!;
              final bookingData = data['data'];
              List<dynamic> getRoomList = bookingData['get_room'];
      
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Booking # ${bookingData['booking_id']}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          child: Image.asset('assets/images/room.jpg',
                              fit: BoxFit.cover),
                          height: 65,
                          width: 65,
                        ),
                        SizedBox(width: 10),
                        Column(     
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [  
                            Text('Room',
                                style:
                                    const TextStyle(fontWeight: FontWeight.bold)),
                            Text('Room size : ${getRoomList[0]['room_size']}'),
                            Container(
                              padding: EdgeInsets.all(
                                  1), // Padding around the rectangular box
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(
                                    255, 172, 0, 202), // Box background color
                                borderRadius:
                                    BorderRadius.circular(2), // Rounded corners
                              ),
                              child: const Text(
                                'Classic',
                                style: TextStyle(
                                    color: Colors.white, // Text color
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    const Text(
                      'Guest Details',
                      style: TextStyle(
                          color: Colors.grey, // Greyish color
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(height: 5),
                    Text(
                    bookingData['guest_name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text('${bookingData['email']}  •  ${bookingData['phone']}'),
                    SizedBox(height: 20),
                    const Text(
                      'Booking Details',
                      style: TextStyle(
                          color: Colors.grey, // Greyish color
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(height: 5),
                    customTable('Dates', '${bookingData['check_in']} - ${bookingData['check_out']}'),
                    customTable('Guest', '${bookingData['guest_qty']}'),
                    customTable('Room', '${bookingData['room_qty']}'),
                    SizedBox(height: 20),
                    const Text(
                      'Meals Details',
                      style: TextStyle(
                          color: Colors.grey, // Greyish color
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          child: Image.asset('assets/images/breakfast.jpg',
                              fit: BoxFit.cover),
                          height: 65,
                          width: 65,
                        ),
                        SizedBox(width: 10),
                        Column(     
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [  
                            Row(
                              children: [
                                Text('Breakfast',
                                    style:
                                        const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                        SizedBox(width: 50),
                                        Text('₹ ${bookingData['meal_amount']}',style:
                                        const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))
                              ],
                            ),
                            Text('Indian Menu'),
                          ],
                        )
                      ],
                    ),
                 
                    SizedBox(height: 20),
                     const Text(
                      'Payment Details',
                      style: TextStyle(
                          color: Colors.grey, // Greyish color
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                     SizedBox(height: 5),
                    customTable('${bookingData['guest_qty']} Guest x ${bookingData['room_qty']} Rooms', '${bookingData['room_amount']}'),
                    customTable('Meal', '${bookingData['meal_amount']}'),
                    customTable('Taxes', '${bookingData['tax_amount']}'),
                    customTable('Total Amount', '${bookingData['total_amount']}'),
                    SizedBox(height: 20),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
