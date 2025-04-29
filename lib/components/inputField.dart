import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  const InputField({
    super.key,
    required this.inputController,
    required this.isPassword,
    required this.label,
    required this.validator,
  });

  final TextEditingController inputController;
  final bool isPassword;
  final String label;
  final String? Function(String?) validator;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool showpass = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: TextFormField(
        controller: widget.inputController,
        obscureText: widget.isPassword ? showpass : false,
        validator: widget.validator,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: widget.label,
          suffixIcon:
              widget.isPassword
                  ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          showpass = !showpass;
                        });
                      },
                      icon:
                          showpass
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                    ),
                  )
                  : null,
        ),
      ),
    );
  }
}
