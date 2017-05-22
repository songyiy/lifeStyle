//
//  mainListTableViewCell.swift
//  lifeStyle
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 syi. All rights reserved.
//

import UIKit
import FoldingCell

class mainListTableViewCell: FoldingCell {

    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var intro1: UILabel!
    @IBOutlet weak var intro2: UILabel!
    @IBOutlet weak var author1: UILabel!
    @IBOutlet weak var author2: UILabel!
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    override func animationDuration(_ itemIndex:NSInteger, type:AnimationType)-> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    

}
