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

class fourthViewController: UIViewController, ARSCNViewDelegate ,UITextFieldDelegate {
    
    var Target : String = ""
    @IBOutlet var label:UILabel!
    @IBOutlet var button:UIButton!
    @IBOutlet var textField: UITextField!
    
    @IBAction func goNext(_ sender:UIButton) {
        print("fourthNext")
/*ここから*/
        var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
        //appDelegate.target = "Hello,world"//元
        Target = textField.text!
        if Target == ""{
            self.Target = "文字を入力してください"
        }
            print(Target)
        appDelegate.target = self.Target //appDelegateの変数を操作
/*ここまで消したらあかん*/
/*
        let next = storyboard!.instantiateViewController(withIdentifier: "sceneView")
        self.present(next,animated: true, completion: nil)
 */
        self.performSegue(withIdentifier:  "fourthscreenTrans" ,sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("fourthLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("fourthAppear")
        let configuration = ARWorldTrackingSessionConfiguration()
/*ここから*/
        //UserDefaults.standard.set(1, forKey: String(describing: textField.text))
        //UserDefaults.standard.set(, forKey: Constants.telKey)
        //変数targetTextの宣言

/*
        var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
        //appDelegate.target = "Hello,world"//元
        let targetText : String = textField.text!
        print(String(targetText))
        print(targetText)
        appDelegate.target = targetText //appDelegateの変数を操作
 */
/*ここまで消してもいい*/
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("fourthDisappear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("fourthMemory")
    }
    
    // 改行ボタンを押した時の処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを隠す
        textField.resignFirstResponder()
        return true
    }
    
    // クリアボタンが押された時の処理
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("Clear")
        return true
    }
    
    // テキストフィールドがフォーカスされた時の処理
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("Start")
        return true
    }
    
    // テキストフィールドでの編集が終わろうとするときの処理
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("End")
        return true
    }
    
    
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




