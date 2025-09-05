class TabMenuEntity {
  final int index;
  final int notifyCount;
  TabMenuEntity({
    this.index = 0,
    this.notifyCount = 0,
  });

  TabMenuEntity copyWith({
    int? index,
    int? notifyCount,
  }) {
    return TabMenuEntity(
      index: index ?? this.index,
      notifyCount: notifyCount ?? this.notifyCount,
    );
  }
}
