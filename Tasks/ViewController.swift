//
//  ViewController.swift
//  Tasks
//
//  Created by said fatah on 13/4/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView : UITableView!
    var tasks = [String]()
    // var tasks:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        // setup saving mechanism using user defaults
        if UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "tasks_count")
        }
        // get all current saved tasks
        updateTasks()
    }


    func updateTasks(){
        tasks.removeAll()
        
        guard var count = UserDefaults().integer(forKey: "tasks_count") as? Int else {
            return
        }
        
        for x in 0..<count {
            if let task = UserDefaults().value(forKey:"task_count\(x+1)") as? String{
                print(task)
                tasks.append(task)
            }
        }
        tableView.reloadData()
    }
    @IBAction func addTask(_ sender: Any) {
        //
        let vc = storyboard?.instantiateViewController(withIdentifier:"entry") as! EntryViewController
        vc.title = "New Task"
        vc.update = {
            print("save tasks")
            // prioritise updating tasks over building the UI
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // deselect the row to get red of the highlithing color that pops up
        tableView.deselectRow(at: indexPath, animated: false)
        
        let vc = storyboard?.instantiateViewController(withIdentifier:"task") as! TaskViewController
        vc.title = "Task Info"
        vc.task = tasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeue the cell first
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // config the content
        var content = cell.defaultContentConfiguration()
        content.text = tasks[indexPath.row]
        
        cell.contentConfiguration = content
        return cell
    }


}
