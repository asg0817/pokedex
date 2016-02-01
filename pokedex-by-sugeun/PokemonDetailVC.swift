//
//  pokemonDetailVC.swift
//  pokedex-by-sugeun
//
//  Created by 안수근 on 2016. 2. 1..
//  Copyright © 2016년 ansugeun.k. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var pokemonNameLbl: UILabel!
    var pokemon:Pokemon!
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonNameLbl.text = pokemon.name
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
