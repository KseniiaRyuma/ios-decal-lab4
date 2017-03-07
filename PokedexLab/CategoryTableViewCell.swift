//
//  CategoryTableViewCell.swift
//  PokedexLab
//
//  Created by Kseniia Ryuma on 3/6/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonImg: UIImageView!

    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonNum: UILabel!
    
    @IBOutlet weak var pokemonScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
