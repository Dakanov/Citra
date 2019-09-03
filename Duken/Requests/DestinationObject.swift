
//
//    Destination.swift
//
//    Create by Господин on 2/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class Destination : NSObject, NSCoding, Mappable{
    
    var geocodedWaypoints : [GeocodedWaypoint]?
    var routes : [Route]?
    var status : String?
    var error: String?
    
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Destination()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        geocodedWaypoints <- map["geocoded_waypoints"]
        routes <- map["routes"]
        status <- map["status"]
        error <- map["error_message"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        geocodedWaypoints = aDecoder.decodeObject(forKey: "geocoded_waypoints") as? [GeocodedWaypoint]
        routes = aDecoder.decodeObject(forKey: "routes") as? [Route]
        status = aDecoder.decodeObject(forKey: "status") as? String
        error = aDecoder.decodeObject(forKey: "error_message") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if geocodedWaypoints != nil{
            aCoder.encode(geocodedWaypoints, forKey: "geocoded_waypoints")
        }
        if routes != nil{
            aCoder.encode(routes, forKey: "routes")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if error != nil{
            aCoder.encode(status, forKey: "error_message")
        }
        
    }
    
}

class Route : NSObject, NSCoding, Mappable{
    
    var bounds : Bound?
    var copyrights : String?
    var legs : [Leg]?
    var overviewPolyline : Polyline?
    var summary : String?
    var warnings : [AnyObject]?
    var waypointOrder : [AnyObject]?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Route()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        bounds <- map["bounds"]
        copyrights <- map["copyrights"]
        legs <- map["legs"]
        overviewPolyline <- map["overview_polyline"]
        summary <- map["summary"]
        warnings <- map["warnings"]
        waypointOrder <- map["waypoint_order"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        bounds = aDecoder.decodeObject(forKey: "bounds") as? Bound
        copyrights = aDecoder.decodeObject(forKey: "copyrights") as? String
        legs = aDecoder.decodeObject(forKey: "legs") as? [Leg]
        overviewPolyline = aDecoder.decodeObject(forKey: "overview_polyline") as? Polyline
        summary = aDecoder.decodeObject(forKey: "summary") as? String
        warnings = aDecoder.decodeObject(forKey: "warnings") as? [AnyObject]
        waypointOrder = aDecoder.decodeObject(forKey: "waypoint_order") as? [AnyObject]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if bounds != nil{
            aCoder.encode(bounds, forKey: "bounds")
        }
        if copyrights != nil{
            aCoder.encode(copyrights, forKey: "copyrights")
        }
        if legs != nil{
            aCoder.encode(legs, forKey: "legs")
        }
        if overviewPolyline != nil{
            aCoder.encode(overviewPolyline, forKey: "overview_polyline")
        }
        if summary != nil{
            aCoder.encode(summary, forKey: "summary")
        }
        if warnings != nil{
            aCoder.encode(warnings, forKey: "warnings")
        }
        if waypointOrder != nil{
            aCoder.encode(waypointOrder, forKey: "waypoint_order")
        }
        
    }
    
}


class Leg : NSObject, NSCoding, Mappable{
    
    var distance : Distance?
    var duration : Distance?
    var endAddress : String?
    var endLocation : Northeast?
    var startAddress : String?
    var startLocation : Northeast?
    var steps : [Step]?
    var trafficSpeedEntry : [AnyObject]?
    var viaWaypoint : [AnyObject]?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Leg()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        distance <- map["distance"]
        duration <- map["duration"]
        endAddress <- map["end_address"]
        endLocation <- map["end_location"]
        startAddress <- map["start_address"]
        startLocation <- map["start_location"]
        steps <- map["steps"]
        trafficSpeedEntry <- map["traffic_speed_entry"]
        viaWaypoint <- map["via_waypoint"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        distance = aDecoder.decodeObject(forKey: "distance") as? Distance
        duration = aDecoder.decodeObject(forKey: "duration") as? Distance
        endAddress = aDecoder.decodeObject(forKey: "end_address") as? String
        endLocation = aDecoder.decodeObject(forKey: "end_location") as? Northeast
        startAddress = aDecoder.decodeObject(forKey: "start_address") as? String
        startLocation = aDecoder.decodeObject(forKey: "start_location") as? Northeast
        steps = aDecoder.decodeObject(forKey: "steps") as? [Step]
        trafficSpeedEntry = aDecoder.decodeObject(forKey: "traffic_speed_entry") as? [AnyObject]
        viaWaypoint = aDecoder.decodeObject(forKey: "via_waypoint") as? [AnyObject]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if distance != nil{
            aCoder.encode(distance, forKey: "distance")
        }
        if duration != nil{
            aCoder.encode(duration, forKey: "duration")
        }
        if endAddress != nil{
            aCoder.encode(endAddress, forKey: "end_address")
        }
        if endLocation != nil{
            aCoder.encode(endLocation, forKey: "end_location")
        }
        if startAddress != nil{
            aCoder.encode(startAddress, forKey: "start_address")
        }
        if startLocation != nil{
            aCoder.encode(startLocation, forKey: "start_location")
        }
        if steps != nil{
            aCoder.encode(steps, forKey: "steps")
        }
        if trafficSpeedEntry != nil{
            aCoder.encode(trafficSpeedEntry, forKey: "traffic_speed_entry")
        }
        if viaWaypoint != nil{
            aCoder.encode(viaWaypoint, forKey: "via_waypoint")
        }
        
    }
    
}

