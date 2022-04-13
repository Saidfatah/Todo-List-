//
//  TaskViewController.swift
//  Tasks
//
//  Created by said fatah on 13/4/2022.
//

import UIKit

class TaskViewController: UIViewController {
    @IBOutlet weak var label : UILabel!
    var task:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = task
        // Do any additional setup after loading the view.
    }

}
