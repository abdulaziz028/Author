
import 'package:author/models/author.dart';
// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';

class AuthorRepository {
  final Dio _dio = Dio();

  Future<List<Author>> searchAuthors(String query) async {
    print('Fetching authors for query: $query');
    try {
      final response = await _dio.get(
        'https://openlibrary.org/search/authors.json',
        queryParameters: {'q': query},
      );
      print('Received response 1: $response');

      final List<Author> authors = [];

      for (final authorResponse in response.data['docs']) {
        print('Received response 2: $authorResponse');
        final author = Author(
          key: authorResponse['key'],
          name: authorResponse['name'],
          birthDate: authorResponse['birth_date'],
          deathDate: authorResponse['death_date'],
          topWork: authorResponse['top_work'],
        );
        authors.add(author);
      }
      print("search had been made ${authors.first}");

      return authors;
    } catch (e) {
      throw Exception('Failed to fetch authors');
    }
  }
}
