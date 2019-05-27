//
//  AddToDoViewController.swift
//  ToDoList
//
//  Created by Alfredo Camacho on 5/16/19.
//  Copyright © 2019 AlfredoCG. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController {
    
    var previuosVC = ToDoTableViewController() //Hace referencia a la case de ToDoTableViewController para poder acceder a todo.
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var importantSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func addTapped(_ sender: Any) {
/*
        let toDo = ToDo()
        
        if let titleText  = titleTextField.text {
            
            toDo.name = titleText
            toDo.important = importantSwitch.isOn
            
            previuosVC.toDos.append(toDo) //Agrega el nuevo item
            
            previuosVC.tableView.reloadData() //Checa si hay información nueva y la carga en la tabla
            
            navigationController?.popViewController(animated: true) //Regresa a la pantalla de la tabla agregando el nuevo item
            
        }
        
*/
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            let toDo = ToDoCoreData(entity: ToDoCoreData.entity(), insertInto: context)
            
            if let titleText  = titleTextField.text {
                toDo.name = titleText
                toDo.important = importantSwitch.isOn
            }
            try? context.save()
            navigationController?.popViewController(animated: true)
            
        }
        
        
        
    
    }
    
}
