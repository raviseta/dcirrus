//
//  DownloadsTableViewCell.swift
//  Dcirrus
//
//  Created by Gaadha on 19/09/19.
//  Copyright © 2019 Goodbits. All rights reserved.
//

import UIKit
import SwipeCellKit

class DownloadsTableViewCell: SwipeTableViewCell {
    
    @IBOutlet weak var m_lblimgName: UILabel!
    @IBOutlet weak var m_imgfile: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
