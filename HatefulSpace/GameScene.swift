//
//  GameScene.swift
//  HatefulSpace
//
//  Created by Yeo Chun Sheng Joel on 7/1/19.
//  Copyright © 2019 Yeo Chun Sheng Joel. All rights reserved.
//

import SpriteKit
import GameplayKit

var globalScore:Int!

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //properties
    var starfield:SKEmitterNode!
    var player:SKSpriteNode!
    
    var scoreLabel:SKLabelNode!
    
    var score: Int = 0{
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var livesArray:[SKSpriteNode]!
    
    var gameTimer:Timer!
    //var possibleAliens = ["alien","alien2","alien3"]
    var possibleAliens = [globalAlienimg, globalAlienimg2, globalAlienimg3]
    
    override func didMove(to view: SKView) { //this is view.didload
        starfield = SKEmitterNode(fileNamed: "Starfield") // load starfield file into scene
        starfield.position = CGPoint(x: 0, y: self.frame.size.height)
        starfield.advanceSimulationTime(10)
        self.addChild(starfield)
        
        starfield.zPosition = -1 //make it behind
        
        player = SKSpriteNode(imageNamed: "shuttle")
        player.position = CGPoint(x: 0  , y: -(self.frame.size.height/2.5))
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.isDynamic = true
        
        player.physicsBody?.categoryBitMask = 1
        player.physicsBody?.contactTestBitMask = 2
        player.physicsBody?.collisionBitMask = 2
        
        self.addChild(player)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0) //used this to stop the game from flickering
        self.physicsWorld.contactDelegate = self
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: 0, y: self.frame.size.height/2.45)
        scoreLabel.fontSize = 28
        scoreLabel.fontColor = UIColor.white
        scoreLabel.fontName = "Early GameBoy"
        score = 0
        self.addChild(scoreLabel)
        
        displayLives()
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(addAlien), userInfo: nil, repeats: true)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(fireTorpedo), userInfo: nil, repeats: true)


        physicsWorld.contactDelegate = self
    }
    

    
    func displayLives(){
        livesArray = [SKSpriteNode]()
        for lives in 1...3{
            print(lives)
            var livenode: SKSpriteNode!
            livenode = SKSpriteNode(imageNamed: "shuttle")
            livenode.size = CGSize(width: 70, height: 70)
            livenode.position = CGPoint(x: Int(-livenode.size.width*2) + lives * Int(livenode.size.width), y: Int(scoreLabel.position.y - 50) )
            addChild(livenode)
            livesArray.append(livenode)
        }
    }
    
    @objc func addAlien(){
        
        possibleAliens = possibleAliens.shuffled()
        UserDefaults.standard.set( possibleAliens[0]?.pngData(), forKey: "a1")
        let tex:SKTexture = SKTexture(image: possibleAliens[0]!)
        let alien:SKSpriteNode = SKSpriteNode(texture: tex)
        alien.name = "alien"
     //////////////////////////////////////////////////////////
        //random x axis position
//        let randomAlienPosition = GKRandomDistribution(lowestValue: Int(-self.frame.size.width/2), highestValue: Int(self.frame.size.width/2))
//
//        let position = CGFloat(randomAlienPosition.nextInt())
//
//        alien.position = CGPoint(x: position, y: self.frame.size.height )
        
        /////////////////////////////////////////////////////////
        var sizeRect = UIScreen.main.bounds;
//        var posX = (arc4random_uniform(UInt32(sizeRect.size.width))*2)
//        var posY = (arc4random_uniform(UInt32(sizeRect.size.height))*2)
//
//        alien.position = CGPoint(x: CGFloat(posX)-sizeRect.size.width, y: CGFloat(posY)-sizeRect.size.height)
        let xaxis = [UInt32(sizeRect.size.width)*2, UInt32(0)]
        
        
        var posY = (arc4random_uniform(UInt32(sizeRect.size.height))*2)
        
        if (posY == UInt32(0)) || (posY == UInt32(sizeRect.size.height)*2){
            var posX = (arc4random_uniform(UInt32(sizeRect.size.width))*2)
            alien.position = CGPoint(x: CGFloat(posX)-sizeRect.size.width, y: CGFloat(posY)-sizeRect.size.height)
        }
        else{
            var posX = xaxis.randomElement()!
            alien.position = CGPoint(x: CGFloat(posX)-sizeRect.size.width, y: CGFloat(posY)-sizeRect.size.height)
        }
        
        
        ////////////////////////////////////////////////////////
        
        alien.physicsBody = SKPhysicsBody(rectangleOf: alien.size)
        alien.physicsBody?.isDynamic = false

        alien.physicsBody?.categoryBitMask = 2
        alien.physicsBody?.contactTestBitMask = 2
        alien.physicsBody?.collisionBitMask = 2
        
        self.addChild(alien)
        
        let animationDuration:TimeInterval = 6
        
        var actionArray = [SKAction]()
        
        
        actionArray.append(SKAction.move(to: player.position, duration: animationDuration))
        
        actionArray.append(SKAction.removeFromParent())
        
        alien.run(SKAction.sequence(actionArray))
        
    }
    
    // move player
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches{
            let location = touch.location(in: self)

            player.position.x = location.x
            player.position.y = location.y

        }
    }
    
    @objc func fireTorpedo(){
        self.run(SKAction.playSoundFileNamed("torpedo.mp3", waitForCompletion: false))
        let torpedoNode = SKSpriteNode(imageNamed: "torpedo")
        torpedoNode.name = "torpedo"
        torpedoNode.position = player.position
        
        torpedoNode.position = CGPoint(x: player.position.x, y: player.position.y + 70)
        
        torpedoNode.position.y += 5
        
        torpedoNode.physicsBody = SKPhysicsBody(circleOfRadius: torpedoNode.size.width/2)
        torpedoNode.physicsBody?.isDynamic = true

        torpedoNode.physicsBody?.categoryBitMask = 2
        torpedoNode.physicsBody?.contactTestBitMask = 2
        torpedoNode.physicsBody?.collisionBitMask = 2
        
        self.addChild(torpedoNode)
        
        let animationDuration:TimeInterval = 0.8
        
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: player.position.x, y:  self.frame.size.height + 10), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        
        torpedoNode.run(SKAction.sequence(actionArray))
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstbody:SKPhysicsBody
        var secondtbody:SKPhysicsBody
        
        //torpedo catogorybitmask = 2 / 2
        //alien catogorybitmask = 2 / 2
        // player catogorybitmask = 1 / 2
    
        if contact.bodyA.categoryBitMask == 2 && contact.bodyB.categoryBitMask == 2{
            firstbody = contact.bodyA
            secondtbody = contact.bodyB
            print("alien hit")
            torpedoHitsAlien(torpedonode: firstbody.node as! SKSpriteNode, aliennode: secondtbody.node as! SKSpriteNode)
        }else if contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 2{
            firstbody = contact.bodyA
            secondtbody = contact.bodyB
            print("player hit")
            alienHitsPlayer(aliennode: secondtbody.node as! SKSpriteNode, playernode: firstbody.node as! SKSpriteNode)
        }

    }
    
    
    func torpedoHitsAlien(torpedonode: SKSpriteNode, aliennode: SKSpriteNode){
        let explosion = SKEmitterNode(fileNamed: "Explosion")
        explosion!.position = aliennode.position
        self.addChild(explosion!)
        self.run(SKAction.wait(forDuration: 2)){
            explosion?.removeFromParent()
        }
        torpedonode.removeFromParent()
        aliennode.removeFromParent()
        
        score += 5
    }
    
    
    func alienHitsPlayer(aliennode: SKSpriteNode, playernode: SKSpriteNode){
        let explosion = SKEmitterNode(fileNamed: "Explosion")
        explosion!.position = aliennode.position
        self.addChild(explosion!)
        
        aliennode.removeFromParent()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            print("dead")
//            globalScore = self.score
//            self.removeAllChildren()
//            self.removeAllActions()
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "endGame")
//            self.gameTimer.invalidate()
//            
//            vc.view.frame = (self.view?.frame)!
//            vc.view.layoutIfNeeded()
//            
//            UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:{self.view?.window?.rootViewController = vc}, completion: { completed in})
//        }
        
        if livesArray.count > 0{
            let livenode = livesArray.first
            livenode!.removeFromParent()
            livesArray.removeFirst()
            
            if livesArray.count == 0{
                print("dead")
                globalScore = score
                self.removeAllChildren()
                self.removeAllActions()
                globalAlienimg = nil
                globalAlienimg2 = nil
                globalAlienimg3 = nil
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "endGame")
                gameTimer.invalidate()

                
                vc.view.frame = (self.view?.frame)!
                vc.view.layoutIfNeeded()

                UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:{self.view?.window?.rootViewController = vc}, completion: { completed in})
            }
                
        }
    }
    
    
 
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
    
    
}

