import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final bool outline;
  final VoidCallback onPressed;
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.outline = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          gradient: outline
              ? null
              : LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
          border: outline
              ? Border.all(color: Theme.of(context).colorScheme.secondary)
              : null,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 40,
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: outline
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ),
      ),
    );
  }
}
