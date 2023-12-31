// ignore: file_names
import 'dart:async';

import 'package:author/Cubit/Author_cubict.dart';
import 'package:author/Cubit/author_state.dart';
import 'package:author/Repositories/author_repisority.dart';
import 'package:author/models/author.dart';




import 'package:author/screens/authors_workscreen.dart';

import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AuthorSearchScreen extends StatelessWidget {
  AuthorSearchScreen({super.key});

  final TextEditingController _searchController = TextEditingController();
  final AuthorCubit cubit = AuthorCubit(AuthorRepository());
  late Timer _debounce = Timer(Duration.zero, () {});

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Authors'),
      ),
      body: BlocProvider(
        create: (context) => cubit,
        child: Column(
          children: [
            searchField(context),
            BlocBuilder<AuthorCubit, AuthorState>(
              builder: (context, state) {
                if (state is AuthorInitial) {
                  return title();
                } else if (state is AuthorLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is AuthorLoaded) {
                  return searchResult(state);
                } else if (state is AuthorError) {
                  return errorMessage(state);
                } else {
                  return Container(); // Handle other states if needed
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Center title() {
    return const Center(
      child: Text('Enter a query to search for authors'),
    );
  }

  Center errorMessage(AuthorError state) {
    return Center(
      child: Text(state.message), // Display error message
    );
  }

  Expanded searchResult(AuthorLoaded state) {
    return Expanded(
      child: ListView.builder(
        itemCount: state.authors.length,
        itemBuilder: (context, index) {
          final author = state.authors[index];
          return authorCard(context, author);
        },
      ),
    );
  }

  Widget authorCard(BuildContext context, Author author) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> AuthorWorkScreen(authorKey: author.key)));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              authorInfo("Name:", author.name),
              authorInfo("Birth Date:", author.birthDate),
              authorInfo("Top work:", author.topWork),
            ],
          ),
        ),
      ),
    );
  }

  Row authorInfo(String label, String? info) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Expanded(
          child: Text(info ?? "Unknown",maxLines: 1,
            overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }

  Padding searchField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: 'Search Authors',
        ),
        onChanged: (query) {
          if (_debounce.isActive) _debounce.cancel();
          _debounce = Timer(const Duration(seconds: 2), () {
            if(query.isNotEmpty){
              cubit.searchAuthor(query);
            }
           
          });
        },
      ),
    );
  }
}
