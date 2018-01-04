//
//  ViewController.swift
//  ESPTouchSwift
//
//  Created by Bruno Horta on 03/01/2018.
//  Copyright © 2018 Bruno Horta. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ESPTouchDelegate {
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var results : Array<ESPTouchResult> = Array()
    var resultExpected = 1
    var alertController = UIAlertController()
    var esptouchTask : ESPTouchTask?
    var messageResult = ""
    var resultCount = 0
    func onEsptouchResultAdded(with result: ESPTouchResult!) {
      results.append(result)
        DispatchQueue.main.async {
            self.effectView.removeFromSuperview()
            self.messageResult  = "\(self.messageResult)\(result.bssid!) - ip: \(ESP_NetUtil.descriptionInetAddr4(by: result.ipAddrData)!)\n"
            self.resultCount = self.resultCount + 1
            self.alertController.title = "\(self.resultCount) ESP\(self.resultCount > 1 ? "(s)" :" ") encontrado\(self.resultCount > 1 ? "s" :" ")"
            
            self.alertController.message = self.messageResult
        }
    }
    
    
    @IBOutlet var numberOfDevicesLabel: UILabel!
    @IBOutlet var passwordInputText: UITextField!
    @IBOutlet var ssidLabel: UILabel!
    var bssid: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func sendSmartConfig(){
        results.removeAll()
        DispatchQueue.global().async {
            self.esptouchTask = ESPTouchTask.init(apSsid: self.ssidLabel.text, andApBssid: self.bssid, andApPwd: self.passwordInputText.text)
            if let task = self.esptouchTask{
                task.setEsptouchDelegate(self)
                let  results: NSArray = (task.execute(forResults: Int32(self.resultExpected))! as NSArray)
                print(results)
            }
            
        }
    }
    @IBAction func onNumberDevicesChange(_ sender: UISlider) {
        resultExpected = Int(sender.value)
        numberOfDevicesLabel.text = resultExpected.description
       
    }
    
  

    @IBAction func send(_ sender: UIButton) {
        self.showAlertWithResult(title:"A pesquisar",message:"")
        self.sendSmartConfig()
    }
   
    func showAlertWithResult(title : String,  message: String){
        
         alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    
    }
}

