//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by anna :)  on 8/7/16.
//  Copyright © 2016 Anna Chiu. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var bgImg: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptLbl: UILabel!
    
    
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseLbl: UILabel!
    @IBOutlet weak var pokeIDLbl: UILabel!
    
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var firstEvoImg: UIImageView!
    @IBOutlet weak var secEvoImg: UIImageView!
    
    
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name.uppercaseString
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        firstEvoImg.image = img
        
        pokemon.downloadPokemonDetails { () -> () in
            //this will be called after download is done
            print("We Got Here")
            
            self.updateUI()
            
        }

    }
    
    func updateUI() {
        descriptLbl.text = pokemon.description
        
        
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        baseLbl.text = pokemon.attack
        pokeIDLbl.text = "\(pokemon.pokedexId)"
        

        if pokemon.nextEvoLvl == "" {
            evoLbl.text = "No Evolution"
            secEvoImg.hidden = true
        } else {
            secEvoImg.hidden = false
            secEvoImg.image = UIImage(named: pokemon.EvolutionID)
            
            var str = "Next Evolution: \(pokemon.nextEvoText)"
            if pokemon.nextEvoLvl != "" {
                str += " Level \(pokemon.nextEvoLvl)"
            }
            evoLbl.text = str
        }
        if (pokemon.type.rangeOfString("/") == nil) {
            if let img = UIImage(named: pokemon.type){
                bgImg.image = img
            }
            else {
                bgImg.image = UIImage(named: "bg")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }


}
