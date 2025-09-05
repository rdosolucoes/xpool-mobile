import 'package:flutter/material.dart';

import '../../../../../../../shared/helpers/app_assets.dart';
import '../../../../../../../shared/helpers/custom_colors.dart';

class FilterItemShopWidget extends StatelessWidget {
  final Function? onPressed;
  final bool? isActive;
  final String? iconAsset;
  final String? translateKey;

  const FilterItemShopWidget(
      {Key? key,
      this.onPressed,
      this.isActive,
      this.iconAsset,
      this.translateKey})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed as void Function()?,
        child: Container(
          alignment: Alignment.topCenter,
          color: Colors.transparent,
          child: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 4),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 10),
                    child: SizedBox.expand(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Busque Por',
                            style: TextStyle(
                                color: CustomColors.graniteGray,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 2, left: 2),
                            child: Text(
                              translateKey!,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: CustomColors.grey40,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: CustomColors.graniteGray.withOpacity(.3),
                          offset: Offset(0.0, 2.0),
                          blurRadius: 2.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.white),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppAssets.images + iconAsset!),
                          fit: BoxFit.cover),
                      shape: BoxShape.circle,
                      color: CustomColors.field),
                ),
              ),
            ],
          ),
        ));
  }
}
