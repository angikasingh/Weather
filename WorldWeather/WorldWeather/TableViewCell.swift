//
//  TableViewCell.swift
//  WorldWeather
//
//  Created by Angika Singh on 3/18/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblDayOfWeek: UILabel!
    @IBOutlet weak var lblMaxTemp: UILabel!
    @IBOutlet weak var lblMinTemp: UILabel!
    @IBOutlet weak var dayIcon: UIImageView!
    @IBOutlet weak var nightIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
