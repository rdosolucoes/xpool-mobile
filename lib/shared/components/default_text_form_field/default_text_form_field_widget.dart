import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../helpers/custom_colors.dart';

class DefaultTextFormFieldWidget extends StatefulWidget {
  final Function(String?)? onSaved;
  final String Function(String?)? validator;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? labelText;
  final String text;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType? keyboardType;
  final bool readOnly;
  final bool obscureText;
  final int maxLines;
  final Color backgroundColor;
  final Color fontColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool showBorder;
  final Color? labelStyleColor;
  final String? hintText;
  final FocusNode? focus;
  final String? errorMessage;
  final int? maxLenght;
  final String? counterText;
  DefaultTextFormFieldWidget(
      {Key? key,
      this.onSaved,
      this.validator,
      this.onTap,
      this.onChanged,
      this.onSubmitted,
      this.labelText,
      required this.text,
      this.inputFormatter,
      this.keyboardType = TextInputType.text,
      this.readOnly = false,
      this.obscureText = false,
      this.maxLines = 1,
      this.backgroundColor = Colors.white,
      this.fontColor = Colors.black,
      this.suffixIcon,
      this.prefixIcon,
      this.showBorder = true,
      this.labelStyleColor,
      this.hintText,
      this.focus,
      this.errorMessage,
      this.maxLenght,
      this.counterText})
      : super(key: key);

  @override
  _DefaultTextFormFieldWidgetState createState() =>
      _DefaultTextFormFieldWidgetState();
}

class _DefaultTextFormFieldWidgetState
    extends State<DefaultTextFormFieldWidget> {
  late FocusNode focus;
  bool hasFocus = false;
  final myController = TextEditingController();

  @override
  void initState() {
    focus = widget.focus ?? FocusNode();
    focus.addListener(() {
      hasFocus = focus.hasFocus;
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    myController.dispose();
    focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    myController.text = widget.text;
    myController.selection = TextSelection.fromPosition(
        TextPosition(offset: myController.text.length));

    var colorFocus = hasFocus ? CustomColors.darkBlue : CustomColors.grey40;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            widget.labelText!,
            style: TextStyle(
              fontSize: 14,
              color: colorFocus,
            ),
          ),
        ),
        TextFormField(
          cursorColor: colorFocus,
          focusNode: focus,
          readOnly: widget.readOnly,
          controller: myController,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          style: TextStyle(
            color: widget.fontColor,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 20),
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
            fillColor: widget.backgroundColor,
            filled: true,
            counterText: widget.counterText,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(50),
            ),
            labelStyle: TextStyle(
              color: widget.labelStyleColor == null
                  ? Theme.of(context).colorScheme.secondary
                  : widget.labelStyleColor,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            errorStyle: TextStyle(
              fontFamily: "Rubik",
              fontWeight: FontWeight.w300,
              fontSize: 12,
              inherit: true,
              color: CustomColors.flamingo,
            ),
          ),
          onTap: widget.onTap,
          onSaved: widget.onSaved,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          inputFormatters: widget.inputFormatter,
          maxLength: widget.maxLenght,
          validator: widget.validator,
        ),
      ],
    );
  }
}
