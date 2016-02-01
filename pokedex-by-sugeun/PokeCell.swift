//
//  PokeCell.swift
//  pokedex-by-sugeun
//
//  Created by IG on 2016. 2. 1..
//  Copyright © 2016년 ansugeun.k. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumImg:UIImageView!
    @IBOutlet weak var nameLbl:UILabel!
    
    var pokeMon: Pokemon!
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon){
        self.pokeMon = pokemon
        
        nameLbl.text = self.pokeMon.name.capitalizedString
        thumImg.image = UIImage(named: "\(self.pokeMon.pokedexId)")
    }
}
