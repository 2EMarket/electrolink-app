import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_colors.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_typography.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_Chat list item/chat_list_item.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.greyFillButton,

        appBar: AppBar(
          backgroundColor: AppColors.white,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          elevation: 0,
          centerTitle: false,
          title: Text(
            'Chats',
            style: AppTypography.h2_20Medium.copyWith(color: AppColors.titles),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              color: AppColors.icons,
              onPressed: () {},
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(color: AppColors.border, height: 1),
          ),
        ),

        body: Column(
          children: [
            // 🔍 Search
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search ...",
                  hintStyle: AppTypography.body16Regular.copyWith(
                    color: AppColors.neutral,
                  ),
                  prefixIcon: Icon(Icons.search, color: AppColors.icons),
                  filled: true,
                  fillColor: AppColors.greyFillButton,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // Tabs
            const _ChatFilters(),

            // Divider
            Container(color: AppColors.border, height: 1),

            // Chats list
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 8),
                children: const [
                  ChatListItem(
                    name: 'Yara Yaseen',
                    lastMsg: 'Where can we meet?',
                    time: '28m',
                    unread: 0,
                    productName: 'Dell XPS 15',
                    imageUrl: 'https://i.pravatar.cc/150?img=1',
                    isSelected: true,
                    isPinned: true,
                  ),
                  ChatListItem(
                    name: 'Liam Wang',
                    lastMsg: 'Is it still available?',
                    time: '1hr',
                    unread: 1,
                    productName: 'Canon EOS M50',
                    imageUrl: 'https://i.pravatar.cc/150?img=2',
                    isPinned: false,
                  ),
                  ChatListItem(
                    name: 'John Doe',
                    lastMsg: 'Hello, how are you?',
                    time: '10:30 AM',
                    unread: 2,
                    productName: 'iPhone 12',
                    imageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
                    isSelected: false,
                    isPinned: false,
                  ),
                  ChatListItem(
                    name: 'Omar Ali',
                    lastMsg: 'We can definitely meet tomorrow',
                    time: '1w',
                    unread: 0,
                    productName: 'Redmi Note 12',
                    imageUrl: 'https://i.pravatar.cc/150?img=3',
                    isPinned: false,
                  ),
                  ChatListItem(
                    name: 'Mohammed Said',
                    lastMsg: 'I want to know if is it still available?',
                    time: '1w',
                    unread: 0,
                    productName: 'iPhone 13 Pro Max',
                    imageUrl: 'https://i.pravatar.cc/150?img=4',
                    isPinned: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatFilters extends StatefulWidget {
  const _ChatFilters();

  @override
  State<_ChatFilters> createState() => _ChatFiltersState();
}

class _ChatFiltersState extends State<_ChatFilters> {
  int _selectedIndex = 0;

  final List<String> _filters = [
    'All',
    'Unread',
    'Buying',
    'Selling',
    'Archived',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            _filters.length,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color:
                        _selectedIndex == index
                            ? AppColors.mainColor
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    _filters[index],
                    style: AppTypography.body14Regular.copyWith(
                      color:
                          _selectedIndex == index
                              ? AppColors.white
                              : AppColors.neutral,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
