part of flutter_naver_map;

class _MarkerImageUpdates {
  _MarkerImageUpdates.from(
      Set<MarkerImage>? previous, Set<MarkerImage>? current) {
    previous ??= Set<MarkerImage>.identity();
    current ??= Set<MarkerImage>.identity();

    final Map<int, MarkerImage> previousMarkerImages =
        _keyByMarkerImageId(previous);
    final Map<int, MarkerImage> currentMarkerImages =
        _keyByMarkerImageId(current);

    final Set<int> prevMarkerImageIds = previousMarkerImages.keys.toSet();
    final Set<int> currentMarkerImageIds = currentMarkerImages.keys.toSet();

    MarkerImage? idToCurrentMarker(int id) {
      return currentMarkerImages[id];
    }

    final Set<int> _markerImageIdsToRemove =
        prevMarkerImageIds.difference(currentMarkerImageIds);

    final Set<MarkerImage?> _markerImagesToAdd = currentMarkerImageIds
        .difference(prevMarkerImageIds)
        .map(idToCurrentMarker)
        .toSet();

    /// 새로운 마커의 아이디가 기존의 것과 다른 경우 true 리턴.
    bool hasChanged(MarkerImage? current) {
      final MarkerImage? previous = previousMarkerImages[current!.id];
      return current != previous;
    }

    final Set<MarkerImage?> _markerImagesToChange = currentMarkerImageIds
        .intersection(prevMarkerImageIds)
        .map(idToCurrentMarker)
        .where(hasChanged)
        .toSet();

    markerImagesToAdd = _markerImagesToAdd;
    markerImageIdsToRemove = _markerImageIdsToRemove;
    markerImagesToChange = _markerImagesToChange;
  }

  Set<MarkerImage?>? markerImagesToAdd;
  Set<int>? markerImageIdsToRemove;
  Set<MarkerImage?>? markerImagesToChange;

  Map<String, dynamic> _toMap() {
    final Map<String, dynamic> updateMap = <String, dynamic>{};

    void addIfNonNull(String fieldName, dynamic value) {
      if (value != null) {
        updateMap[fieldName] = value;
      }
    }

    addIfNonNull(
      'markerImagesToAdd',
      _serializeMarkerImageSet(markerImagesToAdd),
    );
    addIfNonNull(
      'markerImagesToChange',
      _serializeMarkerImageSet(markerImagesToChange),
    );
    addIfNonNull(
      'markerImageIdsToRemove',
      markerImageIdsToRemove!.map<dynamic>((int m) => m.toString()).toList(),
    );

    return updateMap;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is _MarkerUpdates &&
        setEquals(markerImagesToAdd, other.markersToAdd) &&
        setEquals(markerImageIdsToRemove, other.markerIdsToRemove) &&
        setEquals(markerImagesToChange, other.markersToChange);
  }

  @override
  int get hashCode => hashValues(
        markerImagesToAdd,
        markerImageIdsToRemove,
        markerImagesToChange,
      );

  @override
  String toString() {
    return '_MarkerUpdates{markersToAdd: $markerImagesToAdd, '
        'markerIdsToRemove: $markerImageIdsToRemove, '
        'markersToChange: $markerImagesToChange}';
  }
}
