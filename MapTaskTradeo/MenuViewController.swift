//
//  MenuViewController.swift
//  MapTaskTradeo
//
//  Created by Angel Kukushev on 1/9/16.
//  Copyright © 2016 Angel Kukushev. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var givenHour = String()
    
    var givenDay = String()
    
    var givenMonth = String()
   
    @IBOutlet weak var hourTextField: UITextField!
    
    @IBOutlet weak var dayTextField: UITextField!
    
    @IBOutlet weak var monthTextField: UITextField!
    
    //lifecycle methods and so on ...
    
    @IBAction func saveTextToVar(sender: UIButton) {
        
         givenHour = hourTextField.text!
         givenDay = dayTextField.text!
         givenMonth = monthTextField.text!
        
      
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        givenHour = hourTextField.text!
        givenDay = dayTextField.text!
        givenMonth = monthTextField.text!
        
        
        
        
        let DestViewController: ViewController = segue.destinationViewController as! ViewController
       
        DestViewController.compareHour = givenHour
        DestViewController.compareDay = givenDay
        DestViewController.compareMonth = givenMonth
    }
}
