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

  final List<String> insuranceProviders = [
    'Car Insurance',
    'Bike Insurance',
    'Life Insurance',
    'Health Insurance',
    'Corona Insurance',
    'Cargo Insurance',
    'Home Insurance',
  ];

  final RxList<String> filteredInsuranceProvidersPrice = [
    '1000',
    '500',
    '5000',
    '2000',
    '500',
    '1000',
    '5000',
  ].obs;

  final RxList<String> packages = [
    'Weekly Super',
    'Monthly Youtube',
    'Monthly Snapchat',
    'Weekly Premium Plus',
    'Weekly Instagram',
    'Daily',
    'Monthly Max',
  ].obs;

  final RxList<String> packagesPrice = [
    '480',
    '99',
    '99',
    '350',
    '100',
    '50',
    '1600',
  ].obs;

  final RxList<String> packagesValidity = [
    '7',
    '30',
    '30',
    '7',
    '7',
    '1',
    '30',
  ].obs;

  final RxList<String> minutes = [
    '120',
    '00',
    '00',
    '150',
    '00',
    '50',
    '300',
  ].obs;

  final RxList<String> messages = [
    '200',
    '20',
    '20',
    '7',
    '7',
    '20',
    '300',
  ].obs;

  final RxList<String> gbs = [
    '20',
    '10',
    '10',
    '9',
    '5',
    '2',
    '30',
  ].obs;

  final RxList<String> filteredInsuranceProviders = [
    'Car Insurance',
    'Bike Insurance',
    'Life Insurance',
    'Health Insurance',
    'Corona Insurance',
    'Cargo Insurance',
    'Home Insurance',
  ].obs;

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

  void searchInsuranceProviders(String query) {
    filteredInsuranceProviders.value = insuranceProviders
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
