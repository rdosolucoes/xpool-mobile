import 'package:flutter/material.dart';

class CardsHomeWidget extends StatelessWidget {
  final String title;
  final int totalReferences;
  final int totalAccept;
  final int totalReject;
  const CardsHomeWidget(
      {Key? key,
      this.title = "CardsHomeWidget",
      this.totalReferences = 0,
      this.totalAccept = 0,
      this.totalReject = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Positioned(
      height: 100,
      width: size.width,
      top: 200,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, left: 35, right: 35),
        child: Card(
          shadowColor: Colors.black,
          elevation: 10,
          color: Colors.grey[50],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(34, 123, 177, 1),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    margin: EdgeInsets.all(6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          totalReferences.toString(), //totalSupDenied!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5, top: 5),
                          child: Text(
                            "PENDENTES",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              /*color: Colors.white*/
                            ),
                          ),
                        )
                      ],
                    )),
              ),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(34, 123, 177, 1),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    margin: EdgeInsets.all(6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          totalAccept.toString(), //totalSupDenied!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5, top: 5),
                          child: Text(
                            "APROVADOS",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )),
              ),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(34, 123, 177, 1),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    margin: EdgeInsets.all(6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          totalReject.toString(), //totalSupDenied!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5, top: 5),
                          child: Text(
                            "REPROVADOS",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
