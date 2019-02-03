//
//  gameEnd.swift
//  HatefulSpace
//
//  Created by Koh Wei Jie on 24/1/19.
//  Copyright © 2019 Yeo Chun Sheng Joel. All rights reserved.
//



import UIKit
import Firebase
import FirebaseDatabase

class gameEnd: UIViewController {
    
    @IBOutlet weak var lblScore: UILabel!
    
    @IBOutlet weak var txtName: UITextField!
    var ref: DatabaseReference!
    var playerscore = 0
    
    
    @IBAction func continueBtn(_ sender: Any) {
        if txtName.text == ""{
            print("no text")
        }
        else{
            let username = txtName.text
            self.ref.child("users").child(username!).setValue(playerscore)
            print("Saved!")
        }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "leaderboard")
        present(vc!, animated: false, completion: nil)
        
    }
    
    @IBAction func btnHome(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "home")
        present(vc!, animated: false, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(globalScore)
        lblScore.text = String(globalScore)
        playerscore = globalScore
        ref = Database.database().reference()
    }
}
