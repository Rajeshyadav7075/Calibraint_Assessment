//
//  DropDownTableViewCell.swift
//  Calibrant_assesment
//
//  Created by Rajesh on 03/06/21.
//

import UIKit

class DropDownTableViewCell: UITableViewCell {

    @IBOutlet weak var dropDown: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
