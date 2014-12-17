//
//  DashboardTableViewCell.swift
//  WeAppToMoveSwift
//
//  Created by Maarten Bressinck on 11/12/14.
//  Copyright (c) 2014 Maarten Bressinck. All rights reserved.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var activityFooter: UIView!
    
    
    var activityModel:ActivityModel?
    
    // Screen size
    let screenSize: CGRect = UIScreen.mainScreen().bounds

    @IBOutlet weak var ezdze: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

        
        println(activityModel)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
