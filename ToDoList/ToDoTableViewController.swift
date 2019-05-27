//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Alfredo Camacho on 5/16/19.
//  Copyright © 2019 AlfredoCG. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    var toDos : [ToDo] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // toDos = createToDos()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getToDos()
    }
    
    func getToDos() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataToDos = try? context.fetch(ToDoCoreData.fetchRequest()) as? [ToDoCoreData]{
                if let theToDos = coreDataToDos {
                    toDos = theToDos
                }
            }
        }
    }
    
   
    
//        func createToDos() -> [ToDo]{
//
//            let eggs = ToDo()
//            eggs.name = "Buy eggs"
//            eggs.important = true
//
//            let dog = ToDo()
//            dog.name = "Walk the dog"
//
//            let cheese = ToDo()
//            cheese.name = "Eat cheese"
//
//
//            return [eggs, dog, cheese]
//        }
//
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return toDos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let toDo = toDos[indexPath.row]
        
        if let name = toDo {
            
            if toDo.important {
                cell.textLabel?.text = "❗️" + name
            }else {
                cell.textLabel?.text = toDo.name
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDo = toDos[indexPath.row]
        performSegue(withIdentifier: "moveToComplete", sender: toDo)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC = segue.destination as? AddToDoViewController{
            addVC.previuosVC = self
        }
        
        if let completeVC = segue.destination as? CompleteToDoViewController{
            if let toDo = sender as? ToDo {
                completeVC.selectedToDo = toDo
                completeVC.previuosVC = self
            }
        }
        
    }
    
}
