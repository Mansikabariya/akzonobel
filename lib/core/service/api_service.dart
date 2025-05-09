import 'package:akzonobel/core/local_storage/local_storage.dart';
import 'package:akzonobel/core/service/header_interceptor.dart';
import 'package:akzonobel/utils/app_constants.dart';
import 'package:chopper/chopper.dart';
part 'api_service.chopper.dart';

@ChopperApi()
abstract class AppApiService extends ChopperService {
  static AppApiService create({required LocalStorage localStorage}) {
    final client = ChopperClient(
      baseUrl: Uri.parse(TheAppConstants.baseUrl),
      services: [_$AppApiService()],
      converter: JsonConverter(),
      interceptors: [
        AuthHeadersInterceptor(localStorage: localStorage),
        HttpLoggingInterceptor(),
        CurlInterceptor(),
      ],
    );
    return _$AppApiService(client);
  }

  @POST(path: 'account/user_Login')
  @FormUrlEncoded() // Tells Chopper to encode fields as form-urlencoded
  Future<Response> signIn({
    @Field('email') required String email,
    @Field('password') required String password,
    @Field('full_name')
    required String fullName,
  });


  @POST(path: 'event/user_event_list')
  @FormUrlEncoded()
  Future<Response> getEvents({
    @Field('offset') required String offset,
    @Field('type') required String type,
});
}
