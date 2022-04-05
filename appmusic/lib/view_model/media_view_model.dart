import 'package:appmusic/service/media_service.dart';
import 'package:flutter/cupertino.dart';

import '../model/media.dart';
import '../utils/api_response.dart';

class MediaViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  Media? _media;

  ApiResponse get response {
    return _apiResponse;
  }

  Media? get media {
    return _media;
  }

  /// Call the media service and gets the data of requested media data of
  /// an artist.
  Future<void> fetchMediaData(String value) async {
    _apiResponse = ApiResponse.loading('Fetching artist data');
    notifyListeners();
    try {
      List<Media> mediaList = await MediaService().fetchMediaList(value);
      _apiResponse = ApiResponse.completed(mediaList);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }

  void setSelectedMedia(Media? media) {
    _media = media;
    notifyListeners();
  }
}