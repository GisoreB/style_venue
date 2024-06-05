import 'package:style_venue/core/constants/api_constants.dart';
import 'package:style_venue/core/constants/enums/request_types.dart';
import 'package:style_venue/core/utils/network/network_manager.dart';
import 'package:style_venue/features/profile/model/profile_model.dart';

class ProfileService {
  final NetworkManager? _networkManager = NetworkManager.instance;

  Future<ProfileModel?> fetchProfile() async {
    return await _networkManager!.request(
        method: ReqTypes.get,
        path: ApiConstants.profile,
        model: ProfileModel());
  }
}