import 'package:http/http.dart' as http;

class DbhServer {
  Future<http.Response?> fetchMangaNews() async {
    var url = Uri.http('localhost:8080', '/test/rest_api/get_manga_news.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<http.Response?> fetchDbsNews() async {
    var url = Uri.http('localhost:8080', '/test/rest_api/get_dbs_news.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<http.Response?> fetchDbzNews() async {
    var url = Uri.http('localhost:8080', '/test/rest_api/get_dbz_news.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<http.Response?> fetchVideogamesNews() async {
    var url = Uri.http('localhost:8080', '/test/rest_api/get_videogames_news.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}