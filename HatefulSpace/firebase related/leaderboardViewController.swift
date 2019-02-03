//
//  leaderboardViewController.swift
//  HatefulSpace
//
//  Created by Koh Wei Jie on 10/1/19.
//  Copyright © 2019 Yeo Chun Sheng Joel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class leaderboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    var ref: DatabaseReference?
    var databaseHandle:DatabaseHandle?
    
    var Leaderboard = [String]()
    //var Playerboard = [Player]()
    var Testboard = ["What","The","Fly"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
        ref = Database.database().reference()
        
        readLeaderBoard()
        Leaderboard.reverse()
        tableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Leaderboard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = Leaderboard[indexPath.row]
        cell?.textLabel?.font = UIFont(name: "Early GameBoy", size: 20)
        cell?.textLabel?.textColor = UIColor.white
        cell?.textLabel?.textAlignment = .center
        
        return cell!
    }
    
    func readLeaderBoard() {
        databaseHandle = ref?.child("users").queryOrderedByValue().observe(.childAdded, with: { (snapshot) in
            
            let name = snapshot.key
            let score = snapshot.value as? Int
            
            if let Ascore = score {
                
                //let playerentry = Player(pname: name, pscore: score!)
                let leaderentry = name + "     " + String(Ascore)
                
                //self.Playerboard.append(playerentry)
                //let descplayerentry = (String(describing: playerentry))
                
                //self.Leaderboard.append(leaderentry)
                self.Leaderboard.insert(leaderentry, at: 0)
                self.tableview.reloadData()
                
            }
            
            
            
            
        })
        
        
    }
}

