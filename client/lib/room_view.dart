import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_list/add_item_dialog.dart';
import 'package:shopping_list/constants/colors.dart';
import 'package:shopping_list/shopping_list_item.dart';
import 'package:shopping_list/shopping_list_service.dart';

class RoomView extends StatefulWidget {
  const RoomView({
    required this.code,
    super.key,
  });

  final String code;

  @override
  State<RoomView> createState() => _RoomViewState();
}

class _RoomViewState extends State<RoomView> {
  late Future<List<ShoppingListItem>> itemsFuture;

  @override
  void initState() {
    super.initState();

    itemsFuture = ShoppingListService.getShoppingList(widget.code);
    // setFuture();
  }

  void setFuture() {
    setState(() {
      itemsFuture = ShoppingListService.getShoppingList(widget.code);
    });
  }

  void handleAddItem() {
    showDialog(
      context: context,
      builder: (context) => AddItemDialog(
        code: widget.code,
      ),
    ).then((value) => setFuture());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: () => setFuture(),
            icon: const Icon(Icons.refresh),
          ),
        ],
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
          child: FutureBuilder<List<ShoppingListItem>>(
        future: itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
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
                    '${snapshot.data![index].quantity} x ${snapshot.data![index].price}€ (${snapshot.data![index].quantity * snapshot.data![index].price}€)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade100,
                      // color: kPrimaryColor,
                      fontSize: 16,
                    ),
                  ),
                  value: snapshot.data![index].isBought,
                  onChanged: (value) {
                    setState(() {
                      snapshot.data![index].isBought = value!;
                    });
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
      )),
    );
  }
}
