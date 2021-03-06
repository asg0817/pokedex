//
//  Pokemon.swift
//  pokedex-by-sugeun
//
//  Created by IG on 2016. 2. 1..
//  Copyright © 2016년 ansugeun.k. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name:String!
    private var _pokedexId:Int!
    private var _description:String!
    private var _type:String!
    private var _defense:String!
    private var _height:String!
    private var _weight:String!
    private var _attack:String!
    private var _nextEvoTxt:String!
    private var _pokemonUrl:String!
    
    
    
    var name:String {
        return _name
    }
    var pokedexId:Int{
        return _pokedexId
    }
    
    
    
   
    
    init(name: String , pokedexId:Int){
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
    }
    
    func downloadPokemonDetails(completed:DownloadComplete){
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON { response -> Void in
            let result = response.result
            
//            print(result.value.debugDescription)
            
            if let dict = result.value as? Dictionary<String,AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String,String>] where types.count > 0{
//                    print(types.debugDescription)
                    if let name = types[0] ["name"] {
                        self._type = name.capitalizedString
                    }
                    
                    if types.count > 1 {
                        for var x = 1 ; x < types.count ; x++ {
                            if let name = types[x] ["name"]{
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                }else{
                    self._type = ""
                }
                print(self._type)
              
            }
        }
    }
}