import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenify/config/constants/app_colors.dart';
import 'package:screenify/features/movie/domain/entities/ticket.dart';
import 'package:screenify/features/movie/presentation/screens/movie_details_screen.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TicketPageBuilderWidget extends StatefulWidget {
  final List<Ticket> tickets;

  const TicketPageBuilderWidget({required this.tickets, super.key});

  @override
  State<TicketPageBuilderWidget> createState() =>
      _TicketPageBuilderWidgetState();
}

class _TicketPageBuilderWidgetState extends State<TicketPageBuilderWidget> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: widget.tickets.length,
      itemBuilder: (context, index) {
        final ticket = widget.tickets[index];
        return Center(
          child: TicketWidget(
            color: Theme.of(context).colorScheme.onSecondary,
            isCornerRounded: true,
            padding: EdgeInsets.zero,
            width: MediaQuery.sizeOf(context).width / 1.4,
            height: MediaQuery.sizeOf(context).height / 1.4,
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Image.network(
                      ticket.posterUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Divider(
                //   color: Theme.of(context).colorScheme.onPrimary,
                //   indent: 3,
                // ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(color: AppColors.lightPurple80),
                      right: BorderSide(color: AppColors.lightPurple80),
                      bottom: BorderSide(color: AppColors.lightPurple80),
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.darkBlue,
                        Color(0xFF11079E),
                      ],
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: AppColors.whiteColor),
                                '${AppLocalizations.of(context)!.title}: ${ticket.title}',
                              ),
                              Text(
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: AppColors.whiteColor),
                                '${AppLocalizations.of(context)!.room}: ${ticket.roomName}',
                              ),
                              Text(
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: AppColors.whiteColor),
                                '${AppLocalizations.of(context)!.date}: ${DateFormat.yMd(
                                  PlatformDispatcher.instance.locale.toString(),
                                ).format(
                                  ticket.startTime,
                                )}',
                              ),
                              Text(
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: AppColors.whiteColor),
                                '${AppLocalizations.of(context)!.time}: ${DateFormat.Hm().format(
                                  ticket.startTime,
                                )}',
                              ),
                              Text(
                                '${AppLocalizations.of(context)!.seat}: ${ticket.seatNum.toString()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: AppColors.whiteColor),
                              ),
                              Text(
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: AppColors.whiteColor),
                                '${AppLocalizations.of(context)!.duration}: ${formatDuration(ticket.duration)}',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: QrImageView(
                          dataModuleStyle: QrDataModuleStyle(
                            dataModuleShape: QrDataModuleShape.square,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          eyeStyle: QrEyeStyle(
                            eyeShape: QrEyeShape.square,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          size: 100,
                          version: QrVersions.auto,
                          data: ticket.id.toString(),
                          gapless: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
