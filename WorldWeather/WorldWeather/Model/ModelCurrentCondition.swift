//
//  ModelCurrentCondition.swift
//  WorldWeather
//
//  Created by Ashish Ashish on 10/03/21.
//

import Foundation

class ModelCurrentCondition{
    
    var weatherText : String = ""
    var weatherIcon : Int = 0
    var isDayTime : Bool = true
    var metricTemp : Float = 0.0
    var imperialTemp : Int = 0
    
    init(_ weatherText : String, _ metricTemp : Float, _ imperialTemp : Int) {
        self.weatherText = weatherText
        self.metricTemp = metricTemp
        self.imperialTemp  = imperialTemp
    }
}
