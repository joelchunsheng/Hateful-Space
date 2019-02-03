//
//  home.swift
//  AMAD
//
//  Created by Yeo Chun Sheng Joel on 7/1/19.
//  Copyright © 2019 Yeo Chun Sheng Joel. All rights reserved.
//

import UIKit

class homeViewController: UIViewController{

    @IBOutlet weak var gifView: UIImageView!
    @IBOutlet weak var btnStart: UIButton!
    
    override func viewDidLoad() {
    super.viewDidLoad()
        gifView.loadGif(name: "HatefulSpace")
        
        //design for btns
//        btnStart.layer.cornerRadius = 20
//        btnStart.layer.borderWidth = 1
//        btnStart.layer.borderColor = UIColor.white.cgColor
        
        
    }
    
    
    
    
}
