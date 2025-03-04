import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:namer_app/core/ui/colors.dart';
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
      controller.initializeControllers();

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
                      TextField(
                        controller: controller.nameControllers[0],
                        decoration: InputDecoration(
                          labelText: 'Product Name',
                          errorText: controller.nameControllers[0].text.isEmpty
                              ? 'Name cannot be empty'
                              : null,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: controller.priceControllers[0],
                        decoration: InputDecoration(
                          labelText: 'Price',
                          errorText: controller.priceControllers[0].text.isEmpty
                              ? 'Price cannot be empty'
                              : null,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\,?\d{0,2}')),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: controller.quantityControllers[0],
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                          errorText:
                              controller.quantityControllers[0].text.isEmpty
                                  ? 'Quantity cannot be empty'
                                  : null,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            controller.addItemFromDialog();
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
      body: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 1024,
          minWidth: 768,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Please enter the information below:'),
                Divider(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Obx(() {
                      return Container(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        padding: const EdgeInsets.all(20.0),
                        child: DataTable(
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
                                  style: TextStyle(fontStyle: FontStyle.italic),
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
                                    child: Text(
                                        textAlign: TextAlign.center,
                                        item.name))),
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
                                          controller.prepareEditItem(item);
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return StatefulBuilder(
                                                builder: (context, setState) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Colors.white,
                                                    title: Text('Edit Item'),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        TextField(
                                                          controller:
                                                              nameController,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      'Product Name'),
                                                        ),
                                                        SizedBox(height: 10),
                                                        TextField(
                                                          controller:
                                                              priceController,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      'Price'),
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .allow(RegExp(
                                                                    r'^\d+\,?\d{0,2}')),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10),
                                                        TextField(
                                                          controller:
                                                              quantityController,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      'Quantity'),
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                        ),
                                                        SizedBox(height: 20),
                                                      ],
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          controller.updateItem(
                                                            controller.items
                                                                .indexOf(item),
                                                            nameController.text,
                                                            double.tryParse(priceController
                                                                    .text
                                                                    .replaceAll(
                                                                        ',',
                                                                        '.')) ??
                                                                0.0,
                                                            int.tryParse(
                                                                    quantityController
                                                                        .text) ??
                                                                0,
                                                          );
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text('Save'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
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
                                              controller.items.indexOf(item),
                                              context);
                                        },
                                      ),
                                    ],
                                  ),
                                )),
                              ],
                            );
                          }).toList(),
                        ),
                      );
                    }),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 60),
                          width: MediaQuery.sizeOf(context).width * 0.15,
                          height: MediaQuery.sizeOf(context).height * 0.3,
                          child: Card(
                            color: principalColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total Price',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Obx(() {
                                    return Text(
                                      '\$${controller.getAllProductsTotalPrice()}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 60),
                          width: MediaQuery.sizeOf(context).width * 0.15,
                          height: MediaQuery.sizeOf(context).height * 0.5,
                          child: Card(
                            color: Colors.black.withAlpha(100),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Another Information',
                                              style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nec purus nec nunc ultricies ultricies. Nullam nec purus nec nunc ultricies ultricies.',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        context.pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: principalColor,
                                      ),
                                      child: Text('Checkout'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddItemDialog,
        backgroundColor: principalColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
