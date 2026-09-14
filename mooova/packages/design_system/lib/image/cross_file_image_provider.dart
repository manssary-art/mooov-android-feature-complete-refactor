import 'dart:ui' as ui;

import 'package:cross_file/cross_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class XFileImageProvider extends ImageProvider<XFileImageProvider> {
  /// The file to decode into an image.
  final XFile file;

  /// The scale to place in the [ImageInfo] object of the image.
  final double scale;

  /// Creates an object that decodes a [File] as an image.
  ///
  /// The arguments must not be null.
  const XFileImageProvider(this.file, {this.scale = 1.0});

  @override
  Future<XFileImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<XFileImageProvider>(this);
  }

  @override
  ImageStreamCompleter load(
    XFileImageProvider key,
    DecoderCallback decode,
  ) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, null, decode),
      scale: key.scale,
      debugLabel: key.file.path,
      informationCollector: () => <DiagnosticsNode>[
        ErrorDescription('Path: ${file.path}'),
      ],
    );
  }

  @override
  ImageStreamCompleter loadBuffer(
    XFileImageProvider key,
    DecoderBufferCallback decode,
  ) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, decode, null),
      scale: key.scale,
      debugLabel: key.file.path,
      informationCollector: () => <DiagnosticsNode>[
        ErrorDescription('Path: ${file.path}'),
      ],
    );
  }

  Future<ui.Codec> _loadAsync(
    XFileImageProvider key,
    DecoderBufferCallback? decode,
    DecoderCallback? decodeDeprecated,
  ) async {
    assert(key == this);
    final int lengthInBytes = await file.length();
    if (lengthInBytes == 0) {
      // The file may become available later.
      PaintingBinding.instance.imageCache.evict(key);
      throw StateError('$file is empty and cannot be loaded as an image.');
    }
    if (decode != null) {
      if (file.runtimeType == XFile) {
        try {
          return decode(await ui.ImmutableBuffer.fromFilePath(file.path));
        } on Error catch (_) {
          // Not supported
        }
      }
      try {
        return decode(await ui.ImmutableBuffer.fromUint8List(await file.readAsBytes()));
      } on Error catch (_) {
        // Not supported
      }
    }
    return decodeDeprecated!(await file.readAsBytes());
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is XFileImageProvider && other.file.path == file.path && other.scale == scale;
  }

  @override
  int get hashCode => Object.hash(file.path, scale);

  @override
  String toString() => '${objectRuntimeType(this, 'XFileImageProvider')}("${file.path}", scale: $scale)';
}
