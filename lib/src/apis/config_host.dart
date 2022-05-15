import 'dart:convert';
import 'dart:io';

class AppData {
  // final String hostNodeServer = "bbe1-38-25-10-157.sa.ngrok.io"; //SERVER
  final String hostNodeServer = "192.168.18.6:5001"; //SERVER
  // final String hostNodeServer = "192.168.18.5:5000"; //LOCAL

  ///
  ///METODOS HTTP
  ///1. GET
  ///2. POST
  ///3. DELETE
  ///
  Future<dynamic> requestBadSsl(
    String _apiHost,
    String _routePath, {
    // Map<String, String>? headers,
    Map<String, String>? queryParameters,
    String? body,
    int method = 1,
  }) async {
    try {
      HttpClient client = HttpClient();
      client.badCertificateCallback = ((
        X509Certificate cert,
        String host,
        int port,
      ) =>
          true);

      final url = Uri.https(_apiHost, _routePath, queryParameters);

      HttpClientRequest request;

      switch (method) {
        case 1:
          request = await client.getUrl(url);
          break;
        case 2:
          request = await client
              .postUrl(url)
              .then((HttpClientRequest requestContent) {
            //ADD HEADERS
            requestContent.headers.add(
              'accept',
              'text/plain',
            );
            requestContent.headers.add(
              'Content-Type',
              'application/json',
            );

            requestContent.headers.contentLength = body!.length;
            requestContent.write(body);
            return requestContent;
          });
          // .then(
//           (HttpClientRequest request) {
//     request.headers.contentLength =
//         body.length;
//     request.write(body);
//     return request.close();
//   }).then((HttpClientResponse
//           response) async {
//     print(response.statusCode);
//     print(response.headers);
//     print(await response
//         .transform(UTF8.decoder)
//         .join());
//   });
// };
          break;
        case 3:
          request = await client.deleteUrl(url);
          break;
        default:
          request = await client.getUrl(url);
          break;
      }

      HttpClientResponse response = await request.close();

      if (response.statusCode == 200) {
        print("API ${response.statusCode} : $_routePath :) ");
        final decodedJson =
            jsonDecode(await response.transform(utf8.decoder).join());
        return decodedJson;
      }
      return null;
    } catch (e) {
      print("ERROR HTTP BAD CERTIFICATE: $e");
      return null;
    }
  }
}
