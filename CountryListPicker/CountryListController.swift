//
//  CountryListController.swift
//  SampleGooglePlaceAutocomplete
//
//  Created by apple on 13/07/17.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

class CountryListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var countryListTable: UITableView!
    @IBOutlet weak var countrySearchbar: UISearchBar!
    
    var countryList:[String]!
    var countryCodeArray:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateArrays()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        updateArrays()
    }
    func updateArrays()
    {
        countryList = NSLocale.isoCountryCodes.map { (code:String) -> String in
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            return NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
        }

        
        var countryCode:String = String()
        
        for i in 0 ... (countryList?.count)!-1 {
            
            countryCode = NSLocale.convertToCountryCode(countryName: (countryList?[i])!)
            countryCodeArray?.append(countryCode)
            
        }
        
        let can = NSLocale.convertToCountryCode(countryName: "canada")
        
        print("can :\(can)")

    }
    
    
    //Country TableView
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
 
        return 50
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (countryList?.count)!
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell =  UITableViewCell()
        
        let countryNameLabel = UILabel(frame: CGRect(x: 10, y: 10, width: self.view.frame.size.width, height: 21.0))
        
        countryNameLabel.text = countryCodeArray?[indexPath.row]
        
        cell.contentView.addSubview(countryNameLabel)
        
        return cell
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

