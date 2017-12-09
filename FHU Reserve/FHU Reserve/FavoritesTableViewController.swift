//
//  AvailableRoomsTableViewController.swift
//  FHU Reserve
//
//  Created by Jeremy Beard on 11/14/17.
//  Copyright © 2017 Freed Hardeman University. All rights reserved.
//

import UIKit


class FavoritesTableViewController: UITableViewController {
    
    
    var favorites = FavoritesSet.favorites
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favorites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteRoomCell", for: indexPath)
        
        if let roomCell = cell as? FavoritesTableViewCell{
            roomCell.roomName.text = "Room \(favorites[indexPath.row].roomNumber ?? 0)"
            roomCell.roomDescription.text = favorites[indexPath.row].roomDescription
            if let imageName = favorites[indexPath.row].imageName {
                roomCell.roomImage.image = UIImage(named: imageName)
            }
            else{
                roomCell.roomImage?.image = nil
            }
            
        }
        
        return cell
    }
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let segIdentifier = segue.identifier {
            if segIdentifier == "FavoriteRoomSegue" {
                if let favoritesViewController = segue.destination as? FavoritesViewController,
                    let cell = sender as? UITableViewCell
                {
                    if let indexPath = tableView.indexPath(for: cell) {
                    
                        favoritesViewController.room = favorites[indexPath.row]

                    }
                }
                
            }
        }
        
    }
    
    
}

