import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

//TODO: add timeout
class ApiNews {
  var client;
  ApiNews() {
    this.client = http.Client();
  }

  Future<http.Response> fetchNews(Uri url) async {
    try {
      var response = await this.client.get(url).timeout(
        Duration(seconds: 2),
        onTimeout: () {
          throw TimeoutException("Timeout Exception");
        }
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        print('Request failed with status: ${response.statusCode}.');
        throw Exception('Couldn\'t load news.');
      }
    } on TimeoutException catch (e) {
      rethrow;
    } on SocketException {
      rethrow;
    }
  }

  // ENDPOINTS

  Future<http.Response> fetchRecentNews() async {
    var url = Uri.http('10.0.2.2:8080', '/test/rest_api/get_recent_news.php');
    return fetchNews(url);
  }

  Future<http.Response> fetchMangaNews() async {
    var url = Uri.http('10.0.2.2:8080', '/test/rest_api/get_manga_news.php');
    return fetchNews(url);
  }

  Future<http.Response> fetchDbSuperNews() async {
    var url = Uri.http('10.0.2.2:8080', '/test/rest_api/get_dbs_news.php');
    return fetchNews(url);
  }

  Future<http.Response> fetchDbZNews() async {
    var url = Uri.http('10.0.2.2:8080', '/test/rest_api/get_dbz_news.php');
    return fetchNews(url);
  }

  Future<http.Response> fetchDbNews() async {
    var url = Uri.http('10.0.2.2:8080', '/test/rest_api/get_db_news.php');
    return fetchNews(url);
  }

  Future<http.Response> fetchVideogamesNews() async {
    var url = Uri.http('10.0.2.2:8080', '/test/rest_api/get_videogames_news.php');
    return fetchNews(url);
  }
}