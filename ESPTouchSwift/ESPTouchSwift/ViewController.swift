//
//  ViewController.swift
//  ESPTouchSwift
//
//  Created by Bruno Horta on 03/01/2018.
//  Copyright © 2018 VoidSteam. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ESPTouchDelegate {
    func onEsptouchResultAdded(with result: ESPTouchResult!) {
        print("DONE")
    }
    
    @IBOutlet var passwordInputText: UITextField!
    @IBOutlet var ssidLabel: UILabel!
    var bssid: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func sendSmartConfig(){
        DispatchQueue.main.async {
            let  _: ESPTouchResult = self.executeForResult()
        }
    }
    
    func  executeForResult() -> ESPTouchResult{
    let esptouchTask = ESPTouchTask.init(apSsid: ssidLabel.text, andApBssid: self.bssid, andApPwd: self.passwordInputText.text)
    esptouchTask?.setEsptouchDelegate(self)

        return (esptouchTask?.executeForResult())!
    }
  
}

