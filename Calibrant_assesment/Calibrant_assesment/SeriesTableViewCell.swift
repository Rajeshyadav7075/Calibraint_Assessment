//
//  SeriesTableViewCell.swift
//  Calibrant_assesment
//
//  Created by Rajesh on 02/06/21.
//

import UIKit

protocol CellDelegate {
    
    func cellData(id: Netflix)
}

class SeriesTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbNail: UIImageView!
    @IBOutlet weak var seriesTitle: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var episodes: UIButton!
    
    var delegate: CellDelegate?
    var id: Netflix?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.episodes.addTarget(self, action: #selector(onTappingEpisode(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onTappingEpisode(_ sender: UIButton) {
        
        if let id = id {
            
            self.delegate?.cellData(id: id)
        }
    }
}

