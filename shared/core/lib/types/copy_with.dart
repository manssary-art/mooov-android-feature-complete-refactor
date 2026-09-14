extension AnyCopyWithExt<T> on T {
  T Function() get copy => () => this;
}
