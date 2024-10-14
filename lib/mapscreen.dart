import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen({Key? key}) : super(key: key);

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   final List<Marker> _markers = [];
//   final MapController _mapController = MapController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FlutterMap(
//         mapController: _mapController,
//         options: MapOptions(
//           initialCenter: LatLng(0, 0),
//           initialZoom: 2,
//           onTap: (tapPosition, point) {
//             setState(() {
//               _markers.add(Marker(
//                 width: 80.0,
//                 height: 80.0,
//                 point: point,
//                 child: GestureDetector(
//                   onTap: () => _showMarkerDialog(point),
//                   child: const Icon(
//                     Icons.location_on,
//                     color: Colors.red,
//                     size: 40.0,
//                   ),
//                 ),
//               ));
//             });
//           },
//         ),
//         children: [
//           TileLayer(
//             urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//             userAgentPackageName: 'com.example.app',
//           ),
//           MarkerLayer(markers: _markers),
//         ],
//       ),
//     );
//   }

//   void _showMarkerDialog(LatLng point) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Marker Details'),
//           content: Text(
//             'Latitude: ${point.latitude.toStringAsFixed(6)}\n'
//             'Longitude: ${point.longitude.toStringAsFixed(6)}',
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Close'),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final List<Marker> _markers = [];
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: LatLng(20.5937, 78.9629), // Center of India
        initialZoom: 5,
        onTap: (tapPosition, point) {
          setState(() {
            _markers.add(Marker(
              width: 80.0,
              height: 80.0,
              point: point,
              child: GestureDetector(
                onTap: () => _showMarkerDialog(point),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40.0,
                ),
              ),
            ));
          });
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.urbanride',
        ),
        MarkerLayer(markers: _markers),
      ],
    );
  }

  void _showMarkerDialog(LatLng point) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Marker Details'),
          content: Text(
            'Latitude: ${point.latitude.toStringAsFixed(6)}\n'
            'Longitude: ${point.longitude.toStringAsFixed(6)}',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
