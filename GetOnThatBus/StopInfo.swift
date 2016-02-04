//
//  StopInfo.swift
//  GetOnThatBus
//
//  Created by Danny Vasquez on 2/2/16.
//  Copyright © 2016 Danny Vasquez. All rights reserved.
//

import Foundation
class stopInfo {
    var stopName: String!
    var latitude: Double!
    var longitude: Double!
    var stringLat: String!
    var stringLong:String!
    var StopID: String!
    var routes: String!
    var direction: String!
    
    
    
    init(busStopDictionary: NSDictionary) {
        
        
        stopName = busStopDictionary["cta_stop_name"] as! String
        stringLat = busStopDictionary["latitude"] as! String
        stringLong = busStopDictionary["longitude"] as! String
//        latitude = busStopDictionary["latitude"] as! String
//        longitude = busStopDictionary["longitude"] as! String
        StopID = busStopDictionary["stop_id"] as! String
        routes = busStopDictionary["routes"] as! String
        direction = busStopDictionary["direction"] as! String
        self.latitude = Double(self.stringLat)!
        self.longitude = Double(self.stringLong)!
        
        
        
        
    }
}

