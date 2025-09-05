import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../helpers/custom_colors.dart';

class DefaultTextFieldWidget extends StatefulWidget {
  final Function(String?)? onSaved;
  final String Function(String?)? validator;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? labelText;
  final String? initialValue;
  final TextEditingController? controller;
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
  final TextCapitalization textCapitalization;
  DefaultTextFieldWidget(
      {Key? key,
      this.onSaved,
      this.validator,
      this.onTap,
      this.onChanged,
      this.onSubmitted,
      this.labelText,
      this.initialValue,
      this.controller,
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
      this.textCapitalization = TextCapitalization.none})
      : super(key: key);

  @override
  _DefaultTextFieldWidgetState createState() => _DefaultTextFieldWidgetState();
}

class _DefaultTextFieldWidgetState extends State<DefaultTextFieldWidget> {
  late FocusNode focus;
  bool hasFocus = false;

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
    focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          textCapitalization: widget.textCapitalization,
          cursorColor: colorFocus,
          focusNode: focus,
          readOnly: widget.readOnly,
          controller: widget.controller,
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

            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(100),
            ),
            labelStyle: TextStyle(
              color: widget.labelStyleColor == null
                  ? Theme.of(context).colorScheme.secondary
                  : widget.labelStyleColor,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            /* errorBorder: (widget.errorMessage?.length ?? 0) == 0
                ? OutlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.whisper))
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(color: CustomColors.flamingo)),*/
            //errorText: '',
            errorStyle: TextStyle(
              fontFamily: "Rubik",
              fontWeight: FontWeight.w300,
              fontSize: 12,
              inherit: true,
              color: CustomColors.flamingo,
            ),
          ),
          //validator: widget.validator,
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
