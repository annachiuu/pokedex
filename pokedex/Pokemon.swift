 //
//  Pokemon.swift
//  pokedex
//
//  Created by anna :)  on 8/2/16.
//  Copyright © 2016 Anna Chiu. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvoText: String!
    private var _EvolutionID: String!
    private var _nextEvoLvl: String!
    
    private var _pokemonUrl: String!
    
    var pokemonData: [Pokemon] = []
    
    var name : String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexID
    }
    
    var description: String {
        
            if _description == nil {
                _description = ""
            }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil{
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil{
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvoText: String {
        if _nextEvoText == nil {
            _nextEvoText = ""
        }
        return _nextEvoText
    }
    
    var EvolutionID: String {
        if _EvolutionID == nil {
            _EvolutionID = ""
        }
        return _EvolutionID
    }
    
    var nextEvoLvl: String {
        if _nextEvoLvl == nil {
            _nextEvoLvl = ""
        }
        return _nextEvoLvl
    }

    
    
    //"/api/v1/pokemon/1/"
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexID = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexID)/"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        
        let url = NSURL(string: _pokemonUrl)!
        
        Alamofire.request(.GET, url).responseJSON {
            response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
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
                
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
        //types is an array in the JSON
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0{
                    
                    if let name = types[0]["name"] { //grabbing the first type element
                        self._type = "\(name.capitalizedString)"
                    }
                    
                    if types.count > 1 {
                        for var x = 1; x < types.count; x++ {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                }else {
                    self._type = ""
                }
                print(self._type)
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0 {
                    if let url = descArr[0]["resource_uri"] {
                        
                        let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                        Alamofire.request(.GET, nsurl).responseJSON {
                            response in
                            let result = response.result
                            
                            if let descDict = result.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                    print(self._description)
                                }
                                
                            }
                            completed()
                        }
                        
                        
                        
                        }
                    } else {
                        self._description = ""
                    }
                    
                    if let evolArray = dict["evolutions"] as? [Dictionary<String,AnyObject>] where evolArray.count > 0{
                        print("I got here")
                        
                        if let to = evolArray[0]["to"] as? String {
                            
                            //can't support mega pokemon right now
                           if to.rangeOfString("mega") == nil {
                                
                                if let uri = evolArray[0]["resource_uri"] as? String {
                                    let newStr = uri.stringByReplacingOccurrencesOfString(URL_POKEMON, withString: "")
                                    
                                    let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                    
                                    self._EvolutionID = num
                                    self._nextEvoText = to
                                    
                                }
                                if let evolLvl = evolArray[0]["level"] as? Int {
                                    self._nextEvoLvl = "\(evolLvl)"
                                } else {
                                    self._nextEvoLvl = ""
                            }
                                
                                print(self._EvolutionID)
                                print(self._nextEvoLvl)
                                print(self._nextEvoText)
                                
                            }
                            
                        }
                    } else {
                        self._EvolutionID = ""
                        
                        self._nextEvoText = ""
                    }

                }
            
        
        }

    }
}






