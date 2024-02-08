/// All API clients should extend from this class
abstract class BaseClientGenerator {
  /// Default `send` and `receive` time outs
  static const _sendTimeOut = 60000;
  static const _receiveTimeOut = 60000;

  const BaseClientGenerator();

  String get path;
  String get method;
  dynamic get body;
  Map<String, dynamic>? get queryParameters;
  int? get sendTimeout => _sendTimeOut;
  int? get receiveTimeOut => _receiveTimeOut;
}
