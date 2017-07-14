//
//  CountryListController.swift
//  SampleGooglePlaceAutocomplete
//
//  Created by apple on 13/07/17.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

protocol CountryListControllerDelegate {
    
    func getSelectedCountry(selectedIndex : Int , countryCode: String?, countryName: String?)
}

class CountryListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var countryListTable: UITableView!
    @IBOutlet weak var countrySearchbar: UISearchBar!
    
    var countryList:[String]!
    var countryCodeArray:[String]!
    var delegate:CountryListControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateArrays()
        initialUISetUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        initialUISetUp()
        updateArrays()
    }
    func initialUISetUp()
    {
        self.countryListTable.setCardView(view: self.countryListTable)
        self.countrySearchbar.setCardView(view: self.countrySearchbar)
    }
    func updateArrays()
    {
        countryList = NSLocale.isoCountryCodes.map { (code:String) -> String in
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            return NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
        }
        
        
        countryCodeArray = NSLocale.isoCountryCodes.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        
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
        
        countryNameLabel.text = countryCodeArray[indexPath.row] + " - " + countryList[indexPath.row]
        
        cell.contentView.addSubview(countryNameLabel)
        cell.contentView.setCardView(view: cell.contentView)
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.getSelectedCountry(selectedIndex: indexPath.row, countryCode: countryCodeArray[indexPath.row], countryName: countryList[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

