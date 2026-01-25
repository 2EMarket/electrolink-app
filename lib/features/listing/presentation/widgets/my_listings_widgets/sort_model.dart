import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:second_hand_electronics_marketplace/core/widgets/simple_selection_list.dart';
import 'package:second_hand_electronics_marketplace/features/listing/presentation/bloc/selection_cubit.dart';

class SortModel extends StatelessWidget {
  SortModel({super.key});

  final List<SimpleSelectionOption> sortOptions = [
    SimpleSelectionOption(label: 'Newest'),
    SimpleSelectionOption(label: 'Most Viewed'),
    SimpleSelectionOption(label: 'Price: Low to High'),
    SimpleSelectionOption(label: 'Price: High to Low'),
  ];
  int selectedSortOption = 0;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return BlocConsumer<SelectionCubit, int>(
              listener: (context, state) {
                selectedSortOption = state;
              },

              builder: (context, state) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  //height: 400,
                  child: Column(
                    children: [
                      Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sort By',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: SvgPicture.asset(
                              'assets/svgs/Close Square.svg',
                            ),
                          ),
                        ],
                      ),
                      Gap(20),
                      SimpleSelectionList(
                        title: '',
                        options: sortOptions,
                        selectedIndex: selectedSortOption,
                        onChanged: (int value) {
                          context.read<SelectionCubit>().select(value);
                          print(value);
                        },
                      ),
                      Gap(30),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Apply'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },

      icon: SvgPicture.asset('assets/svgs/Swap.svg', color: Colors.black),
    );
  }
}
