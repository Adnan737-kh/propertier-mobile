import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RentalViewModel extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> areaType = <String>[
    'Commerical',
    'Residential',
  ];
  List<String> propertyType = <String>[
    'Banglo',
    'House',
    'Villa',
    'Mansion',
    'Plot',
    'Farm Houses',
    'Rooms',
  ];
  List<String> areaUnitType = <String>[
    'Square Foot',
    'Marla',
    'kanal',
    'Acre',
  ];
  List<String> bedrooms = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
  ];

  List<String> bathrooms = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
  ];
  List<String> floors = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
  ];

  var facilities = <String>[
    'Parking space',
    'Waste disposal',
    'Furnished',
    'Lounge Sitting rooms',
    'Servant Quater',
    'Drawing Room',
    'Store Room',
    'Study Room',
    'Laundry Rooms',
    'Electricity Room',
  ].obs;
  var selectedFacilities = <String>[].obs;

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
