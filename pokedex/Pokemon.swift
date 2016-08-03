//
//  Pokemon.swift
//  pokedex
//
//  Created by anna :)  on 8/2/16.
//  Copyright © 2016 Anna Chiu. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokedexID: Int!
    
    var name : String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexID
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexID = pokedexId
    }
}