//
//  ViewController.swift
//  WorldWeather
//
//  Created by Ashish Ashish on 08/03/21.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftSpinner
import SwiftyJSON
import PromiseKit

/*
 Localization Steps:
 1. Click on the Project in the left top bar
 2. Select the project from the Project in the main screen
 3. In the Localizations section Click on + button to add your localized language
 4. Create a local folder and call it Localizable
 5. Add a new Strings file and call it Localizable too
 6. Add a key value pair in the file like following "hello_world" = "Hello World"; // remember to terminate string by semi colon
 7. Click on the Localizable.string file and in the right menu (identity inspector) you will see a Localization section
 8. Click on the Localize button in the Localization section
 9. In the Pop up click on Localize
 10. In the identity inspector check for all the languages you want to localize
 11. Create a file called Utilities
 12. Add a Swift file called LocalizationUtil.swift
 13. Add a variable for the string you want to localize and localize it with the Key added in the strings file as follows
 14. var strHelloWorld = NSLocalizedString("hello_world", comment: "")
 15. Replace Corresponding text in the language files with localized text
 16. Add a function which will initialize the text for all the UI Elements
 17. Call the initialize text from the viewDidLoad()
 
 */

class WorldWeatherViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var lblCity: UILabel!
    
    @IBOutlet weak var lblCondition: UILabel!
    
    @IBOutlet weak var lblTemperature: UILabel!
    
    @IBOutlet weak var lblHighLow: UILabel!
    
    let locationManager = CLLocationManager()
    
    // We need to have a class of View Model
    let viewModel = WorldWeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeText()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func initializeText(){
        self.title = strHelloWorld
        lblCity.text = strCity
        lblCondition.text = strCondition
        lblTemperature.text = strTemperature
        lblHighLow.text = strHighLow
    }
    
    //MARK: Location Manager functions
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let currLocation = locations.last{
            
            let lat = currLocation.coordinate.latitude
            let lng = currLocation.coordinate.longitude
            
            print(lat)
            print(lng)
            updateWeatherData(lat, lng)
        }
    }
    
    
    //MARK: Update the weather from ViewModel
    
    func updateWeatherData(_ lat : CLLocationDegrees, _ lng : CLLocationDegrees){
        
        let cityDataURL = getLocationURL(lat, lng)
        
        viewModel.getCityData(cityDataURL).done { city in
            // Update City Name
            self.lblCity.text = city.cityName
            
            let key = city.cityKey
            
            let currentConditionURL = getCurrentConditionURL(key)
            let oneDayForecastURL = getOneDayURL(key)
            
            
            self.viewModel.getCurrentConditions(currentConditionURL).done { currCondition in
                self.lblCondition.text = currCondition.weatherText
                self.lblTemperature.text =  "\(currCondition.imperialTemp)°"
            }.catch { error in
                print("Error in getting current conditions \(error.localizedDescription)")
            }
            
            self.viewModel.getOneDayConditions(oneDayForecastURL).done { oneDay in
                self.lblHighLow.text = "H: \(oneDay.maxTemp)° L: \(oneDay.minTemp)°"
                
            }.catch { error in
                print("Error in getting one day forecast conditions \(error.localizedDescription)")
            }
        }
        .catch { error in
            print("Error in getting City Data \(error.localizedDescription)")
        }
    }
}

