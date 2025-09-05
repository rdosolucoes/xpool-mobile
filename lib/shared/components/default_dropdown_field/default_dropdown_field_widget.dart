import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../helpers/custom_colors.dart';
import '../../models/dropdown_model.dart';

class DefaultDropDownFieldWidget extends StatefulWidget {
  final Function(DropdownModel?)? onSaved;
  final String Function(String?)? validator;
  final Function()? onTap;
  final Function(DropdownModel?)? onChanged;
  final String? labelText;
  final String? initialValue;
  final DropdownModel? selectedItem;
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
  final List<DropdownModel> items;
  final bool showSearchBox;
  final TextFieldProps? searchFieldProps;
  final Future<List<DropdownModel>> Function(String?)? getData;
  final bool clearButton;
  DefaultDropDownFieldWidget(
      {Key? key,
      this.onSaved,
      this.validator,
      this.onTap,
      this.onChanged,
      this.labelText,
      this.initialValue,
      this.selectedItem,
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
      this.items = const <DropdownModel>[],
      this.showSearchBox = false,
      this.searchFieldProps,
      this.getData,
      this.clearButton = false})
      : super(key: key);

  @override
  _DefaultDropDownFieldWidgetState createState() =>
      _DefaultDropDownFieldWidgetState();
}

class _DefaultDropDownFieldWidgetState
    extends State<DefaultDropDownFieldWidget> {
  late FocusNode focus;
  bool hasFocus = false;

  /*Future<List<DropdownModel>> getData(filter) async {
    return [DropdownModel(name: "São Paulo", id: 1)];
  }*/

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
        if (widget.labelText != null)
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
        DropdownSearch<DropdownModel>(
          showClearButton: widget.clearButton,
          selectedItem: widget.selectedItem,
          items: widget.items,
          asyncItems: widget.getData != null
              ? (filter) => widget.getData!(filter)
              : null,
          itemAsString: (u) => u.name,

          /*searchBoxStyle: TextStyle(
            color: widget.fontColor,
          ),*/
          dropdownSearchDecoration: InputDecoration(
            hintText: "Selecionar",
            contentPadding: const EdgeInsets.only(right: 10, left: 20),
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
            errorBorder: (widget.errorMessage?.length ?? 0) == 0
                ? OutlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.whisper))
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(color: CustomColors.flamingo)),
            errorStyle: TextStyle(
              fontFamily: "Rubik",
              fontWeight: FontWeight.w300,
              fontSize: 12,
              inherit: true,
              color: CustomColors.flamingo,
            ),
          ),
          onSaved: widget.onSaved,
          onChanged: widget.onChanged,
          popupProps: PopupProps.menu(showSearchBox: true),
        ),
      ],
    );
  }
}
