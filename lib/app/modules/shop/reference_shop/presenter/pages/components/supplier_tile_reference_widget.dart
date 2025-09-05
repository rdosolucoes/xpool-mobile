import 'package:flutter/material.dart';

import '../../../../../../../shared/components/circular_cached_image/circular_cached_image_widget.dart';
import '../../../../../../../shared/helpers/app_assets.dart';
import '../../../../../../../shared/helpers/consts.dart';
import '../../../../home_shop/presenter/pages/components/list/reference_icons_widget.dart';

class SupplierTileReference extends StatelessWidget {
  final String name;
  final String city;
  final bool checked;
  final Function(bool?)? onChanged;
  final String urlImage;
  final int totalReference;
  final int totalAccept;
  final int totalReject;

  SupplierTileReference(
      {Key? key,
      required this.name,
      required this.city,
      this.checked = false,
      this.urlImage = "https://hajiri.co/uploads/no_image.jpg",
      this.onChanged,
      this.totalAccept = 0,
      this.totalReference = 0,
      this.totalReject = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1,
        //margin: EdgeInsets.only(right: 5, left: 5),
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 0, right: 10),
                child: CheckboxListTile(
                  onChanged: onChanged,
                  value: checked,
                  secondary: CircularCachedNetworkImage(
                    imageURL: urlImage.isEmpty ? imageDefaultSup : urlImage,
                    size: 50,
                    borderColor: Colors.white,
                  ),
                  contentPadding: EdgeInsets.only(left: 10, bottom: 5),
                  title: Text(
                    name,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(city, style: TextStyle(fontSize: 12)),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ReferenceIcons(
                                image: AppAssets.refer,
                                value: totalReference.toString()),
                            ReferenceIcons(
                                image: AppAssets.confirm,
                                value: totalAccept.toString()),
                            ReferenceIcons(
                                image: AppAssets.reject,
                                value: totalReject.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),
            ]));
  }
}
