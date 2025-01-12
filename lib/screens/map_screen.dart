import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'hospital_detail_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;
  LatLng? _center;
  final List<Marker> _markers = [];
  String? _selectedHospitalName;
  LatLng? _selectedHospitalLocation;
  late int amount;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _addDesiredLocations();
  }

  void _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      _showLocationPermissionDeniedDialog();
    } else {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        setState(() {
          _center = LatLng(position.latitude, position.longitude);
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              "Error getting current location: $e",
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _addDesiredLocations() {
    _markers.add(
      Marker(
        markerId: const MarkerId('1'),
        position: const LatLng(18.922785271104413, 72.83160541894745),
        infoWindow: const InfoWindow(title: 'Suraj Singh'),
        onTap: () {
          setState(() {
            _selectedHospitalName = 'Suraj Singh';
            _selectedHospitalLocation = const LatLng(18.922785271104413, 72.83160541894745);
            amount= 750;
          });
          _showLocationDetailsDialog();
        },
      ),
    );

    _markers.add(
      Marker(
        markerId: const MarkerId('2'),
        position: const LatLng(18.923602513266072, 72.83351841614709),
        infoWindow: const InfoWindow(title: 'Mahindra Singh'),
        onTap: () {
          setState(() {
            _selectedHospitalName = 'Mahindra Singh';
            _selectedHospitalLocation = const LatLng(18.923602513266072, 72.83351841614709);
            amount = 1000;
          });
          _showLocationDetailsDialog();
        },
      ),
    );

    _markers.add(
      Marker(
        markerId: const MarkerId('3'),
        position: const LatLng(18.9225955536025, 72.83401980654216),
        infoWindow: const InfoWindow(title: 'Kabir Singh'),
        onTap: () {
          setState(() {
            _selectedHospitalName = 'Kabir Singh';
            _selectedHospitalLocation = const LatLng(18.9225955536025, 72.83401980654216);
            amount = 900;
          });
          _showLocationDetailsDialog();
        },
      ),
    );

    _markers.add(
      Marker(
        markerId: const MarkerId('4'),
        position: const LatLng(18.924769995144935, 72.83214537783445),
        infoWindow: const InfoWindow(title: 'Rahul Kapoor'),
        onTap: () {
          setState(() {
            _selectedHospitalName = 'Rahul Kapoor';
            _selectedHospitalLocation = const LatLng(18.924769995144935, 72.83214537783445);
            amount = 1200;
          });
          _showLocationDetailsDialog();
        },
      ),
    );
  }

  void _showLocationPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Location Permission Denied"),
          content: const Text(
            "Please enable location permissions in settings to use this feature.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showLocationDetailsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if(_selectedHospitalName=='Suraj Singh'){
          return AlertDialog(
            title: Text(_selectedHospitalName ?? ''),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Hospital Name: Seven Hills Hospital'),
                  const Text('Equipments:  Oxygen System, Cardiac Monitor, IV Supplies'),
                  const Text('Experience: 5 years'),
                  Text('Price: $amount'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close', style: TextStyle(color: Colors.red),),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HospitalDetailScreen(hospitalName: _selectedHospitalName!, amount: amount,),
                    ),
                  ).then((_) {
                    Navigator.of(context).pop();
                  });
                },
                child: const Text("Select", style: TextStyle(color: Colors.red),),
              ),
            ],
          );
        }else if(_selectedHospitalName=='Mahindra Singh'){
          return AlertDialog(
            title: Text(_selectedHospitalName ?? ''),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Hospital Name: Hills Hospital'),
                  const Text('Equipments:  Oxygen System, Cardiac Monitor, IV Supplies'),
                  const Text('Experience: 3 years'),
                  Text('Price: $amount'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close', style: TextStyle(color: Colors.red),),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HospitalDetailScreen(hospitalName: _selectedHospitalName!, amount: amount,),
                    ),
                  ).then((_) {
                    Navigator.of(context).pop();
                  });
                },
                child: const Text("Select", style: TextStyle(color: Colors.red),),
              ),
            ],
          );
        }else if(_selectedHospitalName=='Kabir Singh'){
          return AlertDialog(
            title: Text(_selectedHospitalName ?? ''),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Hospital Name: Healing Haven Hospital'),
                  const Text('Equipments:  Oxygen System, Cardiac Monitor, IV Supplies'),
                  const Text('Experience: 6 years'),
                  Text('Price: $amount'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close', style: TextStyle(color: Colors.red),),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HospitalDetailScreen(hospitalName: _selectedHospitalName!, amount: amount,),
                    ),
                  ).then((_) {
                    Navigator.of(context).pop();
                  });
                },
                child: const Text("Select", style: TextStyle(color: Colors.red),),
              ),
            ],
          );
        }else{
          return AlertDialog(
            title: Text(_selectedHospitalName ?? ''),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Hospital Name: Eternal Wellness Hospital'),
                  const Text('Equipments:  Oxygen System, Cardiac Monitor, IV Supplies'),
                  const Text('Experience: 8 years'),
                  Text('Price: $amount'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close', style: TextStyle(color: Colors.red),),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HospitalDetailScreen(hospitalName: _selectedHospitalName!, amount: amount,),
                    ),
                  ).then((_) {
                    Navigator.of(context).pop();
                  });
                },
                child: const Text("Select", style: TextStyle(color: Colors.red),),
              ),
            ],
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _center == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
            initialCameraPosition: CameraPosition(
              target: _center!,
              zoom: 15.0,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: Set<Marker>.of(_markers),
          ),
          Positioned(
            top: 50.0,
            left: 16.0,
            right: 16.0,
            child: Container(
              alignment: Alignment.center,
              color: Colors.red,
              height: screenHeight * 0.05,
              child: Text(
                "Please select your desired ambulance",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth*0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
