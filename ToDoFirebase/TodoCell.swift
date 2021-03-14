//
//  TodoCell.swift
//  ToDoFirebase
//
//  Created by Onur Başdaş on 14.03.2021.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet var checkImage: UIImageView!
    @IBOutlet var todoLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
