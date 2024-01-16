import 'package:flutter/material.dart';
import 'package:shopping_list/components/my_elevated_button.dart';
import 'package:shopping_list/components/my_loading_indicator.dart';
import 'package:shopping_list/components/my_text_field.dart';
import 'package:shopping_list/constants/colors.dart';
import 'package:shopping_list/shopping_list_service.dart';

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({
    required this.code,
    super.key,
  });

  final String code;

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  String itemName = '';
  int quantity = 0;
  double price = 0;
  bool loading = false;

  Future<void> handleAddItem() async {
    setState(() {
      loading = true;
    });

    void popDialog() {
      Navigator.of(context).pop();
    }

    void errorSnackbar() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error adding item'),
        ),
      );
    }

    final res = await ShoppingListService.addShoppingListItem(
      name: itemName,
      quantity: quantity,
      price: price,
      code: widget.code,
    );

    setState(() {
      loading = false;
    });

    if (res != null) {
      popDialog();
    } else {
      errorSnackbar();
    }
  }

  @override
  Widget build(BuildContext context) => Material(
        type: MaterialType.transparency,
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                border: Border.all(
                  color: kSecondaryColor,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyTextField(
                    label: 'Item Name',
                    inverted: true,
                    onChanged: (value) {
                      itemName = value;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: MyTextField(
                          label: 'Quantity',
                          inverted: true,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            quantity = int.parse(value);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: MyTextField(
                          label: 'Price',
                          inverted: true,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            price = double.parse(value);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  switch (loading) {
                    true => const MyLoadingIndicator(),
                    false => MyElevatedButton(
                        label: 'Add Item',
                        backgroundColor: kQuaternaryColor,
                        onPressed: handleAddItem,
                      ),
                  },
                ],
              ),
            ),
          ),
        ),
      );
}
