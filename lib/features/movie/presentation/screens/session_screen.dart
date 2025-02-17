import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:screenify/config/constants/app_colors.dart';
import 'package:screenify/features/movie/domain/entities/movie.dart';
import 'package:screenify/features/movie/presentation/blocs/session_bloc/session_bloc.dart';
import 'package:screenify/features/movie/presentation/blocs/ticket_bloc/ticket_bloc.dart';
import 'package:screenify/features/movie/presentation/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:screenify/features/movie/presentation/screens/movie_details_screen.dart';
import 'package:screenify/features/movie/presentation/shared/buy_ticket_dialog.dart';
import 'package:screenify/features/movie/presentation/shared/screenify_progress_indicator.dart';

class SessionScreen extends StatefulWidget {
  final Movie movie;

  const SessionScreen({required this.movie, super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<SessionBloc>()
        .add(GetSessionsByMovieIdEvent(movieId: widget.movie.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 10,
        shadowColor: Theme.of(context).colorScheme.primary,
        title: Text(
          AppLocalizations.of(context)!.chooseSession,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: BlocConsumer<SessionBloc, SessionState>(
        listener: (context, state) {
          if (state is SessionFailed) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is SessionLoading) {
            return const ScreenifyProgressIndicator();
          } else if (state is SessionLoaded) {
            return state.sessions.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider(color: AppColors.lightPurple80);
                    },
                    itemCount: state.sessions.length,
                    itemBuilder: (context, index) {
                      final session = state.sessions[index];
                      return BlocListener<TicketBloc, TicketState>(
                        listener: (context, state) {
                          if (state is TicketBought) {
                            ScaffoldMessenger.of(context)
                                .hideCurrentMaterialBanner();
                            ScaffoldMessenger.of(context)
                                .showMaterialBanner(MaterialBanner(
                              content: Text(
                                AppLocalizations.of(context)!
                                    .thankYouForPurchase,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: ScaffoldMessenger.of(context)
                                      .hideCurrentMaterialBanner,
                                  child: const Text("OK"),
                                ),
                              ],
                            ));
                          }
                        },
                        child: InkWell(
                          onTap: () async {
                            final ticketBloc = context.read<TicketBloc>();
                            final res = await showDialog<int>(
                              context: context,
                              builder: (context) {
                                return BuyTicketDialog(
                                  session: session,
                                );
                              },
                            );
                            if (res == null) return;
                            ticketBloc.add(
                              CreateTicketEvent(
                                seatNum: res,
                                sessionId: session.id,
                                transactionId: (context
                                        .read<TransactionBloc>()
                                        .state as TransactionLoaded)
                                    .transaction
                                    .id,
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Image.network(
                                widget.movie.posterUrl,
                                width: MediaQuery.sizeOf(context).width / 3.5,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    spacing: 5,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.title,
                                          ),
                                          Text(
                                            widget.movie.title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .duration,
                                          ),
                                          Text(
                                            formatDuration(
                                                widget.movie.duration),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.date,
                                          ),
                                          Text(
                                            DateFormat.yMd(
                                              PlatformDispatcher.instance.locale
                                                  .toString(),
                                            ).format(
                                              session.startTime,
                                            ),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.room,
                                          ),
                                          Text(
                                            session.roomName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(
                        AppLocalizations.of(context)!.noSessions,
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
