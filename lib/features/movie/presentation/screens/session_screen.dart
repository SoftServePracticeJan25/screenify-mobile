import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:screenify/features/movie/domain/entities/movie.dart';

class SessionScreen extends StatefulWidget {
  final Movie movie;
  const SessionScreen({required this.movie, super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.chooseSession,
          style: Theme.of(context).textTheme.headlineSmall,
          
        ),
      ),
      body: Center(child: Text(widget.movie.title),),
    );
  }
}
