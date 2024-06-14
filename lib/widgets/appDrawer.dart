import 'package:flutter/material.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';

class AppDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const AppDrawer({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: primaryBlue.shade900,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Owner', style: heading4Regular.copyWith(color: Colors.white)),
                Text('POS 1', style: bodySregular.copyWith(color: Colors.white)),
                Text('Business Name', style: bodyXSregular.copyWith(color: Colors.white)),
              ],
            ),
          ),
          _createDrawerItem(
            icon: Icons.shopping_basket,
            text: 'Sales',
            onTap: () => onTap(0),
            selected: selectedIndex == 0,
          ),
          _createDrawerItem(
            icon: Icons.receipt,
            text: 'Receipts',
            onTap: () => onTap(1),
            selected: selectedIndex == 1,
          ),
          _createDrawerItem(
            icon: Icons.schedule,
            text: 'Shift',
            onTap: () => onTap(2),
            selected: selectedIndex == 2,
          ),
          _createDrawerItem(
            icon: Icons.list,
            text: 'Items',
            onTap: () => onTap(3),
            selected: selectedIndex == 3,
          ),
          _createDrawerItem(
            icon: Icons.settings,
            text: 'Settings',
            onTap: () => onTap(4),
            selected: selectedIndex == 4,
          ),
          Divider(thickness: 1, color: Colors.grey.shade400),
          _createDrawerItem(
            icon: Icons.bar_chart_outlined,
            text: 'Back office',
            onTap: () => onTap(5),
            selected: selectedIndex == 5,
          ),
          _createDrawerItem(
            icon: Icons.card_giftcard_outlined,
            text: 'Apps',
            onTap: () => onTap(6),
            selected: selectedIndex == 6,
          ),
          _createDrawerItem(
            icon: Icons.error_outline_outlined,
            text: 'Support',
            onTap: () => onTap(7),
            selected: selectedIndex == 7,
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap,
      required bool selected}) {
    return ListTile(
      title: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 30),
          Text(text, style: bodySregular),
        ],
      ),
      selected: selected,
      selectedTileColor: Colors.grey.shade500,
      onTap: onTap,
    );
  }
}
