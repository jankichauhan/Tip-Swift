//
//  ViewController.swift
//  tips
//
//  Created by Janki on 4/5/15.
//  Copyright (c) 2015 Janki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var totalText: UILabel!
    @IBOutlet weak var billText: UILabel!
    @IBOutlet weak var billAmountField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var oneLabel: UILabel!
    @IBOutlet weak var twoLabel: UILabel!
    @IBOutlet weak var threeLabel: UILabel!
    @IBOutlet weak var fourLabel: UILabel!
    
    @IBOutlet weak var oneText: UILabel!
    @IBOutlet weak var twoText: UILabel!
    @IBOutlet weak var threeText: UILabel!
    @IBOutlet weak var fourText: UILabel!
    
    let darkBackground = UIColor(red: 85.0/255.0, green:107.0/255.0, blue:47.0/255.0, alpha:1.0)
    @IBAction func editingBegin(sender: AnyObject) {
        println("on editing Begin")

        billAmountField.text = ""
        hide()
        
    }
    
    @IBAction func editingEnd(sender: AnyObject) {
        println("on editing end")
       //  billAmountField.text =  formatter.stringFromNumber(NSString(string: billAmountField.text).doubleValue)
    }
 
    let formatter = NSNumberFormatter()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tip Calculator"
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"forAppActive", name:
            UIApplicationDidBecomeActiveNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"forAppInactive", name:
            UIApplicationWillResignActiveNotification, object: nil)
        
        hide()
        println("tip controller view did load  \(tipControl.selectedSegmentIndex)")
        self.billAmountField.becomeFirstResponder()
        
    }
    
    func forAppActive(){
        println("for app active")
        var defaultsForAppRestart = NSUserDefaults.standardUserDefaults()
        var lastBilldate = defaultsForAppRestart.objectForKey("Last bill date") as NSDate
        var lastBillAmount = defaultsForAppRestart.objectForKey("Last bill amount") as String
        
        var now = NSDate()
        
        let interval = now.timeIntervalSinceDate(lastBilldate)
        
        println(" interval \(interval)")

        if(interval < 60){
            println(" interval \(interval)")
            billAmountField.text =  lastBillAmount
            onEditingChange(lastBillAmount)

        }
        else{
            billAmountField.text = ""
           // self.billAmountField.becomeFirstResponder()
        }
        
    }
  
    func forAppInactive(){
        let date = NSDate()
        var defaultsForAppRestart = NSUserDefaults.standardUserDefaults()
        defaultsForAppRestart.setObject(date, forKey: "Last bill date")
        defaultsForAppRestart.setObject(billAmountField.text, forKey: "Last bill amount")
        defaultsForAppRestart.synchronize()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("view will appear")
        var defaults = NSUserDefaults.standardUserDefaults()
        var tipIndex = defaults.integerForKey("Default Tip")
        var themeSet = defaults.boolForKey("Dark Theme")
        
        if(themeSet){
            darkTheme()
        }
        else{
            lightTheme()
        }
        
        if(tipIndex != tipControl.selectedSegmentIndex){
            
            println(" tipIndex \(tipIndex)   tipControl \(tipControl.selectedSegmentIndex)")
            tipControl.selectedSegmentIndex = tipIndex
            onEditingChange(themeSet)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        println("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        println("view did disappear")
    }

    @IBAction func onEditingChange(sender: AnyObject) {
        show(true)
        var tipPercentages = [0.10, 0.20, 0.25]
        println("on edit change  \(tipControl.selectedSegmentIndex)")

        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        var billAmount = NSString(string: billAmountField.text).doubleValue

        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        
        tipLabel.text = formatter.stringFromNumber(tip)
        totalLabel.text = formatter.stringFromNumber(total)
        twoLabel.text = formatter.stringFromNumber(total/2)
        threeLabel.text = formatter.stringFromNumber(total/3)
        fourLabel.text = formatter.stringFromNumber(total/4)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func show(animate:Bool){
 
        billText.frame.origin = CGPoint(x:13.0, y:139.0)
        billAmountField.frame.origin = CGPoint(x:147.0, y:135.0)
        
        tipLabel.hidden = false
        totalLabel.hidden = false
        tipLabel.hidden = false
        tipControl.hidden = false
        twoLabel.hidden = false
        threeLabel.hidden = false
        fourLabel.hidden = false
        oneText.hidden = false
        twoText.hidden = false
        threeText.hidden = false
        fourText.hidden = false
    }
    
    func hide(){
        
        billText.frame.origin = CGPoint(x:13.0, y:239.0)
        billAmountField.frame.origin = CGPoint(x:147, y:235)
        tipLabel.text = "$0.0"
        totalLabel.text = "$0.0"
        tipLabel.hidden = true
        totalLabel.hidden = true
        tipLabel.hidden = true
        tipControl.hidden = true
        twoLabel.hidden = true
        threeLabel.hidden = true
        fourLabel.hidden = true
        oneText.hidden = true
        twoText.hidden = true
        threeText.hidden = true
        fourText.hidden = true
    }
    
    func darkTheme(){
        
        view.backgroundColor = darkBackground
        billText.backgroundColor = darkBackground
        billAmountField.backgroundColor = darkBackground
        tipLabel.backgroundColor = darkBackground
        totalLabel.backgroundColor = darkBackground
        tipControl.backgroundColor = darkBackground
        twoLabel.backgroundColor = darkBackground
        threeLabel.backgroundColor = darkBackground
        fourLabel.backgroundColor = darkBackground
        oneText.backgroundColor = darkBackground
        twoText.backgroundColor = darkBackground
        threeText.backgroundColor = darkBackground
        fourText.backgroundColor = darkBackground
        
        
        billText.textColor = UIColor.whiteColor()
        billAmountField.textColor = UIColor.whiteColor()
        tipLabel.textColor = UIColor.whiteColor()
        totalLabel.textColor = UIColor.whiteColor()
        twoLabel.textColor = UIColor.whiteColor()
        threeLabel.textColor = UIColor.whiteColor()
        fourLabel.textColor = UIColor.whiteColor()
        
    }
    
    func lightTheme(){
        
        view.backgroundColor = UIColor.whiteColor()
        billText.backgroundColor = UIColor.whiteColor()
        billAmountField.backgroundColor = UIColor.whiteColor()
        tipLabel.backgroundColor = UIColor.whiteColor()
        totalLabel.backgroundColor = UIColor.whiteColor()
        tipControl.backgroundColor = UIColor.whiteColor()
        twoLabel.backgroundColor = UIColor.whiteColor()
        threeLabel.backgroundColor = UIColor.whiteColor()
        fourLabel.backgroundColor = UIColor.whiteColor()
        oneText.backgroundColor = UIColor.whiteColor()
        twoText.backgroundColor = UIColor.whiteColor()
        threeText.backgroundColor = UIColor.whiteColor()
        fourText.backgroundColor = UIColor.whiteColor()
        
        
        billText.textColor = UIColor.grayColor()
        billAmountField.textColor = UIColor.grayColor()
        tipLabel.textColor = UIColor.grayColor()
        totalLabel.textColor = UIColor.grayColor()
        twoLabel.textColor = UIColor.grayColor()
        threeLabel.textColor = UIColor.grayColor()
        fourLabel.textColor = UIColor.grayColor()
    }
    
    deinit {
    
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIApplicationDidBecomeActiveNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIApplicationWillResignActiveNotification, object: nil)
    }


}

