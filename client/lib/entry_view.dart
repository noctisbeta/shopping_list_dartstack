import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_list/components/my_elevated_button.dart';
import 'package:shopping_list/components/my_loading_indicator.dart';
import 'package:shopping_list/components/my_text_field.dart';
import 'package:shopping_list/constants/colors.dart';
import 'package:shopping_list/room_service.dart';

class EntryView extends StatefulWidget {
  const EntryView({super.key});

  @override
  State<EntryView> createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView> {
  String code = '';
  bool requestInProgress = false;

  Future<void> handleEnterRoom() async {
    log('Entering room with access code: $code');

    optimisticPush() {
      context.go('/room/$code');
    }

    setState(() {
      requestInProgress = true;
    });

    final String? resCode = await RoomService.getRoomByCode(code);

    setState(() {
      requestInProgress = false;
    });

    if (resCode != null) {
      optimisticPush();
    } else {
      log('Room with access code $code does not exist');
    }
  }

  Future<void> handleCreateRoom() async {
    log('Creating room with access code: $code');

    optimisticPush() {
      context.go('/room/$code');
    }

    setState(() {
      requestInProgress = true;
    });

    final String? resCode = await RoomService.createRoom(code);

    setState(() {
      requestInProgress = false;
    });

    if (resCode != null) {
      optimisticPush();
    } else {
      log('Room with access code $code already exists');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Align(
        alignment: Alignment.center.add(const Alignment(0, -0.2)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: kSecondaryColor,
                blurRadius: 10,
                spreadRadius: 3,
                offset: Offset(0, 4),
              ),
            ],
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            border: Border.all(
              color: kQuaternaryColor,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Enter a room code',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kSecondaryColor,
                ),
              ),
              const SizedBox(height: 16),
              IgnorePointer(
                ignoring: requestInProgress,
                child: MyTextField(
                  label: 'Room code',
                  maxLength: 25,
                  onChanged: (value) {
                    setState(() {
                      code = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              switch (requestInProgress) {
                true => const MyLoadingIndicator(),
                false => Row(
                    children: [
                      Expanded(
                        child: MyElevatedButton(
                          label: 'Enter',
                          backgroundColor: kSecondaryColor,
                          onPressed: handleEnterRoom,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: MyElevatedButton(
                          label: 'Create',
                          backgroundColor: kQuaternaryColor,
                          onPressed: handleCreateRoom,
                        ),
                      ),
                    ],
                  ),
              },
            ],
          ),
        ),
      ),
    );
  }
}
