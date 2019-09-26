import 'package:flutter_uploadcare_client/src/constants.dart';
import 'package:flutter_uploadcare_client/src/entities/cdn.dart';

/// Provides a simple way to work with [Transformation]
class CdnFile extends CndEntity {
  final String cdnUrl;

  CdnFile(
    String id, {
    this.cdnUrl = kDefaultCdnEndpoint,
  })  : assert(id != null),
        super(id);

  Uri get uri => Uri.parse(cdnUrl).replace(path: '/$id/');

  String get url => uri.toString();
}
