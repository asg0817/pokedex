//
//  ViewController.swift
//  pokedex-by-sugeun
//
//  Created by IG on 2016. 2. 1..
//  Copyright © 2016년 ansugeun.k. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout ,UISearchBarDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak  var collection:UICollectionView!
    
    var pokemonArray = [Pokemon]()
    var filterPokemon = [Pokemon]()
    
    var musicPlayer:AVAudioPlayer!
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        
        /////조금 더 생각
      // let tapRecognizer = UITapGestureRecognizer()
      //tapRecognizer.numberOfTapsRequired = 2
      // tapRecognizer.addTarget(self, action: "collectionViewBackgroundTapped")
        
        //3. Add the tap gesture recognizer to the collection view
        //self.collection.addGestureRecognizer(tapRecognizer)

        searchBar.returnKeyType = UIReturnKeyType.Search
        initAudio()
        parsePokemonCSV()
    }
    
    /////조금 더 생각
   // func collectionViewBackgroundTapped() {
        // Dismiss the keyboard that's shown on the device's screen
  //      searchBar.resignFirstResponder()
  //  }
    

    func initAudio(){
//        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3") // err -> timed out after 0.012s (735 736); mMajorChangePending=0
        let path = NSBundle.mainBundle().URLForResource("music", withExtension: "mp3")
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: path!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    func parsePokemonCSV(){
        
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            for row in rows{
                if let pokeId = Int(row["id"]!) , let name = row["identifier"]{
                    
                    let poke = Pokemon(name: name, pokedexId: pokeId)
                    
                    pokemonArray.append(poke)
                }
                
            }
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let  cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell{
            
            let poke: Pokemon!
            
            if inSearchMode {
                poke = filterPokemon[indexPath.row]
            }else{
                poke = pokemonArray[indexPath.row]
            }

            cell.configureCell(poke)
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var poke:Pokemon!
        
        if inSearchMode {
            poke = filterPokemon[indexPath.row]
        }else {
            poke = pokemonArray[indexPath.row]
        }
        
        performSegueWithIdentifier("PokemonDetailVC", sender: poke)
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filterPokemon.count
        }
            return pokemonArray.count
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return CGSizeMake(105, 105)
    }
    
    @IBAction func musicPressedBtn(sender: UIButton!) {
        if musicPlayer.playing {
            musicPlayer.stop()
            sender.alpha = 0.2
        }else{
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }

    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            collection.reloadData()

        }else{
            inSearchMode = true
            searchBar.showsCancelButton = true
            let lower = searchBar.text!.lowercaseString
            filterPokemon = pokemonArray.filter({$0.name.rangeOfString(lower) != nil})
            collection.reloadData()
        }
        
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false
        inSearchMode = false
        view.endEditing(true)
        collection.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokemonDetailVC" {
            if let detailsVC = segue.destinationViewController as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailsVC.pokemon = poke
                }
            }
        }
    }
    
  
}

