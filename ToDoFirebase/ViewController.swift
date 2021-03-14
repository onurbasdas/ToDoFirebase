//
//  ViewController.swift
//  ToDoFirebase
//
//  Created by Onur Başdaş on 14.03.2021.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {
    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func registerClicked(_ sender: Any) {
        if emailText.text != nil && passwordText.text != nil{
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (result, error) in
                if error != nil{
                    print(error?.localizedDescription as Any)
                }else{
                    let uid = result?.user.uid
                    let ref = Database.database().reference(withPath: "Users").child(uid!)
                    ref.setValue(["email" : self.emailText.text!, "password" : self.passwordText.text!])
                }
            }
        }
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        if emailText.text != nil && passwordText.text != nil{
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (result, error) in
                if error != nil{
                    print(error?.localizedDescription as Any)
                }else{
//                    let uid = result?.user.uid
                }
            }
        }
    }
}

