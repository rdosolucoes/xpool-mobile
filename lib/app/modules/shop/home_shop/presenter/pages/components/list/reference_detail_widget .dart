import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../../../../shared/components/circular_cached_image/circular_cached_image_widget.dart';
import '../../../../../../../../shared/helpers/consts.dart';

class ReferenceDetail extends StatelessWidget {
  final String supplierName;
  final int status;
  final String image;
  final int referenceId;
  final int supplierId;

  ReferenceDetail(
      {Key? key,
      this.supplierName = '',
      this.image = imageDefaultSup,
      this.status = 0,
      this.referenceId = 0,
      this.supplierId = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      leading: CircularCachedNetworkImage(
        imageURL: image,
        size: 40,
        borderColor: Colors.white,
      ),
      //dense: true,
      title: Text(
        supplierName,
        style: TextStyle(fontSize: 14),
      ),
      trailing: _buildStatus(context),
      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      //minVerticalPadding: 2,
    );
  }

  Widget _buildStatus(BuildContext context) {
    if (status == 0) {
      return FaIcon(
        FontAwesomeIcons.userClock,
        color: Colors.cyan,
        size: 25,
      );
    } else if (status == 1) {
      return FaIcon(
        FontAwesomeIcons.solidThumbsUp,
        color: Colors.green,
        size: 25,
      );
    } else if (status == 3) {
      return InkWell(
        onTap: () {
          Navigator.of(context).pop();
          Modular.to
              .pushNamed('/dispute', arguments: [referenceId, supplierId]);
        },
        child: FaIcon(
          FontAwesomeIcons.circleExclamation,
          color: Colors.yellow[700],
          size: 28,
        ),
      );
    } else {
      return FaIcon(
        FontAwesomeIcons.solidThumbsDown,
        color: Colors.red,
        size: 25,
      );
    }
  }
}
