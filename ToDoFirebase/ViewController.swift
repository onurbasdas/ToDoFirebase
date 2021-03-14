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
    
    var uid : String = ""
    
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
                    self.uid = (result?.user.uid)!
                    let ref = Database.database().reference(withPath: "Users").child(self.uid)
                    ref.setValue(["email" : self.emailText.text!, "password" : self.passwordText.text!])
                    self.performSegue(withIdentifier: "loginSegue", sender: self)
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
                    self.uid = (result?.user.uid)!
                    self.performSegue(withIdentifier: "loginSegue", sender: self)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigation = segue.destination as! UINavigationController
        let todoVC = navigation.topViewController as! ToDoViewController
        todoVC.userID = uid
    }
    
}

