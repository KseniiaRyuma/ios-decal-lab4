//
//  CategoryViewController.swift
//  PokedexLab
//
//  Created by SAMEER SURESH on 2/25/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
   
    @IBOutlet weak var tableView: UITableView!
    
    var pokemonArray: [Pokemon]?
    var cachedImages: [Int:UIImage] = [:]
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (pokemonArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "toPokemonInfo", sender: self)
    }
    
//    We want to display four things on each cell: the name, number, key stats (attack/defense/health),and
//    image for each Pokemon. Drag out the necessary UI elements and place them on the cell.
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell") as! CategoryTableViewCell
        
        cell.pokemonName.text = pokemonArray?[indexPath.item].name
        cell.pokemonNum.text = "#\(pokemonArray![indexPath.item].number!)"
        cell.pokemonScore.text = "\(pokemonArray![indexPath.item].attack!)/\(pokemonArray![indexPath.item].defense!)/\(pokemonArray![indexPath.item].health!)"
        
        if let image = cachedImages[indexPath.row] {
            cell.pokemonImg.image = image
        } else {
            let url = URL(string: (pokemonArray?[indexPath.item].imageUrl)!)!
            let session = URLSession(configuration: .default)
            let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
                if let e = error {
                    print("Error downloading picture: \(e)")
                } else {
                    if let _ = response as? HTTPURLResponse {
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            self.cachedImages[indexPath.row] = image
                            cell.pokemonImg.image = UIImage(data: imageData)
                        } else {
                            print("Couldn't get image: Image is nil")
                        }
                    } else {
                        print("Couldn't get response code")
                    }
                }
            }
            downloadPicTask.resume()
        }
     return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPokemonInfo"{
            if let destinationVC = segue.destination as? PokemonInfoViewController {
                destinationVC.pokemon = pokemonArray?[(selectedIndexPath?.item)!]
                
                if let x = cachedImages[(selectedIndexPath?.item)!] {
                    destinationVC.image = x
                }
                
            }
            
        }
    }

}
