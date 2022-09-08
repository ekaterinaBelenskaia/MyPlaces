//
//  MainViewController.swift
//  MyPlaces
//
//  Created by Ekaterina on 8.09.22.
//

import UIKit

class MainViewController: UITableViewController {

    let restarauntNames = ["AtoRamen", "AtoSushi", "Fermento", "Manekin", "Piana Wishnia", "The Brick", "Танчао", "Хинкальная"]
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return restarauntNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
//        var content = cell.defaultContentConfiguration()
        cell.nameLabel.text = restarauntNames[indexPath.row]
        cell.imageOfLocation.image = UIImage(named: restarauntNames[indexPath.row])
        cell.imageOfLocation.layer.cornerRadius = cell.imageOfLocation.frame.size.height / 2
        cell.imageOfLocation.clipsToBounds = true

//        cell.contentConfiguration = content
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
