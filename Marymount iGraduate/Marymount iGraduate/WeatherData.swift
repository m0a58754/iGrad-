//
//  WeatherData.swift
//  Weather
//
//  Created by Joyce Echessa on 10/16/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

import Foundation

public class WeatherData: NSObject {
    
    let temperature: Int
    let summary: String
  
    public init(weatherDictionary: NSDictionary) {
        let weather = weatherDictionary["currently"] as! NSDictionary
        
        temperature = weather["temperature"] as! Int
        
        summary = weather["summary"]as! String
        
   
    }
    
}
