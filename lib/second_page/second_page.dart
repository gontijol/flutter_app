import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:namer_app/second_page/controller.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ItemController>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();

    void showAddItemDialog() {
      List<TextEditingController> nameControllers = [TextEditingController()];
      List<TextEditingController> priceControllers = [TextEditingController()];
      List<TextEditingController> quantityControllers = [
        TextEditingController()
      ];

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text('Add Items'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          TextField(
                            controller: nameControllers[0],
                            decoration:
                                InputDecoration(labelText: 'Product Name'),
                          ),
                          TextField(
                            controller: priceControllers[0],
                            decoration: InputDecoration(labelText: 'Price'),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\,?\d{0,2}')),
                            ],
                          ),
                          TextField(
                            controller: quantityControllers[0],
                            decoration: InputDecoration(labelText: 'Quantity'),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            controller.addItem(
                              nameControllers[0].text,
                              double.tryParse(priceControllers[0]
                                      .text
                                      .replaceAll(',', '.')) ??
                                  0.0,
                              int.tryParse(quantityControllers[0].text) ?? 0,
                            );
                            // Clear the text fields
                            nameControllers[0].clear();
                            priceControllers[0].clear();
                            quantityControllers[0].clear();
                          });
                        },
                        child: Text('Add Another Product'),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                ],
              );
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Information Input'),
        actions: [
          IconButton(icon: Icon(Icons.home), onPressed: () => context.pop()),
        ],
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            Obx(() {
              return DataTable(
                columnSpacing: MediaQuery.of(context).size.width * 0.1,
                dividerThickness: 2,
                headingTextStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                dataTextStyle: TextStyle(
                  fontSize: 20,
                ),
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Product',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Center(
                      child: Text(
                        'Price',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Center(
                      child: Text(
                        'Quantity',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Center(
                      child: Text(
                        'Total Price',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Center(
                      child: Text(
                        'Actions',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ],
                rows: controller.items.map((item) {
                  return DataRow(
                    cells: <DataCell>[
                      DataCell(Center(
                          child: Text(textAlign: TextAlign.center, item.name))),
                      DataCell(Center(
                        child: Text(
                          '\$${item.price}',
                          textAlign: TextAlign.center,
                        ),
                      )),
                      DataCell(Center(
                        child: Text(
                          '${item.quantity}',
                          textAlign: TextAlign.center,
                        ),
                      )),
                      DataCell(Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          '\$${controller.getTotalPrice(item.price, item.quantity)}',
                        ),
                      )),
                      DataCell(Center(
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                nameController.text = item.name;
                                priceController.text = item.price.toString();
                                quantityController.text =
                                    item.quantity.toString();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                      builder: (context, setState) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          title: Text('Edit Item'),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextField(
                                                  controller: nameController,
                                                  decoration: InputDecoration(
                                                      labelText:
                                                          'Product Name'),
                                                ),
                                                TextField(
                                                  controller: priceController,
                                                  decoration: InputDecoration(
                                                      labelText: 'Price'),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(
                                                            r'^\d+\,?\d{0,2}')),
                                                  ],
                                                ),
                                                TextField(
                                                  controller:
                                                      quantityController,
                                                  decoration: InputDecoration(
                                                      labelText: 'Quantity'),
                                                  keyboardType:
                                                      TextInputType.number,
                                                ),
                                                SizedBox(height: 10),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                controller.updateItem(
                                                  controller.items
                                                      .indexOf(item),
                                                  nameController.text,
                                                  double.tryParse(
                                                          priceController.text
                                                              .replaceAll(
                                                                  ',', '.')) ??
                                                      0.0,
                                                  int.tryParse(
                                                          quantityController
                                                              .text) ??
                                                      0,
                                                );
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Save'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Cancel'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                controller.removeItem(
                                    controller.items.indexOf(item), context);
                              },
                            ),
                          ],
                        ),
                      )),
                    ],
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddItemDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
