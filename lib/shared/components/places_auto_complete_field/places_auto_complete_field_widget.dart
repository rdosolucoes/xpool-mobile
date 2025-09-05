import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import '../../models/localization_model.dart';

class PlacesAutoCompleteFieldWidget extends StatelessWidget {
  final String title;
  final String? Function(String?)? validator;
  final Function(LocalizationModel)? onChanged;
  final TextEditingController controller;

  PlacesAutoCompleteFieldWidget(
      {Key? key,
      this.title = "PlacesAutoCompleteFieldWidget",
      this.validator,
      this.onChanged,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GooglePlaceAutoCompleteTextField(
          textEditingController: controller,
          googleAPIKey: "AIzaSyAYMSY_9jre3PQwxjKcUGrnRy1I-0HfV6c",
          validator: validator,
          inputDecoration:
              const InputDecoration(hintText: "Localização do Serviço"),
          debounceTime: 800,
          countries: const ["br"],
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: (prediction) {
            print("placeDetails${prediction.lng}");

            var model = LocalizationModel();

            if (prediction.structuredFormatting != null) {
              model = LocalizationModel(
                  description: prediction.description!,
                  mainText: prediction.structuredFormatting!.mainText!,
                  secondaryText:
                      prediction.structuredFormatting!.secondaryText!,
                  latitude: prediction.lat!,
                  longitude: prediction.lng!);
            }

            onChanged!(model);
          },
          itmClick: (prediction) {
            controller.text = prediction.description!;
            controller.selection = TextSelection.fromPosition(
                TextPosition(offset: prediction.description!.length));
          }
          // default 600 ms ,
          ),
    );
  }
}
