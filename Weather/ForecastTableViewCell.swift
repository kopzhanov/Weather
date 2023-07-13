//
//  ForecastTableViewCell.swift
//  Weather
//
//  Created by Alikhan Kopzhanov on 10.07.2023.
//

import UIKit
import SDWebImage

class ForecastTableViewCell: UITableViewCell {
//    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    var count = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(daycast: CurrentWeather){
        print(count)
//        dateLabel.text = getDayNameBy(stringDate: daycast.date)
//        if count == 0{
//            dateLabel.text = "Today"
//        } else {
//            dateLabel.text = getDayNameBy(stringDate: daycast.date)
//        }
        weatherImageView.sd_setImage(with: URL(string: daycast.icon))
        tempLabel.text = "Temperature: \(daycast.temp)°C"
        count += 1
        if count == 7 {
            count = 0
        }
    }
    
//    func getDayNameBy(stringDate: String) -> String
//        {
//            let df  = DateFormatter()
//            df.dateFormat = "YYYY-MM-dd"
//            let date = df.date(from: stringDate)!
//            df.dateFormat = "E"
//            return df.string(from: date);
//        }
//        
}
