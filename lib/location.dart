import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  late GoogleMapController controller;

  void _onMapCreated(GoogleMapController controller) {
    controller = controller;
  }

  final LatLng _center = const LatLng(43.23279157086145, -79.88672164284294);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Location',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(
          children: [
            Container(
              height: 500,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 15.0,
                ),
                markers: {
                  const Marker(
                      markerId: MarkerId('Hamilton Public Library'),
                      position: LatLng(43.23279157086145, -79.88672164284294))
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: Column(
                children: [
                  Text(
                    "Address:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                  Text(
                    "100 Mohawk Rd W, Hamilton, ON L9C 1W1",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              )),
            )
          ],
        ));
  }
}
