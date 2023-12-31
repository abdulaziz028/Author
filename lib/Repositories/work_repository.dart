import 'package:author/models/Work.dart';
// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';

class WorkRepository {
  final Dio _dio = Dio();

  Future<List<Work>> listWork(String key) async {
    try {
      final response =
          await _dio.get('https://openlibrary.org/authors/$key/works.json');

      print('Received response jjj1: $response');

      final List<Work> works = [];

      for (final workResponse in response.data['entries']) {
        print('Received response jjj2: $workResponse');

        final work = Work(
          title: workResponse['title'],
          year: workResponse['created']['value'].substring(0, 4),
        );

        works.add(work);
      }

      print("Search had been made ${works.first}");

      return works;
    } catch (e) {
      throw Exception('Failed to fetch works');
    }
  }
}
