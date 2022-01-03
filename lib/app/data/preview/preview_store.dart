import 'package:hmssdk_flutter/hmssdk_flutter.dart';
import 'package:shvasa_100ms_test/app/services/room_service.dart';
import 'package:uuid/uuid.dart';

class PreviewController {
  final String roomId;
  final String user;
  HMSMeeting? _hmsSdkInteractor;

  PreviewController({required this.roomId, required this.user})
      : _hmsSdkInteractor = HMSMeeting();

  Future<bool> startPreview() async {
    List<String?>? token =
        await RoomService().getToken(user: user, room: roomId);

    if (token == null) return false;

    HMSConfig config = HMSConfig(
      userId: Uuid().v1(),
      roomId: roomId,
      authToken: token[0]!,
      userName: user,
    );

    _hmsSdkInteractor?.previewVideo(
        config: config,
        isProdLink: token[1] == "true" ? true : false,
        setWebRtcLogs: true);
    return true;
  }

  void startListen(HMSPreviewListener listener) {
    _hmsSdkInteractor?.addPreviewListener(listener);
  }

  void removeListener(HMSPreviewListener listener) {
    _hmsSdkInteractor?.removePreviewListener(listener);
  }

  void stopCapturing() {
    _hmsSdkInteractor?.stopCapturing();
  }

  void startCapturing() {
    _hmsSdkInteractor?.startCapturing();
  }

  void switchAudio({bool isOn = false}) {
    _hmsSdkInteractor?.switchAudio(isOn: isOn);
  }

  void addLogsListener(HMSLogListener hmsLogListener) {
    _hmsSdkInteractor?.addLogListener(hmsLogListener);
  }

  void removeLogsListener(HMSLogListener hmsLogListener) {
    _hmsSdkInteractor?.removeLogListener(hmsLogListener);
  }
}
