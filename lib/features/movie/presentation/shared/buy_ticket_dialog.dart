import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenify/features/movie/domain/entities/session.dart';
import 'package:screenify/features/movie/domain/entities/transaction.dart';
import 'package:screenify/features/movie/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:screenify/features/movie/presentation/blocs/room_bloc/room_bloc.dart';
import 'package:screenify/features/movie/presentation/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:screenify/features/movie/presentation/shared/screenify_progress_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuyTicketDialog extends StatefulWidget {
  final Session session;

  const BuyTicketDialog({required this.session, super.key});

  @override
  State<BuyTicketDialog> createState() => _BuyTicketDialogState();
}

class _BuyTicketDialogState extends State<BuyTicketDialog> {
  int? selectedSeat; // Track selected seat

  @override
  void initState() {
    super.initState();
    context
        .read<RoomBloc>()
        .add(GetRoomByIdEvent(roomId: widget.session.roomId));
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = (context.read<AuthBloc>().state as AuthLoaded).userInfo;
    return Dialog(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.8),
      child: BlocConsumer<RoomBloc, RoomState>(
        listener: (context, state) {
          if (state is RoomFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is RoomLoaded) {
            int seatsAmount = state.room.seatsAmount;
            int columns = (seatsAmount / 9).ceil();

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// 🎬 **Curved Movie Screen**
                  ClipPath(
                    clipper: MovieScreenClipper(),
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      color: Theme.of(context).colorScheme.primary,
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.screen,
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// 🪑 **Seats Grid**
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: seatsAmount,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      bool isSelected = selectedSeat == index + 1;
                      return Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSeat = index + 1;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color:
                                  isSelected ? Colors.green : Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        style: Theme.of(context).textTheme.titleMedium,
                        AppLocalizations.of(context)!.seat,
                      ),
                      Text(
                        (selectedSeat ?? "").toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox.shrink(),
                      const SizedBox.shrink(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        style: Theme.of(context).textTheme.titleMedium,
                        AppLocalizations.of(context)!.price,
                      ),
                      Text(
                        style: Theme.of(context).textTheme.titleMedium,
                        '${widget.session.price.toInt().toString()}\$',
                      ),
                      const SizedBox.shrink(),
                      const SizedBox.shrink(),
                    ],
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height / 9),

                  /// 🎟️ **Buy Ticket Button**
                  BlocListener<TransactionBloc, TransactionState>(
                    listener: (context, state) {
                      if (state is TransactionLoaded) {
                        Navigator.of(context).pop(selectedSeat);
                      }
                      if (state is TransactionFailed) {
                        print(state.message);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                    },
                    child: OutlinedButton(
                      onPressed: selectedSeat == null
                          ? null
                          : () {
                              context.read<TransactionBloc>().add(
                                    CreateTransactionEvent(
                                      transaction: Transaction(
                                        id: 0,
                                        sum: widget.session.price.toInt(),
                                        creationTime: DateTime.now(),
                                        appUserId: userInfo.id,
                                      ),
                                    ),
                                  );
                            },
                      child: Text(AppLocalizations.of(context)!.buyTicket),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is RoomLoading) {
            return const Center(child: ScreenifyProgressIndicator());
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class MovieScreenClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(
      size.width / 2,
      size.height * 1.4,
      size.width,
      size.height * 0.7,
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
