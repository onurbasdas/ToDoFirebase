//
//  ToDoViewController.swift
//  ToDoFirebase
//
//  Created by Onur Başdaş on 14.03.2021.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

struct Todo {
    var isChecked : Bool
    var todoName : String
}


class ToDoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var todoTV: UITableView!
    
    
    var userID: String?
    var todos : [Todo] =  []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTV.delegate = self
        todoTV.dataSource = self
        todoTV.rowHeight = 80
        
        if let uid = userID{
            welcomeLabel.text = uid
        }
        
        loadTodos()
        
    }
    
    func loadTodos() {
        let ref = Database.database().reference(withPath: "Users").child(userID!).child("todos")
        
        ref.observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let todoName = child.key
                
                let todoRef = ref.child(todoName)
                
                todoRef.observeSingleEvent(of: .value) { (todoSnapshot) in
                    let value = todoSnapshot.value as? NSDictionary
                    let isChecked = value!["isChecked"] as? Bool
                    self.todos.append(Todo(isChecked: isChecked!, todoName: todoName))
                    self.todoTV.reloadData()
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoCell
        cell.todoLabel.text = todos[indexPath.row].todoName
        
        if todos[indexPath.row].isChecked{
            cell.checkImage.image = UIImage(named: "checkmark.png")
        }else{
            cell.checkImage.image = nil
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let ref = Database.database().reference(withPath: "Users").child(userID!).child("todos").child(todos[indexPath.row].todoName)
        
        if todos[indexPath.row].isChecked{
            todos[indexPath.row].isChecked = false
            ref.updateChildValues(["isChecked" : false])
        }else{
            todos[indexPath.row].isChecked = true
            ref.updateChildValues(["isChecked" : true])
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let ref = Database.database().reference(withPath: "Users").child(userID!).child("todos").child(todos[indexPath.row].todoName)
            ref.removeValue()
            todos.remove(at: indexPath.row)
            todoTV.reloadData()
        }
    }
    
    
}
