import 'package:common/rooms/room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_list/components/my_elevated_button.dart';
import 'package:shopping_list/components/my_loading_indicator.dart';
import 'package:shopping_list/components/my_text_field.dart';
import 'package:shopping_list/constants/colors.dart';
import 'package:shopping_list/controllers/bloc/room_bloc.dart';
import 'package:shopping_list/controllers/bloc/room_event.dart';
import 'package:shopping_list/controllers/bloc/room_state.dart';

class EntryView extends StatefulWidget {
  const EntryView({super.key});

  @override
  State<EntryView> createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView> {
  RoomBloc get roomBloc => context.read<RoomBloc>();
  String code = '';

  void showToast(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: kQuaternaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        action: SnackBarAction(
          label: 'Create',
          textColor: Colors.white,
          backgroundColor: kSecondaryColor,
          onPressed: () => roomBloc.add(
            CreateRoomEvent(code),
          ),
        ),
        content: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> blocListener(BuildContext context, RoomState state) async {
    switch (state) {
      case RSerror():
        showToast(state.message);
      case RScreated(:final room) || RSentered(:final room):
        await context.push('/room/${room.code}');
      default:
    }
  }

  @override
  Widget build(BuildContext context) => BlocListener<RoomBloc, RoomState>(
        listener: blocListener,
        child: Scaffold(
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
              child: BlocBuilder<RoomBloc, RoomState>(
                builder: (context, state) {
                  final isLoading = state is RSloading;

                  return Column(
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
                        ignoring: isLoading,
                        child: MyTextField(
                          label: 'Room code',
                          maxLength: Room.maxCodeLength,
                          onChanged: (value) {
                            setState(() {
                              code = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      switch (isLoading) {
                        true => const MyLoadingIndicator(),
                        false => Row(
                            children: [
                              Expanded(
                                child: MyElevatedButton(
                                  label: 'Enter',
                                  backgroundColor: kSecondaryColor,
                                  onPressed: () => roomBloc.add(
                                    EnterRoomEvent(code),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: MyElevatedButton(
                                  label: 'Create',
                                  backgroundColor: kQuaternaryColor,
                                  onPressed: () => roomBloc.add(
                                    CreateRoomEvent(code),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      },
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      );
}
