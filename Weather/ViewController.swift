//
//  ViewController.swift
//  Weather
//
//  Created by Alikhan Kopzhanov on 10.07.2023.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import SDWebImage

class ViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    var currentWeather = CurrentWeather()
    
    let API_KEY = "baceb4bde52e4b248ae7ea2a47c9b67e"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        searchBar.placeholder = "Search City"
        
        getCurrent(city: "Almaty")
    }
    
    func getCurrent(city: String){
        let parameters = ["key" : API_KEY, "city" : city] as [String:Any]
        
        SVProgressHUD.show()
        
        AF.request("https://api.weatherbit.io/v2.0/current?", method: .get, parameters: parameters).responseJSON { response in
            
            SVProgressHUD.dismiss()
            
            if response.response?.statusCode == 200 {
                print(200)
                let json = JSON(response.value!)
                print(json)
                if let data = json["data"].array {
                    self.currentWeather = CurrentWeather(json: data[0])
                    self.updateInfo()
                }
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getCurrent(city: searchBar.text!)
    }
    
    func updateInfo(){
        cityLabel.text = currentWeather.city
        descriptionLabel.text = currentWeather.desc
        weatherImageView.sd_setImage(with: URL(string: currentWeather.icon))
        tempLabel.text = "Temperature: \(currentWeather.temp)°C"
        feelsLikeLabel.text = "Feels Like: \(currentWeather.app_temp)°C"
    }
    @IBAction func showWeeklyForecast(_ sender: Any) {
    }
}
