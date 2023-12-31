import 'package:author/models/Work.dart';
import 'package:author/Cubit/work_cubit.dart';
import 'package:author/Repositories/work_repository.dart';
import 'package:author/Cubit/work_state.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorWorkScreen extends StatelessWidget {
  const AuthorWorkScreen({required this.authorKey, super.key});
  final String authorKey;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>  WorkCubit(WorkRepository())..initializePage(authorKey),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text("Work List"),),
          body: BlocBuilder<WorkCubit, WorkState>(
            builder: (context, state) {
              if (state is WorkInitial) {}
              if (state is WorkLoaded) {
                return SingleChildScrollView(
                  child: Column(
                    children: state.works.map((e) => workCard(e)).toList(),
                  ),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Widget workCard(Work work) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            workInfo("title:", work.title),
            workInfo("year:", work.year),
          ],
        ),
      ),
    );
  }

Row workInfo(String label, String? info) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label),
      Expanded(
        child: Text(
          info ?? "Unknown",
          maxLines: 1,
          overflow: TextOverflow.ellipsis, // Add this line for ellipsis
        ),
      ),
    ],
  );
}

}
