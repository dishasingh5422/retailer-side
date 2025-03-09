import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneInput extends StatelessWidget {
  final Function(String) onPhoneChanged;

  const PhoneInput({
    Key? key,
    required this.onPhoneChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ],
        onChanged: onPhoneChanged,
        decoration: InputDecoration(
          prefixIcon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '+91',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 24,
                  width: 1,
                  color: Colors.grey[700],
                ),
              ],
            ),
          ),
          hintText: 'Phone Number',
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14.0,
            horizontal: 8.0,
          ),
        ),
      ),
    );
  }
}
