import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String id;
  final VoidCallback onTap;
  final bool isAsset; 

  const CategoryItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.id,
    required this.onTap,
    required this.isAsset, 
   });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[200],
            backgroundImage: isAsset
                ? AssetImage(imagePath) as ImageProvider 
               : NetworkImage(imagePath), 
                  ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}