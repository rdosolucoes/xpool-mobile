import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final int maxLines;
  final int? maxLength;
  final String label;
  final String text;
  final bool enable;
  final Color? fillColor;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onSubmitted;
  final Function()? onEditingComplete;

  const TextFieldWidget(
      {Key? key,
      this.maxLines = 1,
      this.maxLength,
      required this.label,
      required this.text,
      this.enable = true,
      this.fillColor = Colors.white,
      required this.onChanged,
      this.onEditingComplete,
      this.onSubmitted})
      : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.text = widget.text;
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            filled: true,
            fillColor: widget.fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          maxLines: widget.maxLines,
          onSubmitted: widget.onSubmitted,
          onChanged: widget.onChanged,
          enabled: widget.enable,
          maxLength: widget.maxLength,
        ),
      ],
    );
  }
}
