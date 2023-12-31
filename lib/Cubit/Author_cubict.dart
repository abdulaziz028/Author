
import 'package:author/Repositories/author_repisority.dart';
import 'package:author/Cubit/author_state.dart';
import 'package:author/models/author.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorCubit extends Cubit<AuthorState>{
  final AuthorRepository authorRepository;
   AuthorCubit(this.authorRepository) : super(AuthorInitial());

   searchAuthor(String query)async{
    emit(AuthorLoading());
    List<Author> result = await authorRepository.searchAuthors(query);
    print("afadsfsd $result");
    emit(AuthorLoaded(result));
   }

}