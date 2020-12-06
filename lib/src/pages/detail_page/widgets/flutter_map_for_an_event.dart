
import 'package:fete_ta_science/src/pages/detail_page/model/event.dart';
import 'package:fete_ta_science/src/pages/tour_page/widgets/event_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/src/layer/marker_layer.dart' as ml;
import 'package:latlong/latlong.dart' as lt;




class LocationLabel extends StatelessWidget {

  LocationLabel(this.event,this.height);

  EventMapData event;

  double height;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children:[
              Container(
                  height:height-20,
                  child:ListView(
                      children:[
                        Text(event.name),
                        //Divider(color: Colors.grey, thickness: 2),
                        //Text(event.description),
                      ]
                  )
              ),
              Divider(color: Colors.green, thickness: 4)
            ],
          ),
        );
  }
}

class flutterMapEvent extends StatefulWidget{

  flutterMapEvent({
    @required this.events,
    @required this.bounds,
    this.onPositionCranged = null,
    this.onReady = null,
    Key key,
  }) : super(key: key);

  List<EventMapData> events;

  void Function(MapPosition position, bool hasGesture) onPositionCranged;
  void Function(MapController) onReady;

  LatLngBounds bounds;

  @override
  State<flutterMapEvent> createState() => flutterMapEventState();

}

class flutterMapEventState extends State<flutterMapEvent> {

  var _markers = List<ml.Marker>();

  void updateMarkers(){
    for(var e in widget.events){
      _markers.add(
          ml.Marker(
            width: 12.0,
            height: 12,
            point: lt.LatLng(e.latitude, e.longitude),
            builder: (ctx) => Container(
              width: 300.0,
              height: 300.0,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
          )
      );
      /*
      ml.Marker(
              width: 120.0,
              height: 90.0,
              point: lt.LatLng(latitude, longitude),
              builder: (ctx) =>
              LocationLabel(eventName,description,90),
                anchorPos: ml.AnchorPos.align(AnchorAlign.top)
            ),
       */
    }
  }

  /*@override
  void initState(){
    update();
    super.initState();
  }*/

  MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    updateMarkers(); // important
    /*print("widget.bounds s="+widget.bounds.south.toString());
    print("widget.bounds n="+widget.bounds.north .toString());
    print("widget.bounds e="+widget.bounds.east .toString());
    print("widget.bounds w="+widget.bounds.west .toString());*/
    //mapController = MapController();
    var fm = FlutterMap(
      mapController: mapController,
      options: MapOptions(
          bounds:widget.bounds,
          //center: lt.LatLng(widget.latitude, widget.longitude),
          zoom: 13.0,
          onPositionChanged:(MapPosition position, bool hasGesture){
            if(widget.onPositionCranged!=null){
              widget.onPositionCranged(position,hasGesture);
              updateMarkers();
            }
          }
      ),
      layers: [
        TileLayerOptions(urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", subdomains: ['a', 'b', 'c']),
        MarkerLayerOptions(
          markers: _markers,
        ),
      ],

    );
    mapController.onReady.then((result) { // i'm getting an error here
      if(widget.onReady!=null){
        widget.onReady(mapController);
        updateMarkers();
      }
    });
    return fm;
  }
}
