import 'package:encrypt/encrypt.dart';

import '../models/dropdown_model.dart';

const String baseUrlRelease = 'http://api.xpool.com.br/api/';
const String baseUrlReleaseTst = 'http://tst-api.xpool.com.br/api/';
const String baseUrlDebug = 'http://192.168.0.35:5000/api/';
const String baseUrlStorage = 'https://docxpool.blob.core.windows.net';
const String imageDefault = '$baseUrlStorage/images/noimage_shop.png';
const String imageDefaultSup = '$baseUrlStorage/images/noimage_sup.jpg';
const String pkPagarme = 'pk_QAxkv5AcYfByRYw2';
const String pkPagarmeTst = 'pk_test_Qy9WlkRaFVCkOwp7';
const int timeNotification = 10;

final keyEncrypt = Key.fromSecureRandom(32);
final ivEncrypt = IV.fromSecureRandom(16);

const String azureStorage =
    'DefaultEndpointsProtocol=https;AccountName=docxpool;AccountKey=BSCuovySyaMtyqBSk/AK38HR8cbO4kM7qz0Pl2WrGCKKcggaZuwoSO2rLYT/+VsINeeOf5pko0Vp+2Nq+NaMnw==;EndpointSuffix=core.windows.net';

const String containerImage = 'profileimages';

List<DropdownModel> statesList = <DropdownModel>[
  DropdownModel(id: 1, name: "Acre"),
  DropdownModel(id: 2, name: "Alagoas"),
  DropdownModel(id: 3, name: "Amazonas"),
  DropdownModel(id: 4, name: "Amapá"),
  DropdownModel(id: 5, name: "Bahia"),
  DropdownModel(id: 6, name: "Ceará"),
  DropdownModel(id: 7, name: "Distrito Federal"),
  DropdownModel(id: 8, name: "Espírito Santo"),
  DropdownModel(id: 9, name: "Goiás"),
  DropdownModel(id: 10, name: "Maranhão"),
  DropdownModel(id: 11, name: "Minas Gerais"),
  DropdownModel(id: 12, name: "Mato Grosso do Sul"),
  DropdownModel(id: 13, name: "Mato Grosso"),
  DropdownModel(id: 14, name: "Pará"),
  DropdownModel(id: 15, name: "Paraíba"),
  DropdownModel(id: 16, name: "Pernambuco"),
  DropdownModel(id: 17, name: "Piauí"),
  DropdownModel(id: 18, name: "Paraná"),
  DropdownModel(id: 19, name: "Rio de Janeiro"),
  DropdownModel(id: 20, name: "Rio Grande do Norte"),
  DropdownModel(id: 21, name: "Rondônia"),
  DropdownModel(id: 22, name: "Roraima"),
  DropdownModel(id: 23, name: "Rio Grande do Sul"),
  DropdownModel(id: 24, name: "Santa Catarina"),
  DropdownModel(id: 25, name: "Sergipe"),
  DropdownModel(id: 26, name: "São Paulo"),
  DropdownModel(id: 27, name: "Tocantins"),
];
