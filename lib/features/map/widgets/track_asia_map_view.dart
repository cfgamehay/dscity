import 'dart:async';
import 'dart:typed_data';

import 'package:dscity_mobile_app/core/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trackasia_gl/trackasia_gl.dart';

import '../../../../core/constants/enum.dart';
import '../../../../data/model/map/rental_location.dart';

class MapCanvasWidget extends StatefulWidget {
  final String styleUrl;
  final List<RentalLocation> locations;
  final RentalLocation? selectedLocation;
  final double? userLatitude;
  final double? userLongitude;
  final int focusUserLocationRequestId;

  const MapCanvasWidget({
    super.key,
    required this.styleUrl,
    required this.locations,
    this.selectedLocation,
    this.userLatitude,
    this.userLongitude,
    required this.focusUserLocationRequestId,
  });

  @override
  State<MapCanvasWidget> createState() => _MapCanvasWidgetState();
}

class _MapCanvasWidgetState extends State<MapCanvasWidget> {
  final Completer<TrackAsiaMapController> _mapController = Completer();

  static const _initialPosition = CameraPosition(
    target: LatLng(10.7766, 106.7009),
    zoom: 15,
  );

  bool _styleLoaded = false;
  bool _imagesAdded = false;

  @override
  void didUpdateWidget(covariant MapCanvasWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.locations != widget.locations && _styleLoaded) {
      _renderSymbols();
    }

    if (oldWidget.selectedLocation?.id != widget.selectedLocation?.id &&
        widget.selectedLocation != null) {
      _focusLocation(
        widget.selectedLocation!.latitude,
        widget.selectedLocation!.longitude,
      );
    }

    if ((oldWidget.userLatitude != widget.userLatitude ||
            oldWidget.userLongitude != widget.userLongitude) &&
        widget.userLatitude != null &&
        widget.userLongitude != null) {
      _focusUserLocation();
    }

    if (oldWidget.focusUserLocationRequestId !=
        widget.focusUserLocationRequestId) {
      _focusUserLocation();
    }
  }

  Future<Uint8List> _loadAssetBytes(String path) async {
    final data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  Future<void> _addMarkerImages() async {
    if (_imagesAdded) return;

    final controller = await _mapController.future;

    await controller.addImage(
      'parking_marker',
      await _loadAssetBytes(ImagesResource.pngIcParking),
    );

    await controller.addImage(
      'car_marker',
      await _loadAssetBytes(ImagesResource.pngIcCar),
    );

    await controller.addImage(
      'motorbike_marker',
      await _loadAssetBytes(ImagesResource.pngIcMotorbike),
    );

    await controller.addImage(
      'sharing_marker',
      await _loadAssetBytes(ImagesResource.pngIcShare),
    );

    _imagesAdded = true;
  }

  String _markerIconName(MapFilterType type) {
    switch (type) {
      case MapFilterType.parking:
        return 'parking_marker';
      case MapFilterType.car:
        return 'car_marker';
      case MapFilterType.motorbike:
        return 'motorbike_marker';
      case MapFilterType.sharing:
        return 'sharing_marker';
    }
  }

  Future<void> _renderSymbols() async {
    if (!_styleLoaded) return;

    final controller = await _mapController.future;
    await _addMarkerImages();
    await controller.clearSymbols();

    //tracker always visible
    controller.setSymbolIconAllowOverlap(true);
    controller.setSymbolIconIgnorePlacement(true);
    controller.setSymbolTextAllowOverlap(true);
    controller.setSymbolTextIgnorePlacement(true);

    for (final item in widget.locations) {
      await controller.addSymbol(
        SymbolOptions(
          geometry: LatLng(item.latitude, item.longitude),
          iconImage: _markerIconName(item.type),
          iconSize: .5,
          iconAnchor: 'bottom',
          zIndex: 999,
          textField: item.name,
          textSize: 12,
          textOffset: const Offset(0, 1.2),
          textColor: '#052650',
          textHaloColor: '#FFFFFF',
          textHaloWidth: 1.5,
        ),
      );
    }
  }

  Future<void> _focusUserLocation() async {
    debugPrint(
      'user lat: ${widget.userLatitude}, lng: ${widget.userLongitude}',
    );
    if (widget.userLatitude == null || widget.userLongitude == null) return;

    final controller = await _mapController.future;
    await controller.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(widget.userLatitude!, widget.userLongitude!),
        15,
      ),
    );
  }

  Future<void> _focusLocation(double lat, double lng) async {
    final controller = await _mapController.future;
    await controller.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(lat, lng), 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TrackAsiaMap(
      styleString: widget.styleUrl,
      initialCameraPosition: _initialPosition,
      onMapCreated: (controller) {
        if (!_mapController.isCompleted) {
          _mapController.complete(controller);
        }
      },
      onStyleLoadedCallback: () async {
        _styleLoaded = true;
        await _renderSymbols();
        await _focusUserLocation();
      },
      myLocationEnabled: true,
      myLocationTrackingMode: MyLocationTrackingMode.tracking,
      myLocationRenderMode: MyLocationRenderMode.compass,
      compassEnabled: true,
      zoomGesturesEnabled: true,
      tiltGesturesEnabled: true,
    );
  }
}
