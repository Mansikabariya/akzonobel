import 'package:akzonobel/core/local_storage/local_storage.dart';
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
    );
    return _$AppApiService(client);
  }

  @POST(path: 'account/user_Login')
  @FormUrlEncoded() // Tells Chopper to encode fields as form-urlencoded
  Future<Response> signIn({
    // Consider using Response<YourResponseType> if you have one
    @Field('email') required String email,
    @Field('password') required String password,
    @Field('full_name')
    required String fullName, // Assuming API needs this too based on repo
  });
}
