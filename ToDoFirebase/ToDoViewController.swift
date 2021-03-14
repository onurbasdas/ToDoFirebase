//
//  ToDoViewController.swift
//  ToDoFirebase
//
//  Created by Onur Başdaş on 14.03.2021.
//

import UIKit

class ToDoViewController: UIViewController {
    
    var userID: String?

    @IBOutlet var welcomeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let uid = userID{
            welcomeLabel.text = uid
        }
        
    }
    

}
