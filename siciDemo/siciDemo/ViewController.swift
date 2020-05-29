//
//  ViewController.swift
//  siciDemo
//
//  Created by iOS on 2020/5/6.
//  Copyright © 2020 123. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        if let _ = UserDefaults.standard.object(forKey: "TOKEN") as? String {
            TestService.getSentence { (isSucc, msg, result) in
                
            }
        } else {
            TestService.getToken { (isSucc, token) in
                if isSucc {
                    TestService.getSentence { (isSucc, msg, result) in
                        
                    }
                }
            }
        }
    }


}

