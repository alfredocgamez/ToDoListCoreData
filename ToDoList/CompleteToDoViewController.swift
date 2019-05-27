//
//  CompleteToDoViewController.swift
//  ToDoList
//
//  Created by Alfredo Camacho on 5/16/19.
//  Copyright © 2019 AlfredoCG. All rights reserved.
//

import UIKit

class CompleteToDoViewController: UIViewController {
    
    var previuosVC = ToDoTableViewController()
    
    var selectedToDo = ToDo()

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = selectedToDo.name
    }
    

    @IBAction func completeTapped(_ sender: Any) {
        var index = 0
        for toDo in previuosVC.toDos {
            if toDo.name == selectedToDo.name{
                previuosVC.toDos.remove(at: index)
                previuosVC.tableView.reloadData()
                navigationController?.popViewController(animated: true)
                break
            }
            index += 1
        }
    }
    
}
