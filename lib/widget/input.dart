import 'package:flutter/material.dart';

class CustomerField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final Icon icon;
  final TextEditingController controller;
  final String validateText;
  const CustomerField({super.key,required this.label,required this.obscureText,required this.controller,required this.icon,required this.validateText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
                  padding: const EdgeInsets.only(left: 20,top: 5,bottom: 5),
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue.shade100),
                    borderRadius: BorderRadius.circular(5)
        
                  ),
                  child: TextField(
                    controller:controller ,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      icon: icon,
                      iconColor: Colors.blue,
                      label: Text(label),
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                ),
          Text(validateText,style: TextStyle(color: Colors.red,fontSize: 10),),
          const SizedBox(height: 20,)
      ],
    );
  }
  }
