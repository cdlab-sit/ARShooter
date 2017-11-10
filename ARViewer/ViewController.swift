//
//  ViewController.swift
//  ARViewer
// http://texnotes.me/post/5/ for tutorial
//
//  Created by Faris Sbahi on 6/6/17.
//  Copyright © 2017 Faris Sbahi. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation

class ViewController: UIViewController, ARSCNViewDelegate, SCNPhysicsContactDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var player: AVAudioPlayer!
    //時間計測用の変数.
    var cnt : Float = 0
    //時間表示用のラベル.
    var myLabel : UILabel!
    
    private var userScore: Int = 0 {
        didSet {
            // ensure UI update runs on main thread
            DispatchQueue.main.async {
                self.scoreLabel.text = String(self.userScore)
            } 
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "screenTrans" {
            let Send = segue.destination as! secondViewController
            Send.myTime = sender as! String
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 /*       while(self.count >= 0){
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
               // label.text = String(self.count)
                self.count = self.count - 1
            }
        }
 */
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new empty scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        sceneView.scene.physicsWorld.contactDelegate = self
        
        self.addNewShip()
        
        self.userScore = 0
        
        //ラベルを作る.
        myLabel = UILabel(frame: CGRect(x:0,y:0,width:200,height:100))
        myLabel.backgroundColor = UIColor.orange
        myLabel.layer.masksToBounds = true
        myLabel.layer.cornerRadius = 20.0
        myLabel.text = "Time:\(cnt)"
        myLabel.font = UIFont.systemFont(ofSize:40)
        myLabel.textColor = UIColor.white
        myLabel.shadowColor = UIColor.gray
        myLabel.textAlignment = NSTextAlignment.center
        myLabel.layer.position = CGPoint(x: self.view.bounds.width/2 + 200 ,y: 900)
        self.view.backgroundColor = UIColor.cyan
        self.view.addSubview(myLabel)
        //タイマーを生成して実行
         Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.onUpdate(timer:)), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configureSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    //時間計測関数
    @objc func onUpdate(timer : Timer){
        
        cnt = cnt + 0.1
        //桁数を指定して文字列を作る.
        let str = "Time:".appendingFormat("%.1f",cnt)
        myLabel.text = str
        if self.userScore == 5{            //画面遷移の文を書く
            /*
             let storyboard: UIStoryboard = self.storyboard!
             let nextView = storyboard.instantiateViewController(withIdentifier: "NextView")
             present(nextView, animated: true, completion: nil)
             */
            timer.invalidate()
            self.performSegue(withIdentifier:  "screenTrans" ,sender: String(self.cnt))
        }
        
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        print("Session failed with error: \(error.localizedDescription)")
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
/*
     // ARKit detects planes in the Real World to serve as anchors--we can add a node manually to visualize them.
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        // This visualization covers only detected planes.
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        print("flat plane detected")
        
        // Create a SceneKit plane to visualize the node using its position and extent.
        let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        let planeNode = SCNNode(geometry: plane)
        planeNode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z)
        
        // SCNPlanes are vertically oriented in their local coordinate space.
        // Rotate it to match the horizontal orientation of the ARPlaneAnchor.
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
        
        // ARKit owns the node corresponding to the anchor, so make the plane a child node.
        node.addChildNode(planeNode)
    }
 */
    
    // MARK: - Actions
    
    @IBAction func didTapScreen(_ sender: UITapGestureRecognizer) { // fire bullet in direction camera is facing
    
        // Play torpedo sound when bullet is launched
        
        
        
        self.playSoundEffect(ofType: .torpedo)
        
        let bulletsNode = Bullet()
        
        let (direction, position) = self.getUserVector()
        bulletsNode.position = position // SceneKit/AR coordinates are in meters
        
        let bulletDirection = direction
        bulletsNode.physicsBody?.applyForce(bulletDirection, asImpulse: true)
        sceneView.scene.rootNode.addChildNode(bulletsNode)
        
    }
    
    // MARK: - Game Functionality
    
    func configureSession() {
        if ARWorldTrackingSessionConfiguration.isSupported { // checks if user's device supports the more precise ARWorldTrackingSessionConfiguration
                                                            // equivalent to `if utsname().hasAtLeastA9()`
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        configuration.planeDetection = ARWorldTrackingSessionConfiguration.PlaneDetection.horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
        } else {
            // slightly less immersive AR experience due to lower end processor
            let configuration = ARSessionConfiguration()
            
            // Run the view's session
            sceneView.session.run(configuration)
        }
    }
    
    func addNewShip() {
        let cubeNode = Ship()
        
        let posX = floatBetween(-2.0, and: 2.0)
        let posY = floatBetween(-2.0, and: 2.0)
        var posz : Float = 0.0
        while true{
            posz = floatBetween(-3.0, and: 3.0)
            if(Int(posz) != 0){
                break
            }
        }
        print (posz)
        print (Int(posz))
        cubeNode.position = SCNVector3(posX, posY, posz) // SceneKit/AR coordinates are in meters
        sceneView.scene.rootNode.addChildNode(cubeNode)
    }
    
    func removeNodeWithAnimation(_ node: SCNNode, explosion: Bool) {
        
        // Play collision sound for all collisions (bullet-bullet, etc.)
        
        self.playSoundEffect(ofType: .collision)
        
        if explosion {
            
            // Play explosion sound for bullet-ship collisions
            
            self.playSoundEffect(ofType: .explosion)
            
            let particleSystem = SCNParticleSystem(named: "explosion", inDirectory: nil)
            let systemNode = SCNNode()
            systemNode.addParticleSystem(particleSystem!)
            // place explosion where node is
            systemNode.position = node.position
            sceneView.scene.rootNode.addChildNode(systemNode)
        }
        
        // remove node
        node.removeFromParentNode()
    }
    
    func getUserVector() -> (SCNVector3, SCNVector3) { // (direction, position)
        if let frame = self.sceneView.session.currentFrame {
            let mat = SCNMatrix4(frame.camera.transform) // 4x4 transform matrix describing camera in world space
            let dir = SCNVector3(-1 * mat.m31, -1 * mat.m32, -1 * mat.m33) // orientation of camera in world space
            let pos = SCNVector3(mat.m41, mat.m42, mat.m43) // location of camera in world space
            //ゲーム画面でこれを起動したい
        
            return (dir, pos)
        }
        return (SCNVector3(0, 0, -1), SCNVector3(0, 0, -0.2))
    }
    
    func floatBetween(_ first: Float,  and second: Float) -> Float { // random float between upper and lower bound (inclusive)
        return (Float(arc4random()) / Float(UInt32.max)) * (first - second) + second
    }
    
    // MARK: - Contact Delegate
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        //print("did begin contact", contact.nodeA.physicsBody!.categoryBitMask, contact.nodeB.physicsBody!.categoryBitMask)
        if contact.nodeA.physicsBody?.categoryBitMask == CollisionCategory.ship.rawValue || contact.nodeB.physicsBody?.categoryBitMask == CollisionCategory.ship.rawValue { // this conditional is not required--we've used the bit masks to ensure only one type of collision takes place--will be necessary as soon as more collisions are created/enabled
            
            print("Hit ship!")
            self.removeNodeWithAnimation(contact.nodeB, explosion: false) // remove the bullet
            self.userScore += 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { // remove/replace ship after half a second to visualize collision
                self.removeNodeWithAnimation(contact.nodeA, explosion: true)
                self.addNewShip()
            })
        }
       // self.count = self.count - 1
    }
    
    // MARK: - Sound Effects
    
    func playSoundEffect(ofType effect: SoundEffect) {
        
        // Async to avoid substantial cost to graphics processing (may result in sound effect delay however)
        DispatchQueue.main.async {
            do
            {
                if let effectURL = Bundle.main.url(forResource: effect.rawValue, withExtension: "mp3") {
                    
                    self.player = try AVAudioPlayer(contentsOf: effectURL)
                    self.player.play()
                    
                }
            }
            catch let error as NSError {
                print(error.description)
            }
        }
    }
}

struct CollisionCategory: OptionSet {
    let rawValue: Int
    
    static let bullets  = CollisionCategory(rawValue: 10 << 0) // 00...01
    static let ship = CollisionCategory(rawValue: 1 << 1) // 00..10
}

extension utsname {
    func hasAtLeastA9() -> Bool { // checks if device has at least A9 chip for configuration
        var systemInfo = self
        uname(&systemInfo)
        let str = withUnsafePointer(to: &systemInfo.machine.0) { ptr in
            return String(cString: ptr)
        }
        switch str {
        case "iPhone8,1", "iPhone8,2", "iPhone8,4", "iPhone9,1", "iPhone9,2", "iPhone9,3", "iPhone9,4": // iphone with at least A9 processor
            return true
        case "iPad6,7", "iPad6,8", "iPad6,3", "iPad6,4", "iPad6,11", "iPad6,12": // ipad with at least A9 processor
            return true
        default:
            return false
        }
    }
}

enum SoundEffect: String {
    case explosion = "explosion"
    case collision = "collision"
    case torpedo = "torpedo"
}

