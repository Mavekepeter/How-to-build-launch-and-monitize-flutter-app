import 'package:chattera/features/home/domain/entities/post.dart';
import 'package:flutter/material.dart';

class PostTile extends StatelessWidget {
  final Post post;
  final void Function()? onDelete;
  final void Function()? onTap;

  const PostTile({
    super.key,
    required this.post,
    required this.onDelete,
    required this.onTap,
    });

  @override
Widget build(BuildContext context) {
  final colors = Theme.of(context).colorScheme;

  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
    
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                post.username,
                style: TextStyle(
                  color: colors.inversePrimary, 
                  fontSize: 12,
                ),
              ),
    
              GestureDetector(
                onTap: onDelete,
                child: Icon(
                  Icons.cancel,
                  color: colors.inversePrimary, 
                ),
              ),
            ],
          ),
    
          const SizedBox(height: 10),
    
          Text(
            post.title,
            style: TextStyle(
              color: colors.inversePrimary, 
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
    
          Text(
            post.content,
            style: TextStyle(
              color: colors.inversePrimary, 
            ),
          ),
        ],
      ),
    ),
  );
}

  
}
