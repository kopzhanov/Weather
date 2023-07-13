//
//  TableViewController.swift
//  Weather
//
//  Created by Alikhan Kopzhanov on 10.07.2023.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class TableViewController: UITableViewController {

    var forecast : [CurrentWeather] = []
    let API_KEY = "baceb4bde52e4b248ae7ea2a47c9b67e"
    var city = ""
    var count = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(forecast)
        getForecast()
        self.tableView.reloadData()


//        print("test")
//        for item in forecast{
//            print(item)
//        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func getForecast(){
        let parameters = ["key":API_KEY, "city" : city, "days":7] as [String:Any]
        
        SVProgressHUD.show()
        
        AF.request("https://api.weatherbit.io/v2.0/forecast/daily?", method: .get, parameters: parameters).responseJSON { response in
            SVProgressHUD.dismiss()
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.value!)
                print("forecast")
                print(json)
                if let data = json["data"].array{
                    print(data)
                    for day in data{
                        let weather = CurrentWeather(json: day)
                        self.forecast.append(weather)
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return forecast.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ForecastTableViewCell
        
        let label = cell.viewWithTag(1000) as! UILabel
        if count == 0 {
            label.text = "Today"
        } else {
            label.text = getDayNameBy(stringDate: forecast[indexPath.row].date)
        }
        count += 1
        cell.setData(daycast: forecast[indexPath.row])
        return cell
    }
    
    func getDayNameBy(stringDate: String) -> String
        {
            let df  = DateFormatter()
            df.dateFormat = "YYYY-MM-dd"
            let date = df.date(from: stringDate)!
            df.dateFormat = "E"
            return df.string(from: date);
        }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
