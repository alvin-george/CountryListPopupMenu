//
//  ViewController.swift
//  CountryListPicker
//
//  Created by apple on 14/07/17.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var countryTextfield: UITextField!
    @IBOutlet weak var stateTextfield: UITextField!
    @IBOutlet weak var cityTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.resignFirstResponder()
        showCountryListTableMenu()
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
   
    //Country List Menu
    func showCountryListTableMenu()
    {
        
        let countryListTableMenu = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "countryListController") as! CountryListController
//        countryListTableMenu.currentViewController = currentViewControllerIdentifier!
//        countryListTableMenu.delegate =  self
        
        countryListTableMenu.modalPresentationStyle = .overCurrentContext
        self.present(countryListTableMenu, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
