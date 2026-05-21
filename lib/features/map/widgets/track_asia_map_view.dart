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
  final VoidCallback unselectedLocation;
  final ValueChanged<RentalLocation> setCurrentSelectedLocation;

  const MapCanvasWidget({
    super.key,
    required this.styleUrl,
    required this.locations,
    this.selectedLocation,
    this.userLatitude,
    this.userLongitude,
    required this.focusUserLocationRequestId,
    required this.unselectedLocation,
    required this.setCurrentSelectedLocation,
  });

  @override
  State<MapCanvasWidget> createState() => _MapCanvasWidgetState();
}

class _MapCanvasWidgetState extends State<MapCanvasWidget> {
  final Completer<TrackAsiaMapController> _mapController = Completer();
  final Map<String, RentalLocation> _symbolLocationMap = {};
  bool _symbolLayerConfigured = false;
  bool _isRenderingSymbols = false;
  bool _isProgrammaticMove = false;

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

  Future<void> _configureSymbolLayer() async {
    if (_symbolLayerConfigured) return;

    final controller = await _mapController.future;
    await controller.setSymbolIconAllowOverlap(true);
    await controller.setSymbolIconIgnorePlacement(true);
    await controller.setSymbolTextAllowOverlap(true);
    await controller.setSymbolTextIgnorePlacement(true);

    _symbolLayerConfigured = true;
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
    if (!_styleLoaded || _isRenderingSymbols) return;

    _isRenderingSymbols = true;
    try {
      final controller = await _mapController.future;

      await _addMarkerImages();
      await _configureSymbolLayer();
      await controller.clearSymbols();

      _symbolLocationMap.clear();

      for (final item in widget.locations) {
        final symbol = await controller.addSymbol(
          SymbolOptions(
            geometry: LatLng(item.latitude, item.longitude),
            iconImage: _markerIconName(item.type),
            iconSize: 0.5,
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

        _symbolLocationMap[symbol.id] = item;
      }
    } finally {
      _isRenderingSymbols = false;
    }
  }

  Future<void> _focusUserLocation() async {
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
    _isProgrammaticMove = true;
    final controller = await _mapController.future;
    await controller.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(lat, lng), 16),
    );

    await Future.delayed(const Duration(milliseconds: 500));
    _isProgrammaticMove = false;
  }

  Future<void> _onMarkerTap(RentalLocation tappedLocation) async {
    widget.setCurrentSelectedLocation(tappedLocation);
    await _focusLocation(
      tappedLocation.latitude,
      tappedLocation.longitude,
    );
    debugPrint('Show ${tappedLocation.name} detail');
  }

  @override
  Widget build(BuildContext context) {
    return TrackAsiaMap(
      styleString: widget.styleUrl,
      initialCameraPosition: _initialPosition,
      myLocationEnabled: true,
      myLocationTrackingMode: MyLocationTrackingMode.tracking,
      myLocationRenderMode: MyLocationRenderMode.compass,
      onCameraIdle: () async {
        if (_isProgrammaticMove) return;
        widget.unselectedLocation();
      },
      onMapCreated: (controller) {
        if (!_mapController.isCompleted) {
          _mapController.complete(controller);
        }

        controller.onSymbolTapped.add((symbol) {
          final location = _symbolLocationMap[symbol.id];
          if (location != null) {
            _onMarkerTap(location);
          }
        });
      },
      onStyleLoadedCallback: () async {
        _styleLoaded = true;
        _symbolLayerConfigured = false;
        await _renderSymbols();
        await _focusUserLocation();
      },
      onMapClick: (point, latLng) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}
