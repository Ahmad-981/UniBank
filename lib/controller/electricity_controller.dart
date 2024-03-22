import 'package:get/get.dart';

class ElectricityBillController extends GetxController {
  final List<String> electricityProviders = [
    'GEPCO',
    'FESCO',
    'HAZECO',
    'HESCO',
    'IESCO',
    'LESCO',
    'MEPCO',
    'NEPRA'
  ];

  final RxList<String> electProviders = [
    'GEPCO',
    'FESCO',
    'HAZECO',
    'HESCO',
    'IESCO',
    'LESCO',
    'MEPCO',
    'NEPRA'
  ].obs;

  final List<String> transferProviders = [
    'Jazzcash',
    'UPaisa',
    'Easypaisa',
    'NayaPay',
    'Sadapay',
    'UBL Omnni',
    'Sim Sim',
    'PayMax',
    "Telenor finance"
  ];

  final RxList<String> transferProviderslist = [
    'Jazzcash',
    'UPaisa',
    'Easypaisa',
    'NayaPay',
    'Sadapay',
    'UBL Omnni',
    'Sim Sim',
    'PayMax',
    "Telenor finance"
  ].obs;

  final List<String> waterProviders = [
    'BWASA',
    'FWASA',
    'GWASA',
    'KWSAB',
    'HYDERABAD WASA',
    'LWASA',
    'MWASA',
    'QWASA'
  ];

  final RxList<String> waterProvidersList = [
    'BWASA',
    'FWASA',
    'GWASA',
    'KWSAB',
    'HYDERABAD WASA',
    'LWASA',
    'MWASA',
    'QWASA'
  ].obs;

  final List<String> gasProviders = [
    'SNGLP',
    'SSGC',
  ];

  final RxList<String> gasProviderslist = [
    'SNGLP',
    'SSGC',
  ].obs;

  RxList<String> filteredProviders = <String>[
    'GEPCO',
    'FESCO',
    'HAZECO',
    'HESCO',
    'IESCO',
    'LESCO',
    'MEPCO',
    'NEPRA'
  ].obs;

  void searchProviders(String query) {
    filteredProviders.value = electricityProviders
        .where(
            (provider) => provider.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  RxList<String> filteredGasProviders = <String>[
    'SNGLP',
    'SSGC',
  ].obs;

  void searchGasProviders(String query) {
    filteredGasProviders.value = gasProviders
        .where(
            (provider) => provider.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  RxList<String> filteredWaterProviders = <String>[
    'BWASA',
    'FWASA',
    'GWASA',
    'KWSAB',
    'HYDERABAD WASA',
    'LWASA',
    'MWASA',
    'QWASA'
  ].obs;

  void searchWaterProviders(String query) {
    filteredWaterProviders.value = gasProviders
        .where(
            (provider) => provider.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  RxList<String> filteredTransferProviders = <String>[
    'Jazzcash',
    'UPaisa',
    'Easypaisa',
    'NayaPay',
    'Sadapay',
    'UBL Omnni',
    'Sim Sim',
    'PayMax',
    "Telenor finance"
  ].obs;

  void searchTranferProviders(String query) {
    if (query.isEmpty) {
      filteredTransferProviders.value = transferProviderslist;
    } else {
      filteredTransferProviders.value = transferProviders
          .where((provider) =>
              provider.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
