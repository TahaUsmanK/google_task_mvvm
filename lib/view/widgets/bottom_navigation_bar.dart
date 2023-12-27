import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigationBarWidget({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      color: const Color.fromARGB(255, 49, 49, 49),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => onTap(0),
                  icon: Icon(Icons.list_alt,
                      color: currentIndex == 0 ? Colors.white : Colors.white54),
                ),
                IconButton(
                  onPressed: () => onTap(1),
                  icon: Icon(Icons.mobiledata_off_rounded,
                      color: currentIndex == 1 ? Colors.white : Colors.white54),
                ),
                if (currentIndex == 1)
                  IconButton(
                    onPressed: () => onTap(2),
                    icon: Icon(Icons.more_horiz_rounded,
                        color:
                            currentIndex == 2 ? Colors.white : Colors.white54),
                  ),
              ],
            ),
            SizedBox(width: 80),
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blue.shade800,
                  ),
                  child: FloatingActionButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.blue.shade800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
