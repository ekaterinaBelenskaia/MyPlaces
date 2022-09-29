import UIKit
import Cosmos

class CustomTableViewCell: UITableViewCell {
    
 
    @IBOutlet weak var imageOfLocation: UIImageView! {
        didSet {
            imageOfLocation.layer.cornerRadius = imageOfLocation.frame.size.height / 2
            imageOfLocation.clipsToBounds = true
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet var cosmosView: CosmosView! {
        didSet {
            cosmosView.settings.updateOnTouch = false 
        }
    }
}
