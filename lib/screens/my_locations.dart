import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:transportation/constants.dart';

class MyLocation extends StatefulWidget {
  static String id = 'my locations';
  const MyLocation({Key? key}) : super(key: key);

  @override
  _MyLocationState createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {

  List locations = [];

  Future<void> _getPosition() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");
  }

  @override
  void initState() {
    super.initState();
    _getPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('موقعي'),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.add)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: locations.isNotEmpty ? ListView(
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'شارع 90',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'التجمع الرابع القاهرة',
                      style: TextStyle(
                        //color: Colors.grey[700],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.check,
                  color: primaryColor,
                )
              ],
            ),
            Divider(height: 40,)
          ],
        ) : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_off_outlined,
                color: Colors.redAccent,
                size: 150,
              ),
              Text(
                'لا يوجد موقع',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                'من فضلك ادخل موقع',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 25,),
              InkWell(
                onTap: (){},
                child: Container(
                  width: double.infinity,
                  height: 60,
                  color: primaryColor,
                  child: Center(
                    child: Text(
                      'اضف موقعي الحالي',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5,),
              InkWell(
                onTap: (){},
                child: Container(
                  width: double.infinity,
                  height: 60,
                  color: Colors.grey.shade300,
                  child: Center(
                    child: Text('اضف موقع بنفسي',),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
