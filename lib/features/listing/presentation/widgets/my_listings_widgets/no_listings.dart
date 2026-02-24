import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class NoListings extends StatelessWidget {
  final String text;

  const NoListings({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/svgs/Frame.svg'),
          Gap(10),
          Text('No Listings Yet', style: TextStyle(color: Colors.black)),
          Gap(10),
          Text(
            'You ${text} listings to display it yet.',
            style: TextStyle(color: Colors.black54),
          ),
          Gap(10),
          ElevatedButton(
            onPressed: () {
              // Navigate to add listing page
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120.0),
              child: Text('Add Listing'),
            ),
          ),
        ],
      ),
    );
  }
}
