//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Alfredo Camacho on 5/16/19.
//  Copyright © 2019 AlfredoCG. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    var toDos : [ToDoCoreData] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        getToDos()
        tableView.reloadData()
    }
    
    func getToDos() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext,
           let coreDataToDos = try? context.fetch(ToDoCoreData.fetchRequest()) as? [ToDoCoreData] {
            
            toDos = coreDataToDos
            
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let toDo = toDos[indexPath.row]
        cell.textLabel?.text = "\((toDo.important ? "❗️":""))" + (toDo.name ?? "")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
