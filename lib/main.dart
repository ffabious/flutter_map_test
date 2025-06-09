import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      useMaterial3: true,
    );
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fish Go'),
          backgroundColor: theme.colorScheme.primaryContainer,
        ),
        body: MapWidget(),
      ),
    );
  }
}

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final _popupController = PopupController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(53.5587, 108.1650),
          initialZoom: 8.0,
          onTap: (tapPosition, point) => _popupController.hideAllPopups(),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          PopupMarkerLayer(
            options: PopupMarkerLayerOptions(
              markerCenterAnimation: MarkerCenterAnimation(),
              markers: [
                Marker(
                  point: LatLng(53.5587, 108.1650),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ],
              popupController: _popupController,
              popupDisplayOptions: PopupDisplayOptions(
                builder: (context, marker) {
                  return Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Fish Go Location\nLat: ${marker.point.latitude}\nLon: ${marker.point.longitude}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  );
                },
                animation: PopupAnimation.fade(
                  duration: const Duration(milliseconds: 150),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
