//
//  MovieCell.swift
//  Flix
//
//  Created by Christian Alexander Valle Castro on 10/17/19.
//  Copyright © 2019 valle.co. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    //Mark -Properties
    

    @IBOutlet weak var movieImageView    : UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
