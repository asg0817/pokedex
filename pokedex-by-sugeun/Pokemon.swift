//
//  Pokemon.swift
//  pokedex-by-sugeun
//
//  Created by IG on 2016. 2. 1..
//  Copyright © 2016년 ansugeun.k. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name:String!
    private var _pokedexId:Int!
    
    var name:String {
        return _name
    }
    var pokedexId:Int{
        return _pokedexId
    }
    
    init(name: String , pokedexId:Int){
        self._name = name
        self._pokedexId = pokedexId
    }
}