import 'dart:async';
import 'dart:developer';

import 'package:common/items/item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_list/components/add_item_dialog.dart';
import 'package:shopping_list/constants/colors.dart';
import 'package:shopping_list/controllers/item_service.dart';

class RoomView extends StatefulWidget {
  const RoomView({
    required this.code,
    required this.itemService,
    super.key,
  });

  final String code;

  final ItemService itemService;

  @override
  State<RoomView> createState() => _RoomViewState();
}

class _RoomViewState extends State<RoomView> {
  Stream<List<Item>>? itemStream;

  @override
  void initState() {
    super.initState();

    itemStream = widget.itemService.itemStream();
  }

  @override
  void dispose() {
    unawaited(widget.itemService.dispose());
    super.dispose();
  }

  Future<void> handleAddItem() async {
    await showDialog(
      context: context,
      builder: (context) => AddItemDialog(
        code: widget.code,
        onItemAdded: widget.itemService.addItem,
      ),
    );
  }

  Future<void> handleItemChecked(int id, {required bool checked}) async {}

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: kQuaternaryColor,
        appBar: AppBar(
          centerTitle: true,
          shadowColor: Colors.black,
          elevation: 6,
          title: Text(
            'Room ${widget.code}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: kSecondaryColor,
          leading: IconButton(
            color: Colors.white,
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        floatingActionButton: DecoratedBox(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: kQuaternaryColor,
                blurRadius: 10,
                spreadRadius: 3,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: FloatingActionButton(
            elevation: 6,
            onPressed: handleAddItem,
            backgroundColor: kSecondaryColor,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
          child: StreamBuilder<List<Item>>(
            stream: widget.itemService.itemStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final quantity = snapshot.data![index].quantity;
                    final price = snapshot.data![index].price;

                    return CheckboxListTile(
                      secondary: IconButton(
                        onPressed: () async {},
                        icon: Icon(
                          Icons.delete,
                          color: Colors.grey.shade100,
                        ),
                      ),
                      activeColor: kSecondaryColor,
                      checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      side: const BorderSide(
                        color: kSecondaryColor,
                        width: 2,
                      ),
                      title: Stack(
                        children: [
                          Text(
                            snapshot.data![index].name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        '$quantity x $price€ (${quantity * price}€)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade100,
                          // color: kPrimaryColor,
                          fontSize: 16,
                        ),
                      ),
                      value: snapshot.data![index].checked,
                      onChanged: (value) async {
                        log('Value: $value');
                        return handleItemChecked(
                          snapshot.data![index].id,
                          checked: value!,
                        );
                      },
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      );
}
