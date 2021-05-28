import 'package:dragonballhub/repository/api_news.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

import 'api_news_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('API testing', () {
    test('fetch recent news - case of Success', () async {
      final client = MockClient();

      when(client.get(Uri.http('10.0.2.2:8080', '/test/rest_api/get_recent_news.php')))
          .thenAnswer((_) async => http.Response('{"recent_news" : []}', 200));

      final api = ApiNews(client: client);
      expect(await api.fetchRecentNews(), isA<http.Response>());
    });

    test('fetch recent news - case of Failure', () async {
      final client = MockClient();

      when(client.get(Uri.http('10.0.2.2:8080', '/test/rest_api/get_recent_news.php')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final api = ApiNews(client: client);
      expect(api.fetchRecentNews(), throwsException);
    });

    test('fetch manga news - case of Success', () async {
      final client = MockClient();

      when(client.get(Uri.http('10.0.2.2:8080', '/test/rest_api/get_manga_news.php')))
          .thenAnswer((_) async => http.Response('{"manga_news" : []}', 200));

      final api = ApiNews(client: client);
      expect(await api.fetchMangaNews(), isA<http.Response>());
    });

    test('fetch manga news - case of Failure', () async {
      final client = MockClient();

      when(client.get(Uri.http('10.0.2.2:8080', '/test/rest_api/get_manga_news.php')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final api = ApiNews(client: client);
      expect(api.fetchMangaNews(), throwsException);
    });

    test('fetch dbs news - case of Success', () async {
      final client = MockClient();

      when(client.get(Uri.http('10.0.2.2:8080', '/test/rest_api/get_dbs_news.php')))
          .thenAnswer((_) async => http.Response('{"dbs_news" : []}', 200));

      final api = ApiNews(client: client);
      expect(await api.fetchDbSuperNews(), isA<http.Response>());
    });

    test('fetch dbs news - case of Failure', () async {
      final client = MockClient();

      when(client.get(Uri.http('10.0.2.2:8080', '/test/rest_api/get_dbs_news.php')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final api = ApiNews(client: client);
      expect(api.fetchDbSuperNews(), throwsException);
    });

    test('fetch dbz news - case of Success', () async {
      final client = MockClient();

      when(client.get(Uri.http('10.0.2.2:8080', '/test/rest_api/get_dbz_news.php')))
          .thenAnswer((_) async => http.Response('{"dbz_news" : []}', 200));

      final api = ApiNews(client: client);
      expect(await api.fetchDbZNews(), isA<http.Response>());
    });

    test('fetch dbz news - case of Failure', () async {
      final client = MockClient();

      when(client.get(Uri.http('10.0.2.2:8080', '/test/rest_api/get_dbz_news.php')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final api = ApiNews(client: client);
      expect(api.fetchDbZNews(), throwsException);
    });

    test('fetch db news - case of Success', () async {
      final client = MockClient();

      when(client.get(Uri.http('10.0.2.2:8080', '/test/rest_api/get_db_news.php')))
          .thenAnswer((_) async => http.Response('{"db_news" : []}', 200));

      final api = ApiNews(client: client);
      expect(await api.fetchDbNews(), isA<http.Response>());
    });

    test('fetch db news - case of Failure', () async {
      final client = MockClient();

      when(client.get(Uri.http('10.0.2.2:8080', '/test/rest_api/get_db_news.php')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final api = ApiNews(client: client);
      expect(api.fetchDbNews(), throwsException);
    });

    test('fetch videogames news - case of Success', () async {
      final client = MockClient();

      when(client.get(Uri.http('10.0.2.2:8080', '/test/rest_api/get_videogames_news.php')))
          .thenAnswer((_) async => http.Response('{"videogames_news" : []}', 200));

      final api = ApiNews(client: client);
      expect(await api.fetchVideogamesNews(), isA<http.Response>());
    });

    test('fetch videogames news - case of Failure', () async {
      final client = MockClient();

      when(client.get(Uri.http('10.0.2.2:8080', '/test/rest_api/get_videogames_news.php')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final api = ApiNews(client: client);
      expect(api.fetchVideogamesNews(), throwsException);
    });
  });
}