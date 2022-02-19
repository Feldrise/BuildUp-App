import 'package:buildup/core/utils/screen_utils.dart';
import 'package:buildup/features/authentication/widgets/authentication_form.dart';
import 'package:buildup/features/authentication/widgets/authentication_header.dart';
import 'package:flutter/material.dart';

class AuthenticationCard extends StatelessWidget {
  const AuthenticationCard({
    Key? key,
    required this.width,
    required this.height,
    required this.isFullWidth,
  }) : super(key: key);

  final double width;
  final double height;

  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(isFullWidth ? 0.0 : 8.0),
        border: isFullWidth ? null : Border.all(
          color: const Color(0xffedeff0),
          width: 1
        )
      ),
      height: height,
      width: width,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtils.instance.horizontalPadding,
            vertical: 40
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              // The header
              Flexible(
                child: AuthenticationHeader(),
              ),
              SizedBox(height: 40,),
      
              // The form
              Flexible(
                child: AuthenticationForm(),
              )
            ],
          ),
        ),
      ),
    );
  }
}