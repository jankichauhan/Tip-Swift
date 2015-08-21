//
//  SettingsViewController.swift
//  tips
//
//  Created by Janki on 4/7/15.
//  Copyright (c) 2015 Janki. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipText: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var themeText: UILabel!
    @IBOutlet weak var themeSwitch: UISwitch!
    let darkBackground = UIColor(red: 85.0/255.0, green:107.0/255.0, blue:47.0/255.0, alpha:1.0)
    
    override func viewDidLoad() {
        var defaults = NSUserDefaults.standardUserDefaults()
        var tipIndex = defaults.integerForKey("Default Tip")
        var themeSet = defaults.boolForKey("Dark Theme")
        println("Default tip in Settings \(tipIndex)  \(themeSet)")
        tipControl.selectedSegmentIndex = tipIndex
        themeSwitch.on = themeSet
        
        if(themeSet){
            darkTheme()
        }
        else{
            lightTheme()
        }
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func themeChange(sender: UISwitch) {
        
        if(sender.on){
            darkTheme()
        }
        else{
            lightTheme()
        }
        
        saveDefaultValues(sender)
        
    }

    @IBAction func saveDefaultValues(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: "Default Tip")
        defaults.setBool(themeSwitch.on, forKey: "Dark Theme")
        defaults.synchronize()

    }
    
    func lightTheme(){
        
        view.backgroundColor = UIColor.whiteColor()
        defaultTipText.backgroundColor =  UIColor.whiteColor()
        themeText.backgroundColor =  UIColor.whiteColor()
        defaultTipText.textColor = UIColor.grayColor()
        themeText.textColor = UIColor.grayColor()
        tipControl.backgroundColor =  UIColor.whiteColor()
        themeSwitch.backgroundColor =  UIColor.whiteColor()
        
    }
    
    func darkTheme(){
        
        view.backgroundColor = darkBackground
        defaultTipText.backgroundColor = darkBackground
        themeText.backgroundColor = darkBackground
        defaultTipText.textColor = UIColor.whiteColor()
        themeText.textColor = UIColor.whiteColor()
        tipControl.backgroundColor = darkBackground
        themeSwitch.backgroundColor = darkBackground
    }
    /*
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
