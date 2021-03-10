//
//  CityViewModel.swift
//  WorldWeather
//
//  Created by Ashish Ashish on 10/03/21.
//

import Foundation
import PromiseKit


class WorldWeatherViewModel{
    
    func getCityData(_ url : String) -> Promise<ModelCity> {
        
        return Promise<ModelCity>{ seal ->Void in
            
            getAFResponseJSON(url).done { json in
                
                let key = json["Key"].stringValue
                let city = json["LocalizedName"].stringValue
                let cityModel: ModelCity = ModelCity(key, city)
                
                seal.fulfill(cityModel)
            }
            .catch { error in
                seal.reject(error)
            }
        }
    }
    
    func getCurrentConditions(_ url : String) -> Promise<ModelCurrentCondition>{
        return Promise<ModelCurrentCondition> { seal ->Void in
            
            getAFResponseJSONArray(url).done { currentWeatherJSON in
                
                let weatherText = currentWeatherJSON[0]["WeatherText"].stringValue
                let weatherIcon = currentWeatherJSON[0]["WeatherIcon"].intValue
                let isDayTime = currentWeatherJSON[0]["IsDayTime"].boolValue
                let metricTemp = currentWeatherJSON[0]["Temperature"]["Metric"]["Value"].floatValue
                let imperialTemp = currentWeatherJSON[0]["Temperature"]["Imperial"]["Value"].intValue

                let currCondition = ModelCurrentCondition(weatherText, metricTemp, imperialTemp)
                currCondition.weatherIcon = weatherIcon
                currCondition.isDayTime  = isDayTime
                
                
                seal.fulfill(currCondition)
            
            }
            .catch { error in
                seal.reject(error)
            }
            
        }
    }
    
    func getOneDayConditions(_ url : String) -> Promise<ModelOneDayForecast>{
        return Promise<ModelOneDayForecast> { seal -> Void in
            
            getAFResponseJSON(url).done { json in
                
                let dayForecast = ModelOneDayForecast()
                dayForecast.headlineText = json["Headline"]["Text"].stringValue
                dayForecast.nightTemp = json["DailyForecasts"][0]["Temperature"]["Minimum"]["Value"].intValue
                dayForecast.dayTemp = json["DailyForecasts"][0]["Temperature"]["Maximum"]["Value"].intValue
                dayForecast.dayIcon = json["DailyForecasts"][0]["Day"]["Icon"].intValue
                dayForecast.nightIcon = json["DailyForecasts"][0]["Night"]["Icon"].intValue
                dayForecast.dayIconPhrase = json["DailyForecasts"][0]["Day"]["IconPhrase"].stringValue
                dayForecast.nightIconPhrase = json["DailyForecasts"][0]["Night"]["IconPhrase"].stringValue

                seal.fulfill(dayForecast)
            
            }
            .catch { error in
                seal.reject(error)
            }
            
        }
    }
}
