//
//  Ship.swift
//  ARViewer
//
//  Created by Faris Sbahi on 6/6/17.
//  Copyright © 2017 Faris Sbahi. All rights reserved.
//

import UIKit
import SceneKit

// Floating boxes that appear around you
class Ship: SCNNode {
    override init() {
        super.init()
        /*
        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        self.geometry = box
        let shape = SCNPhysicsShape(geometry: box, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: shape)
        self.physicsBody?.isAffectedByGravity = false
        
        // see http://texnotes.me/post/5/ for details on collisions and bit masks
        self.physicsBody?.categoryBitMask = CollisionCategory.ship.rawValue
        self.physicsBody?.contactTestBitMask = CollisionCategory.bullets.rawValue
        
        // add texture
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "galaxy")
        self.geometry?.materials  = [material, material, material, material, material, material]
 */
/*ここから*/
        let vc = ViewController()
        var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
        var target = appDelegate.target
        //let text = SCNText(string: "CDlab", extrusionDepth: 0.05)
        let text = SCNText(string: String(target), extrusionDepth: 0.05)
        self.geometry = text
        
        print("ship_ON")
        print(String(target))
        print("ship_OFF")
        let shape = SCNPhysicsShape(geometry: text, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: shape)
        self.physicsBody?.isAffectedByGravity = false
        
        // see http://texnotes.me/post/5/ for details on collisions and bit masks
        self.physicsBody?.categoryBitMask = CollisionCategory.ship.rawValue
        self.physicsBody?.contactTestBitMask = CollisionCategory.bullets.rawValue
        
        // NSAttributedString 設定
        let style = NSMutableParagraphStyle()
        style.lineSpacing = -0.5
        
        let textFont:UIFont = UIFont(name: "Arial", size: 0.3)!
        /*
        text.string = NSAttributedString(string: "CDlab", attributes: [
            NSAttributedStringKey.paragraphStyle: style,
            NSAttributedStringKey.font: textFont
            ])
 */
        text.string = NSAttributedString(string: String(target), attributes: [
            NSAttributedStringKey.paragraphStyle: style,
            NSAttributedStringKey.font: textFont
            ])
        
        // その他の設定
        text.flatness = 0.0
        text.extrusionDepth = 0.05
        text.chamferRadius = 0.02
        
        // chamfer の形状設定
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 1.0))
        path.addLine(to: CGPoint(x: 0.0, y: 0.75))
        path.addLine(to: CGPoint(x: 0.25, y: 0.75))
        path.addLine(to: CGPoint(x: 0.25, y: 0.5))
        path.addLine(to: CGPoint(x: 0.5, y: 0.5))
        path.addLine(to: CGPoint(x: 0.5, y: 0.25))
        path.addLine(to: CGPoint(x: 0.75, y: 0.25))
        path.addLine(to: CGPoint(x: 0.75, y: 0.0))
        path.addLine(to: CGPoint(x: 1.0, y: 0.0))
        
        text.chamferProfile = path
        
        // マテリアル設定
        
        let m1 = SCNMaterial()
        let m2 = SCNMaterial()
        let m3 = SCNMaterial()
        
        m1.diffuse.contents = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
        m2.diffuse.contents = UIColor.red
        m3.diffuse.contents = UIColor.yellow
        
        text.materials = [m3,m2,m1,m2,m3]
/*ここまで消してもいい*/
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
