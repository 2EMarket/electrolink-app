import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:second_hand_electronics_marketplace/core/constants/app_strings.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/filter_button.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/search_widget.dart';
import 'package:second_hand_electronics_marketplace/features/listing/data/listing_model.dart';
import 'package:second_hand_electronics_marketplace/features/listing/presentation/widgets/my_listings_widgets/horizatntal2_card.dart';
import 'package:second_hand_electronics_marketplace/features/listing/presentation/widgets/my_listings_widgets/no_listings.dart';
import 'package:second_hand_electronics_marketplace/features/listing/presentation/widgets/my_listings_widgets/sort_model.dart';
import 'package:second_hand_electronics_marketplace/features/listing/presentation/widgets/my_listings_widgets/vertical2_card.dart';

class MyListingScreen extends StatefulWidget {
  MyListingScreen({super.key});

  @override
  State<MyListingScreen> createState() => _MyListingScreenState();
}

class _MyListingScreenState extends State<MyListingScreen> {
  List<ListingModel> listings = dummyListings;

  int selectedSortOption = 0;
  bool isGridView = false;

  final List<String> status = [
    'All',
    'Pending',
    'Active',
    'Rejected',
    'Sold',
    'Archived',
    'Draft',
  ];
  int selectedState = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Listings'),
        leading: BackButton(),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child:
            listings.isEmpty
                ? NoListings(text: "haven't Add any")
                : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: SearchWidget(
                              controller: TextEditingController(),
                              onChanged: (value) {},
                            ),
                          ),
                          Gap(10),
                          FilterButton(),
                        ],
                      ),
                      Gap(16),

                      SizedBox(
                        height: 38,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: status.length,
                          separatorBuilder:
                              (_, __) => const SizedBox(width: 10),
                          itemBuilder: (context, index) {
                            final bool isSelected = selectedState == index;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedState = index;

                                  //Update the listings
                                  //listings = ;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        isSelected
                                            ? const Color.fromRGBO(
                                              37,
                                              99,
                                              235,
                                              1,
                                            )
                                            : const Color.fromARGB(
                                              255,
                                              187,
                                              187,
                                              187,
                                            ),
                                  ),
                                  color:
                                      isSelected
                                          ? const Color.fromRGBO(37, 99, 235, 1)
                                          : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  status[index],
                                  style: TextStyle(
                                    color:
                                        isSelected
                                            ? Colors.white
                                            : const Color.fromARGB(
                                              255,
                                              160,
                                              159,
                                              159,
                                            ),

                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [SortModel(), Text(AppStrings.sort)]),

                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isGridView = false;
                                  });
                                },
                                icon: SvgPicture.asset(
                                  'assets/svgs/document_colord.svg',
                                  color:
                                      !isGridView
                                          ? const Color.fromRGBO(37, 99, 235, 1)
                                          : Colors.grey,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isGridView = true;
                                  });
                                },
                                icon: SvgPicture.asset(
                                  'assets/svgs/category_uncolord.svg',
                                  color:
                                      isGridView
                                          ? const Color.fromRGBO(37, 99, 235, 1)
                                          : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Expanded(
                        child:
                            listings.isEmpty && selectedState != 0
                                ? NoListings(
                                  text: 'have no ${status[selectedState]}',
                                )
                                : isGridView
                                ? GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 12,
                                        crossAxisSpacing: 12,
                                        childAspectRatio: 0.55,
                                      ),
                                  itemBuilder:
                                      (context, index) => Container(
                                        child: Vertical2Card(
                                          listing: listings[index],
                                          selectState: selectedState,
                                        ),
                                      ),
                                  itemCount: listings.length,
                                )
                                : ListView.builder(
                                  itemBuilder:
                                      (context, index) => Horizontal2Card(
                                        listing: listings[index],
                                        selectState: selectedState,
                                      ),
                                  itemCount: listings.length,
                                  scrollDirection: Axis.vertical,
                                ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
