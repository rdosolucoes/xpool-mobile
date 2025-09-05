import 'package:flutter/material.dart';

import '../../../../../../../../shared/components/circular_cached_image/circular_cached_image_widget.dart';
import '../../../../../../../../shared/helpers/custom_colors.dart';

class ListPartnersSupWidget extends StatelessWidget {
  final Function? onPressed;
  final String? name;
  final String? photo;

  const ListPartnersSupWidget({Key? key, this.onPressed, this.name, this.photo})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed as void Function()?,
        child: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 2, right: 2, top: 6, bottom: 20),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 5),
                    child: SizedBox.expand(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularCachedNetworkImage(
                            imageURL: photo!,
                            size: 80,
                            borderColor: Colors.white,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            name!,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Americana - SP",
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                                fontStyle: FontStyle.italic),
                          )
                        ],
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: CustomColors.darkBlue.withOpacity(.6),
                          offset: Offset(5.0, 5.0),
                          blurRadius: 10.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white),
                ),
              ),
              /* Positioned(
                  right: 32,
                  top: 15,
                  child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: CustomColors.field),
                      child: )),*/
            ],
          ),
        ));
  }
}
