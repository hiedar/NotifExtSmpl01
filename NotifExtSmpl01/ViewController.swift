//
//  ViewController.swift
//  NotifExtSmpl01
//
//  Created by 檜枝　龍一 on 2016/11/01.
//
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let foo: String?
        foo = nil
        
        var b: String? = "nobita"
        b = nil; b="doraemon"
        
        var param = 1
        
        if param == 1 {
            param += 1
            
        } else if param == 2 {
            param += 1
            
        } else if param == 1 {            // Noncompliant
            param += 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

