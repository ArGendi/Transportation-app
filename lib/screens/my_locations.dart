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

  List<String> _locations = [];
  bool isLoadingLocation = false;

  Future<void> _getPosition() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    _locations.add(first.addressLine);
    print(first.addressLine);
  }

  Widget _addCurrentLocationOrLoading(){
    if(isLoadingLocation)
      return CircularProgressIndicator(
        strokeWidth: 3,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    else return Text(
      'اضف موقعي الحالي',
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  Widget _listViewOfAddresses(){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _locations.length,
      itemBuilder: (BuildContext context, int index) {
        List<String> location = _locations[index].split(',');
        String firstAddressPart = location.first;
        String restOfAddress = location[1] + ', ' + location[2];
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      firstAddressPart,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      restOfAddress,
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
        );
      },
    );
  }

  Widget _noLocationFoundInTheList(){
    return Center(
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
              fontSize: 18,
            ),
          ),
          Text(
            'من فضلك ادخل موقع',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(height: 30,),
          InkWell(
            onTap: () async{
              setState(() { isLoadingLocation = true; });
              await _getPosition();
              setState(() { isLoadingLocation = false; });
            },
            child: Container(
              width: double.infinity,
              height: 60,
              color: primaryColor,
              child: Center(
                child: _addCurrentLocationOrLoading(),
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
    );
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
        child: _locations.isNotEmpty ? _listViewOfAddresses() : _noLocationFoundInTheList(),
      ),
    );
  }
}
