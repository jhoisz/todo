import 'package:flutter/material.dart';

import '../../themes/theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.action,
    required this.title,
    required this.colorButton,
    this.isCancel = false,
  });

  final Function() action;
  final String title;
  final Color colorButton;
  final bool isCancel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: InkWell(
        onTap: action,
        child: Ink(
          height: MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
            color: colorButton,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: colorButton.withOpacity(0.32),
                blurRadius: 5.0,
                offset: const Offset(2, 2),
              )
            ],
          ),
          child: Center(
            child: Text(
              title,
              style: isCancel ? ThemeStyle.buttonCancelText : ThemeStyle.buttonText,
            ),
          ),
        ),
      ),
    );
  }
}
