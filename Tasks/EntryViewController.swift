//
//  EntryViewController.swift
//  Tasks
//
//  Created by said fatah on 13/4/2022.
//

import UIKit

class EntryViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    
    var update :(() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(saveTask))
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
    
    @objc func saveTask() {
        guard let text = textField.text, !text.isEmpty else {
            return
        }
        
        guard var count = UserDefaults().integer(forKey: "tasks_count") as? Int else {
            return
        }
        let newCount = count + 1
        count = newCount
        
        UserDefaults().set(count, forKey: "tasks_count")
        UserDefaults().set(text, forKey: "task_count\(count)")
        update?()
        navigationController?.popViewController(animated: true)
        
    }
    
}
