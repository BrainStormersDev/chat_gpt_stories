
import 'package:flutter/material.dart';


class DropDownWidget extends StatelessWidget {
  // final ValueChanged<String?>? onChanged;
  final String? value;
  final String? hint;
  final double? height;
  // final Color? color;
  // final Color? iconColor;
  final Color? borderColor;
  final Color? bgColor;

  final List<DropdownMenuItem<String>>? items;
  final ValueChanged<String?>? onChangedVal;

  const DropDownWidget(
      {Key? key,
        this.value,
        this.items,
        this.onChangedVal,
        this.hint,
        this.height,
        // this.color,
        // this.iconColor,
        this.borderColor,
        this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height*0.3,
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: bgColor?.withOpacity(0.3),
            border: Border.all(color: borderColor==null?Colors.grey.shade300:borderColor!
              // ColorConstant
              //     .Field_Border_Color
            )),
        child: DropdownButtonFormField<String>(
            dropdownColor: Colors.white,
            // iconEnabledColor: iconColor,
            menuMaxHeight: 300,
            decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 0.0, bottom: 0, top: 0)),
            value: value,
            //elevation: 5,
            // style: TextStyle(color: color),
            items: items,
            hint: Text(
              hint!,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            isExpanded: true,
            onChanged: onChangedVal));
  }
}
