
import 'package:fete_ta_science/src/pages/carte_interactive_page/model/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/src/layer/marker_layer.dart' as ml;
import 'package:latlong/latlong.dart' as lt;
import 'package:flutter_map/src/layer/marker_layer.dart';

import '../../detail_page/detail_page.dart';



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
            width: 500.0,
            height: 60,
            //onTap: () {},
            point: lt.LatLng(e.latitude, e.longitude),
            anchorPos: AnchorPos.align(AnchorAlign.top),
            builder: (ctx) => Container(
              width: 300,
                height: 300,
                  child:GestureDetector(
                    child: Column(
                      children: widget.events.length < 10 ? [
                        Expanded(
                            child:Container(
                            width:120 ,
                            child:Text(
                                e.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                //style: TextStyle(backgroundColor: Colors.deepOrange),
                            )
                          )
                        ),
                        Expanded(
                          child:Icon(
                            Icons.location_on,
                            color: Colors.deepOrange,
                          )
                        ),
                      ] :[
                        Expanded(
                            child:Icon(
                              Icons.location_on,
                              color: Colors.deepOrange,
                            )
                        )
                      ],
                    ),
                    onTap: () {
                      print("go to events details id="+e.id);
                      Navigator.push<Detail>(
                          context,
                          MaterialPageRoute<Detail>(
                              builder: (context) => Detail(
                                id: e.id,
                              )
                          )
                      );
                      // do something
                    },
                  )
            )
          )
      );
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
