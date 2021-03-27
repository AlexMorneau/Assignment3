//
//  CheckoutCell.swift
//  Assignment2
//
//  Created by user191445 on 2/19/21.
//

import UIKit

class CheckoutCell: UITableViewCell {
    
    @IBOutlet var label_type : UILabel!
    @IBOutlet var label_size : UILabel!
    @IBOutlet var label_num : UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
