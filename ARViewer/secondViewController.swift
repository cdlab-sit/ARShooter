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

class secondViewController: UIViewController, ARSCNViewDelegate {
    
    var myTime:String!
    
    //  @IBOutlet weak var NextView: SCNView!
    @IBAction func goBack(_ segue:UIStoryboardSegue) {}
    
    @IBAction func goNext(_ sender:UIButton) {
        print("scondNext")
        self.performSegue(withIdentifier:  "secondscreenTrans" ,sender: self.myTime)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "secondscreenTrans" {
            let Send = segue.destination as! thirdViewController
            Send.myScore = sender as! String
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("scondLoad")
        /*
         // Set the view's delegate
         NextView.delegate = self
         // Show statistics such as fps and timing information
         NextView.showsStatistics = true
         
         // Create a new scene
         let scene = SCNScene(named: "art.scnassets/ship.scn")!
         
         // Set the scene to the view
         NextView.scene = scene
         */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("scondAppear")
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        
        // Run the view's session
        //      sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("scondDisappear")
        // Pause the view's session
        //     sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("scondMemory")
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


