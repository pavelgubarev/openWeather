import UIKit

final class CityListCell: UITableViewCell {

    @IBOutlet private weak var cityName : UILabel!
    
    func set(cityName : String) {
        self.cityName.text = cityName
    }

}
