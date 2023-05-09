import 'dart:convert';
import 'package:cinema_booking/data/models/comment_model.dart';
import 'package:cinema_booking/data/models/film_model.dart';
import 'package:cinema_booking/data/models/session_model.dart';
import 'package:cinema_booking/data/models/ticket_model.dart';
import 'package:cinema_booking/data/models/user_model.dart';
import 'package:cinema_booking/domain/entities/comment.dart';
import 'package:cinema_booking/domain/entities/film.dart';
import 'package:cinema_booking/domain/entities/films_session.dart';
import 'package:cinema_booking/domain/entities/payment_card_data.dart';
import 'package:cinema_booking/domain/entities/ticket.dart';
import 'package:cinema_booking/domain/entities/user.dart';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';

class DataSource {
  late Dio dio;
  static const String _secretKey = '2jukqvNnhunHWMBRRVcZ9ZQ9';

  DataSource() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fs-mt.qwerty123.tech',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      ),
    );
    //TODO delete debug interceptor
    dio.interceptors.add(InterceptorsWrapper(
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        print('Got a response $response');
        return handler.next(response);
      },
      onError: (DioError e, ErrorInterceptorHandler handler) {
        print('Got an error $e');
        print('Error message ${e.message}');
        print('Error body ${e.response}');
        return handler.next(e);
      },
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        print(
            'make request with data ${options.data}\n and headers ${options.headers}\n ${options.path}');
        return handler.next(options);
      },
    ));
  }

  set authToken(v) {
    dio.options.headers['Authorization'] = 'Bearer $v';
  }

  Future<String> getSessionToken() async {
    var response = await dio.post('/api/auth/session');
    if (response.statusCode == 200) {
      if (response.data['success']) {
        return response.data['data']['sessionToken'];
      } else {
        throw Exception(response.data['data']);
      }
    } else {
      throw Exception('Connection failed ${response.statusCode}');
    }
  }

  Future<String> getAccessToken(String sessionToken, String deviceId) async {
    var response = await dio.post('/api/auth/token', data: {
      'sessionToken': sessionToken,
      'signature':
          sha256.convert(utf8.encode(sessionToken + _secretKey)).toString(),
      'deviceId': BigInt.parse(deviceId, radix: 16).toString()
    });
    if (response.statusCode == 200) {
      if (response.data['success']) {
        return response.data['data']['sessionToken'];
      } else {
        throw Exception(response.data['data']);
      }
    } else {
      throw Exception('Connection failed ${response.statusCode}');
    }
  }

  Future<User> getUser() async {
    var response = await dio.get('/api/user');
    if (response.statusCode == 200) {
      if (response.data['success']) {
        return UserModel.fromJson(response.data['data']);
      } else {
        throw Exception(response.data['data']);
      }
    } else {
      throw Exception('Connection failed ${response.statusCode}');
    }
  }

  Future<User> updateUser(String name) async {
    var response = await dio.post('/api/user', data: {'name': name});
    if (response.statusCode == 200) {
      if (response.data['success']) {
        return UserModel.fromJson(response.data['data']);
      } else {
        throw Exception(response.data['data']);
      }
    } else {
      throw Exception('Connection failed ${response.statusCode}');
    }
  }

  Future<List<Film>> getFilms(String date, String query) async {
    var response = await dio.get('/api/movies?date=$date&query=$query');
    if (response.statusCode == 200) {
      if (response.data['success']) {
        return response.data['data']
            .map<Film>((e) => FilmModel.fromJson(e))
            .toList();
      } else {
        throw Exception(response.data['data']);
      }
    } else {
      throw Exception('Connection failed ${response.statusCode}');
    }
  }

  Future<Film> getFilmById(int id) async {
    var response = await dio.get('/api/movies/$id');
    if (response.statusCode == 200) {
      if (response.data['success']) {
        return FilmModel.fromJson(response.data['data']);
      } else {
        throw Exception(response.data['data']);
      }
    } else {
      throw Exception('Connection failed ${response.statusCode}');
    }
  }

  Future<List<Ticket>> getTickets() async {
    var response = await dio.get('/api/user/tickets');
    if (response.statusCode == 200) {
      if (response.data['success']) {
        return response.data['data']
            .map<Ticket>((e) => TicketModel.fromJson(e))
            .toList();
      } else {
        throw Exception(response.data['data']);
      }
    } else {
      throw Exception('Connection failed ${response.statusCode}');
    }
  }

  Future<List<FilmSession>> getFilmSessions(int id, String date) async {
    var response = await dio.get('/api/movies/sessions?movieId=$id&date=$date');
    if (response.statusCode == 200) {
      if (response.data['success']) {
        return response.data['data']
            .map<FilmSessionModel>((e) => FilmSessionModel.fromJson(e))
            .toList();
      } else {
        throw Exception(response.data['data']);
      }
    } else {
      throw Exception('Connection failed ${response.statusCode}');
    }
  }

  Future<bool> bookSeats(List<int> seatsId, int sessionId) async {
    var response = await dio.post('/api/movies/book',
        data: {'seats': seatsId, 'sessionId': sessionId});
    if (response.statusCode == 200) {
      if (response.data['success']) {
        return response.data['data'];
      } else {
        throw Exception(response.data['data']);
      }
    } else {
      throw Exception('Connection failed ${response.statusCode}');
    }
  }

  Future<bool> buyTickets(
      List<int> seatsId, int sessionId, PayCardData card) async {
    try {
      var response = await dio.post(
        '/api/movies/buy',
        data: {
          'seats': seatsId,
          'sessionId': sessionId,
          'email': card.holderEmail,
          'cardNumber': card.cardNumber,
          'expirationDate': card.expDate,
          'cvv': card.cvvCode
        },
      );
      if (response.data['success']) {
        return response.data['data'];
      } else {
        return Future.error(response.data['data']);
      }
    } on DioError catch (e) {
      return Future.error(e.response?.data['data'][0]['error']);
    }
  }

  Future<List<Comment>> getComments(int id) async {
    var response = await dio.get('/api/movies/comments?movieId=$id');
    if (response.statusCode == 200) {
      if (response.data['success']) {
        return response.data['data']
            .map<Comment>((e) => CommentModel.fromJson(e))
            .toList();
      } else {
        throw Exception(response.data['data']);
      }
    } else {
      throw Exception('Connection failed ${response.statusCode}');
    }
  }

  Future<bool> addComment(String content, int rating, int movieId) async {
    var response = await dio.post('/api/movies/comments',
        data: {"content": content, "rating": rating, "movieId": movieId});
    if (response.statusCode == 200) {
      if (response.data['success']) {
        return response.data['data'];
      } else {
        throw Exception(response.data['data']);
      }
    } else {
      throw Exception('Connection failed ${response.statusCode}');
    }
  }

  Future<bool> deleteComment(int id) async {
    var response = await dio.delete('/api/movies/comments/$id');
    if (response.statusCode == 200) {
      if (response.data['success']) {
        return response.data['data'];
      } else {
        throw Exception(response.data['data']);
      }
    } else {
      throw Exception('Connection failed ${response.statusCode}');
    }
  }
}
