//
//  ViewController.swift
//  NotifExtSmpl01
//
//  Created by 檜枝　龍一 on 2016/11/01.
//
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-1.jpg")!
        
        self.imageView.kf.setImage(with: url)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

