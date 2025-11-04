import 'package:flutter/material.dart';

class Option extends StatelessWidget{
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const Option({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
});

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Theme.of(context).colorScheme.primary : Colors.white,
          border: Border.all(
            color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey.shade300,
          ),
        ),
        child: Text(text, style: Theme.of(context).textTheme.bodyLarge)
      )
    );
  }
}