part of flutter_naver_map;

class MarkerImage {
  final int id;
  final Uint8List? bytes;

  const MarkerImage(this.id, this.bytes);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarkerImage && id == other.id && bytes == other.bytes;

  @override
  int get hashCode => id.hashCode ^ bytes.hashCode;

  MarkerImage clone() {
    return MarkerImage(id, bytes);
  }

  Map<String, dynamic> _toJson() {
    return {
      'id': id,
      'bytes': bytes != null ? bytes!.toList() : null,
    };
  }
}

List<Map<String, dynamic>>? _serializeMarkerImageSet(
    Iterable<MarkerImage?>? markerImages) {
  if (markerImages == null) {
    return null;
  }
  return markerImages.map((markerImage) => markerImage!._toJson()).toList();
}

Map<int, MarkerImage> _keyByMarkerImageId(Iterable<MarkerImage> markerImages) {
  return Map<int, MarkerImage>.fromEntries(markerImages
      .map((markerImage) => MapEntry(markerImage.id, markerImage.clone())));
}
