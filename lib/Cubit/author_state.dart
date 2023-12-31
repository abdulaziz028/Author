



import 'package:author/models/author.dart';

abstract class AuthorState {}

class AuthorInitial extends AuthorState {}

class AuthorLoading extends AuthorState {}

class AuthorLoaded extends AuthorState {
  final List<Author> authors;

  AuthorLoaded(this.authors);

  AuthorLoaded copyWith({List<Author>? authors}) {
    return AuthorLoaded(authors ?? this.authors);
  }
}


class AuthorError extends AuthorState {
  final String message;

  AuthorError(this.message);
}
