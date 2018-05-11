//
//  ViewControllerTableViewCell.swift
//  testphotostocloud
//
//  Created by Lauren Traum on 4/20/18.
//  Copyright © 2018 Lauren Traum. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {
    
    //labelFoundItemDateFound.text = FeedViewController().id.foundItemDateFound
    
    @IBOutlet weak var labelFoundItemDateFound: UILabel!
    @IBOutlet weak var labelFoundItemDescription: UILabel!
    @IBOutlet weak var labelFoundItemLocation: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
