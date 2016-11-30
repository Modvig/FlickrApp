//
//  PublicImageTableViewCell.swift
//  FlickrApp
//
//  Created by Michael Modvig on 30/11/2016.
//  Copyright © 2016 Michael Modvig. All rights reserved.
//

import UIKit

class PublicImageTableViewCell: UITableViewCell {

    @IBOutlet var iv: UIImageView!
    @IBOutlet var il: UILabel!
    
    func downloadImage(url: URL) {
        DispatchQueue.global(qos: .userInitiated).async {
            
        }
        
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
