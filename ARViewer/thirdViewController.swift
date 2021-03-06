//
//  ViewController.swift
//  ARkit_test
//
//  Created by kishimoto on 2017/07/20.
//  Copyright © 2017年 kishimoto. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class thirdViewController: UIViewController, ARSCNViewDelegate {
    
    var myScore:String!
    
    @IBOutlet var scoreText: UILabel!
    //  @IBOutlet weak var NextView: SCNView!
    @IBAction func goNext(_ sender:UIButton) {
        self.performSegue(withIdentifier:  "thirdscreenTrans" ,sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scoreText.text = "かかった時間 " + self.myScore + " 秒"
        /*
         // Set the view's delegate
         sceneView.delegate = self
         // Show statistics such as fps and timing information
         sceneView.showsStatistics = true
         
         // Create a new scene
         let scene = SCNScene(named: "art.scnassets/ship.scn")!
         
         // Set the scene to the view
         sceneView.scene = scene
         */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        
        // Run the view's session
        //      sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        //     sceneView.session.pause()
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
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}



