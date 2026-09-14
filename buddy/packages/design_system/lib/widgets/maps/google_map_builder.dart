import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

export 'package:google_maps_flutter/google_maps_flutter.dart'
    show Marker, BitmapDescriptor, MarkerId, LatLng, CameraPosition, CameraUpdate, LatLngBounds;

abstract class GoogleMapBuilderController {
  Future<void> animateCamera(CameraUpdate cameraUpdate);
}

class GoogleMapBuilder extends StatefulWidget {
  final Set<Marker> markers;
  final bool myLocationEnabled;
  final CameraPosition initialCameraPosition;
  final Function(GoogleMapBuilderController) onMapCreated;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;
  final bool zoomGesturesEnabled;
  final bool forceRefreshEnabled;

  const GoogleMapBuilder({
    Key? key,
    this.markers = const <Marker>{},
    this.myLocationEnabled = false,
    required this.initialCameraPosition,
    required this.onMapCreated,
    this.gestureRecognizers = const <Factory<OneSequenceGestureRecognizer>>{},
    this.zoomGesturesEnabled = false,
    this.forceRefreshEnabled = true,
  }) : super(key: key);

  @override
  _GoogleMapBuilderState createState() => _GoogleMapBuilderState();
}

class _GoogleMapBuilderState extends State<GoogleMapBuilder>
    with WidgetsBindingObserver
    implements GoogleMapBuilderController {
  Key mapKey = UniqueKey();
  AppLifecycleState? currentState;
  GoogleMapController? googleMapController;
  late CameraPosition cachedInitialPosition;

  @override
  void initState() {
    super.initState();
    if (widget.forceRefreshEnabled) {
      WidgetsBinding.instance.addObserver(this);
    }

    cachedInitialPosition = widget.initialCameraPosition;
    currentState = WidgetsBinding.instance.lifecycleState;
  }

  @override
  void dispose() {
    googleMapController = null;
    if (widget.forceRefreshEnabled) {
      WidgetsBinding.instance.removeObserver(this);
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState nextState) {
    super.didChangeAppLifecycleState(nextState);
    if (currentState != AppLifecycleState.resumed && nextState == AppLifecycleState.resumed) {
      setState(() {
        mapKey = UniqueKey();
      });
    }

    currentState = nextState;
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      key: mapKey,
      mapType: MapType.normal,
      markers: widget.markers,
      myLocationButtonEnabled: false,
      myLocationEnabled: widget.myLocationEnabled,
      initialCameraPosition: cachedInitialPosition,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      zoomGesturesEnabled: widget.zoomGesturesEnabled,
      gestureRecognizers: widget.gestureRecognizers,
      onCameraMove: (position) {
        cachedInitialPosition = position;
      },
      onMapCreated: (controller) {
        final isFirstCall = googleMapController == null;
        googleMapController = controller;
        if (isFirstCall) {
          widget.onMapCreated(this);
        }
      },
    );
  }

  @override
  Future<void> animateCamera(CameraUpdate cameraUpdate) async {
    await googleMapController?.animateCamera(cameraUpdate);
  }
}
