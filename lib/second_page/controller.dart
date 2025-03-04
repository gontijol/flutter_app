import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Item {
  String name;
  double price;
  int quantity;

  Item({required this.name, required this.price, required this.quantity});

  Item copyWith({String? name, double? price, int? quantity}) {
    return Item(
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }

  static Map<String, dynamic> mockJsonResponse = {
    'items': [
      {
        'name': 'Banana',
        'price': 10.0,
        'quantity': 2,
      },
      {
        'name': 'Abacate',
        'price': 20.0,
        'quantity': 1,
      },
      {
        'name': 'Item 3',
        'price': 15.0,
        'quantity': 5,
      },
      {
        'name': 'Item 3',
        'price': 15.0,
        'quantity': 5,
      },
      {
        'name': 'Item 3',
        'price': 15.0,
        'quantity': 5,
      },
      {
        'name': 'Item 3',
        'price': 15.0,
        'quantity': 5,
      },
      {
        'name': 'Item 3',
        'price': 15.0,
        'quantity': 5,
      },
      {
        'name': 'Item 3',
        'price': 15.0,
        'quantity': 5,
      },
      {
        'name': 'Item 3',
        'price': 15.0,
        'quantity': 5,
      },
      {
        'name': 'Item 3',
        'price': 15.0,
        'quantity': 5,
      },
      {
        'name': 'Item 3',
        'price': 15.0,
        'quantity': 5,
      },
      {
        'name': 'Item 3',
        'price': 15.0,
        'quantity': 5,
      },
      {
        'name': 'Item 3',
        'price': 15.0,
        'quantity': 5,
      },
      {
        'name': 'Item 3',
        'price': 15.0,
        'quantity': 5,
      },
      {
        'name': 'Item 3',
        'price': 15.0,
        'quantity': 5,
      },
      {
        'name': 'Item 3',
        'price': 15.0,
        'quantity': 5,
      },
      {
        'name': 'Item 3',
        'price': 15.0,
        'quantity': 5,
      },
      {
        'name': 'Item 3',
        'price': 15.0,
        'quantity': 5,
      },
      {
        'name': 'Item 3',
        'price': 15.0,
        'quantity': 5,
      },
      {
        'name': 'Item 3',
        'price': 15.0,
        'quantity': 5,
      },
      {
        'name': 'Item 3',
        'price': 15.0,
        'quantity': 5,
      },
      {
        'name': 'Item 3',
        'price': 15.0,
        'quantity': 5,
      },
      {
        'name': 'Item 3',
        'price': 15.0,
        'quantity': 5,
      },
    ],
  };
}

class ItemController extends GetxController {
  final RxList items = <Item>[].obs;
  List<TextEditingController> nameControllers = [];
  List<TextEditingController> priceControllers = [];
  List<TextEditingController> quantityControllers = [];

  @override
  void onInit() {
    super.onInit();

    loadMockItems();
    initializeControllers();
  }

  void loadMockItems() {
    var itemsJson =
        Item.mockJsonResponse['items'] as List<Map<String, dynamic>>;
    items.value = itemsJson.map((item) => Item.fromJson(item)).toList();
  }

  void addItem(String name, double price, int quantity) {
    items.add(Item(name: name, price: price, quantity: quantity));
  }

  void removeItem(int index, BuildContext context) {
    final removedItemName = items[index].name;
    items.removeAt(index);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Item removed: $removedItemName',
          ),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  void updateItem(int index, String name, double price, int quantity) {
    items[index] = Item(name: name, price: price, quantity: quantity);
  }

  double getTotalPrice(price, quantity) {
    return price * quantity;
  }

  getAllProductsTotalPrice() {
    return items.fold(
        0.0,
        (previousValue, element) =>
            getTotalPrice(element.price, element.quantity) + previousValue);
  }

  void updateItemQuantity(String name, int quantity) {
    var index = items.indexWhere((item) => item.name == name);
    if (index != -1) {
      items[index].quantity = quantity;
    }
  }

  void initializeControllers() {
    nameControllers = [TextEditingController()];
    priceControllers = [TextEditingController()];
    quantityControllers = [TextEditingController()];
  }

  void addItemFromDialog() {
    addItem(
      nameControllers[0].text,
      double.tryParse(priceControllers[0].text.replaceAll(',', '.')) ?? 0.0,
      int.tryParse(quantityControllers[0].text) ?? 0,
    );
    nameControllers[0].clear();
    priceControllers[0].clear();
    quantityControllers[0].clear();
  }

  void prepareEditItem(Item item) {
    nameControllers[0].text = item.name;
    priceControllers[0].text = item.price.toString();
    quantityControllers[0].text = item.quantity.toString();
  }
}
