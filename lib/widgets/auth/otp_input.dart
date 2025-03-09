import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPInput extends StatelessWidget {
  final Function(String) onCompleted;

  const OTPInput({
    Key? key,
    required this.onCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.grey[900],
        activeColor: Colors.green[600],
        inactiveFillColor: Colors.grey[900],
        inactiveColor: Colors.grey[700],
        selectedFillColor: Colors.grey[900],
        selectedColor: Colors.green[600],
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      cursorColor: Colors.white,
      textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontSize: 20,
          ),
      keyboardType: TextInputType.number,
      onCompleted: onCompleted,
      onChanged: (_) {},
      beforeTextPaste: (text) => true,
    );
  }
}
