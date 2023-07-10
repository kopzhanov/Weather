//
//  CurrentWeather.swift
//  Weather
//
//  Created by Alikhan Kopzhanov on 10.07.2023.
//

import Foundation
import SwiftyJSON

struct CurrentWeather{
    var city = ""
    var desc = ""
    var icon = ""
    var temp = 0.0
    var app_temp = 0.0
    
    init(){
    }
    
    init(json:JSON){
        if let item = json["city_name"].string {
            city = item
        }
        if let item = json["temp"].double {
            temp = item
        }
        if let item = json["app_temp"].double {
            app_temp = item
        }
        if let weather = json["weather"].dictionary{
            if let item = weather["description"]?.string {
                desc = item
            }
            if let item = weather["icon"]?.string {
                icon = "https://cdn.weatherbit.io/static/img/icons/\(item).png"
            }
        }
    }
}
