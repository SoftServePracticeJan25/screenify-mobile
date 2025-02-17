import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenify/config/constants/app_images.dart';
import 'package:screenify/features/movie/presentation/blocs/ticket_bloc/ticket_bloc.dart';
import 'package:screenify/features/movie/presentation/shared/screenify_progress_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:screenify/features/movie/presentation/shared/ticket_page_builder_widget.dart';

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
                ? TicketPageBuilderWidget(tickets: state.tickets)
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
