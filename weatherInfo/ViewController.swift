//
//  ViewController.swift
//  weatherInfo
//
//  Created by yuto_o on 2018/10/21.
//  Copyright © 2018 yuto_o. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var info: String?
    @IBOutlet weak var infoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.infoLabel?.text = self.info
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

