//
//  GuideTableViewCell.swift
//  AccesRecs
//
//  Created by Norin Lavaee on 10/8/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

import UIKit

class GuideTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lB1Name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func clickMe(_ sender: Any) {
        
    }
}
