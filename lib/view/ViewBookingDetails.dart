// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:alston/utils/appcolors.dart';
import 'package:alston/utils/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewBookingDetailsScreen extends StatefulWidget {
  final dynamic bookingid;
  final dynamic pickupLocation;
  final DateTime? pickUpDatetime;
  final dynamic destination;
  final dynamic customer;
  final dynamic trevalpurpose;
  final dynamic pessanger;
  final dynamic personInCharge;
  final dynamic pessengerName;
  final dynamic mobileNo;
  final dynamic noteToDriver;
  final dynamic comments;
  const ViewBookingDetailsScreen(
      {super.key,
      this.bookingid,
      this.pickupLocation,
      this.pickUpDatetime,
      this.destination,
      this.customer,
      this.trevalpurpose,
      this.pessanger,
      this.personInCharge,
      this.pessengerName,
      this.mobileNo,
      this.noteToDriver,
      this.comments});

  @override
  State<ViewBookingDetailsScreen> createState() =>
      _ViewBookingDetailsScreenState();
}

class _ViewBookingDetailsScreenState extends State<ViewBookingDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return SingleChildScrollView(


      child: GestureDetector(
         onTap: () {
          // This will close the dialog when you tap outside it
          Navigator.pop(context);
        },
        child: Dialog(
        
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 150),
          backgroundColor: themeController.isDarkMode.value
              ? AppColors.primaryColor
              : AppColors.backgroundColors,
          child: Column(
            children: [
              Center(
                  child: ListTile(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
                title: const Text(
                  '        Booking Details',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )),
              const Divider(
                height: 2,
                color: Colors.black,
              ),
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                      const SizedBox(width: 100,
                        child: Text(
                          'Booking',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 100,
                        child: Text(
                          "${widget.bookingid}",
                          style: const TextStyle(),
                        ),
                      ),
                    ]),
                    const Divider(height: 2,color: Colors.black,),
              const SizedBox(height: 5,),
        
                    Padding(
                      padding: const EdgeInsets.only(right:1.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      
                         children: [
                        const SizedBox(width: 100,
                          child: Text(
                            'PickUp Date & Time',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          
                          width: 100,
                          child: Text(
                            "${widget.pickUpDatetime}",
                            style: const TextStyle(),
                          ),
                        ),
                      ]),
                    ),
                    const Divider(height: 2,color: Colors.black,),
              const SizedBox(height: 5,),
        
        
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
                      children: [
                        const SizedBox(width: 100,
                          child: Text(
                            'Customer',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            "${widget.pessanger}",
                            style: const TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 2,color: Colors.black,),
              const SizedBox(height: 5,),
        
        
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
                      children: [
                        const SizedBox(width: 100,
                          child: Text(
                            'Passenger Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            "${widget.pessengerName}",
                            style: const TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 2,color: Colors.black,),
              const SizedBox(height: 5,),
        
        
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
                      children: [
                        const SizedBox(width: 100,
                          child: Text(
                            'Note To Driver',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            "${widget.noteToDriver}",
                            style: const TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 2,color: Colors.black,),
              const SizedBox(height: 5,),
        
        
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
                      children: [
                        const SizedBox(width: 100,
                          child: Text(
                            'Mobile #',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            "${widget.mobileNo}",
                            style: const TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 2,color: Colors.black,),
              const SizedBox(height: 5,),
        
        
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
                      children: [
                        const SizedBox(
                          width: 100,
                          child: Text(
                            'PickUp Location',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            '${widget.pickupLocation}',
                            style: const TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 2,color: Colors.black,),
              const SizedBox(height: 5,),
        
        
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
                      children: [
                        const SizedBox(width: 100,
                          child: Text(
                            'Destination',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            "${widget.destination}",
                            style: const TextStyle(),
                          ),
                        ),
                      ],
                    ),
        
                    const Divider(height: 2,color: Colors.black,),
              const SizedBox(height: 5,),
        
        
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
                      children: [
                        const SizedBox(
                          width: 100,
                          child: Text(
                            'Travel Purpose',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            "${widget.trevalpurpose}",
                            style: const TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 2,color: Colors.black,),
              const SizedBox(height: 5,),
        
        
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
                      children: [
                        const SizedBox(width: 100,
                          child: Text(
                            'Comments',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            "${widget.comments}",
                            style: const TextStyle(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