class Step : NSObject, NSCoding, Mappable{
    
    var distance : Distance?
    var duration : Distance?
    var endLocation : Northeast?
    var htmlInstructions : String?
    var maneuver : String?
    var polyline : Polyline?
    var startLocation : Northeast?
    var travelMode : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Step()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        distance <- map["distance"]
        duration <- map["duration"]
        endLocation <- map["end_location"]
        htmlInstructions <- map["html_instructions"]
        maneuver <- map["maneuver"]
        polyline <- map["polyline"]
        startLocation <- map["start_location"]
        travelMode <- map["travel_mode"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        distance = aDecoder.decodeObject(forKey: "distance") as? Distance
        duration = aDecoder.decodeObject(forKey: "duration") as? Distance
        endLocation = aDecoder.decodeObject(forKey: "end_location") as? Northeast
        htmlInstructions = aDecoder.decodeObject(forKey: "html_instructions") as? String
        maneuver = aDecoder.decodeObject(forKey: "maneuver") as? String
        polyline = aDecoder.decodeObject(forKey: "polyline") as? Polyline
        startLocation = aDecoder.decodeObject(forKey: "start_location") as? Northeast
        travelMode = aDecoder.decodeObject(forKey: "travel_mode") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if distance != nil{
            aCoder.encode(distance, forKey: "distance")
        }
        if duration != nil{
            aCoder.encode(duration, forKey: "duration")
        }
        if endLocation != nil{
            aCoder.encode(endLocation, forKey: "end_location")
        }
        if htmlInstructions != nil{
            aCoder.encode(htmlInstructions, forKey: "html_instructions")
        }
        if maneuver != nil{
            aCoder.encode(maneuver, forKey: "maneuver")
        }
        if polyline != nil{
            aCoder.encode(polyline, forKey: "polyline")
        }
        if startLocation != nil{
            aCoder.encode(startLocation, forKey: "start_location")
        }
        if travelMode != nil{
            aCoder.encode(travelMode, forKey: "travel_mode")
        }
        
    }
    
}


class Polyline : NSObject, NSCoding, Mappable{
    
    var points : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Polyline()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        points <- map["points"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        points = aDecoder.decodeObject(forKey: "points") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if points != nil{
            aCoder.encode(points, forKey: "points")
        }
        
    }
    
}


class Distance : NSObject, NSCoding, Mappable{
    
    var text : String?
    var value : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Distance()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        text <- map["text"]
        value <- map["value"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        text = aDecoder.decodeObject(forKey: "text") as? String
        value = aDecoder.decodeObject(forKey: "value") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if text != nil{
            aCoder.encode(text, forKey: "text")
        }
        if value != nil{
            aCoder.encode(value, forKey: "value")
        }
        
    }
    
}



class Bound : NSObject, NSCoding, Mappable{
    
    var northeast : Northeast?
    var southwest : Northeast?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Bound()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        northeast <- map["northeast"]
        southwest <- map["southwest"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        northeast = aDecoder.decodeObject(forKey: "northeast") as? Northeast
        southwest = aDecoder.decodeObject(forKey: "southwest") as? Northeast
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if northeast != nil{
            aCoder.encode(northeast, forKey: "northeast")
        }
        if southwest != nil{
            aCoder.encode(southwest, forKey: "southwest")
        }
        
    }
    
}




class GeocodedWaypoint : NSObject, NSCoding, Mappable{
    
    var geocoderStatus : String?
    var placeId : String?
    var types : [String]?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return GeocodedWaypoint()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        geocoderStatus <- map["geocoder_status"]
        placeId <- map["place_id"]
        types <- map["types"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        geocoderStatus = aDecoder.decodeObject(forKey: "geocoder_status") as? String
        placeId = aDecoder.decodeObject(forKey: "place_id") as? String
        types = aDecoder.decodeObject(forKey: "types") as? [String]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if geocoderStatus != nil{
            aCoder.encode(geocoderStatus, forKey: "geocoder_status")
        }
        if placeId != nil{
            aCoder.encode(placeId, forKey: "place_id")
        }
        if types != nil{
            aCoder.encode(types, forKey: "types")
        }
        
    }
    
}
