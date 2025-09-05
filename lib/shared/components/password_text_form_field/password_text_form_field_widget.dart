import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../helpers/custom_colors.dart';
import '../../helpers/errors.dart';
import '../default_text_field/default_text_field_widget.dart';
import 'password_text_form_field_controller.dart';
import 'stores/password_text_form_field_store.dart';

class PasswordTextFormFieldWidget extends StatefulWidget {
  final Function(String)? onChanged;
  final String label;
  final String Function(String?)? validator;
  final String? errorMessage;
  final Color? backgroundColor;
  final Color? fontColor;
  final bool visiblePassword;
  PasswordTextFormFieldWidget(
      {Key? key,
      this.onChanged,
      required this.label,
      this.validator,
      this.errorMessage,
      this.backgroundColor,
      this.fontColor,
      this.visiblePassword = true})
      : super(key: key);

  @override
  _PasswordTextFormFieldWidgetState createState() =>
      _PasswordTextFormFieldWidgetState();
}

class _PasswordTextFormFieldWidgetState
    extends State<PasswordTextFormFieldWidget> {
  var controller = Modular.get<PasswordTextFormFieldController>();
  @override
  void initState() {
    //controller.setError(widget.errorMessage ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // controller.setError(widget.errorMessage ?? '');
    return ScopedBuilder<PasswordTextFormFieldStore, Failure, bool>(
      store: controller.store,
      onState: (_, state) {
        return DefaultTextFieldWidget(
          labelText: widget.label,
          fontColor: widget.fontColor ?? Colors.black.withOpacity(0.8),
          obscureText: !controller.store.state,
          errorMessage: widget.errorMessage,
          suffixIcon: widget.visiblePassword
              ? IconButton(
                  onPressed: controller.switchVisible,
                  icon: controller.store.state
                      ? Icon(Icons.visibility, color: CustomColors.darkBlue)
                      : Icon(Icons.visibility_off, color: CustomColors.grey40),
                )
              : null,
          onChanged: widget.onChanged,
          validator: widget.validator,
        );
      },
    );
  }
}
