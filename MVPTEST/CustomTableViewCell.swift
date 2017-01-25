//
//  CustomTableViewCell.swift
//  MVPTEST
//
//  Created by Eang Pheara on 12/27/16.
//  Copyright © 2016 Eang Pheara. All rights reserved.
//

import UIKit
import Kingfisher
class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var thumnialImage: UIImageView!
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
    
    func configurCell(article: Article){
        titleLabel.text = article.title!
        descriptionLabel.text = article.description!
        thumnialImage.kf.setImage(with: URL(string: article.imageUrl!))
        
    }

}
