import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenify/config/constants/app_images.dart';
import 'package:screenify/features/movie/presentation/blocs/ticket_bloc/ticket_bloc.dart';
import 'package:screenify/features/movie/presentation/screens/movie_details_screen.dart';
import 'package:screenify/features/movie/presentation/shared/screenify_progress_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? AppImages.mainBackgroundDark
                : AppImages.mainBackgroundLight,
          ),
        ),
      ),
      child: BlocConsumer<TicketBloc, TicketState>(
        listener: (context, state) {
          if (state is TicketFailed) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is TicketLoaded) {
            return state.tickets.isNotEmpty
                ? ListView.builder(
              reverse: true,
                    itemCount: state.tickets.length,
                    itemBuilder: (context, index) {
                      final ticket = state.tickets[index];
                      return ListTile(
                        title: Text(ticket.title),
                        subtitle: Text(ticket.id.toString()),
                        leading: Text(ticket.roomName),
                        trailing: Text(
                          formatDuration(ticket.duration),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      AppLocalizations.of(context)!.noTickets,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  );
          } else if (state is TicketLoading) {
            return const Center(
              child: ScreenifyProgressIndicator(),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
