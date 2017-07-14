//
//  CountryListController.swift
//  SampleGooglePlaceAutocomplete
//
//  Created by apple on 13/07/17.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

protocol CountryListControllerDelegate {
    
    func getSelectedCountry(countryName: String?)
}

class CountryListController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var countryListTable: UITableView!
    @IBOutlet weak var countrySearchbar: UISearchBar!
    
    var countryList:[String]!
    var countryCodeArray:[String]!
    var delegate:CountryListControllerDelegate?
    
    var filteredCountryName:[String] = []
    
    var searchActive:Bool =  false
    
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
    
    //countrySearchbar
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive =  true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filterContentForSearchText(searchText: searchText)
        
        filteredCountryName = countryList.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: .caseInsensitive)
            return range.location != NSNotFound
        })
        
        if(filteredCountryName.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        
        self.countryListTable.reloadData()
    }
    
    //Country TableView
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searchActive) {
            
            return filteredCountryName.count
        }
        else {
            return (countryList?.count)!
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell =  UITableViewCell()
        
        let countryNameLabel = UILabel(frame: CGRect(x: 10, y: 15, width: self.view.frame.size.width, height: 20.0))
        cell.contentView.addSubview(countryNameLabel)
        cell.contentView.setCardView(view: cell.contentView)
        
        
        if(searchActive){
            countryNameLabel.text = filteredCountryName[indexPath.row]
            
            
        } else {
            countryNameLabel.text = countryList[indexPath.row]
        }
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(searchActive){
            delegate?.getSelectedCountry(countryName: filteredCountryName[indexPath.row])
            
            
        } else {
            delegate?.getSelectedCountry(countryName: countryList[indexPath.row])
        }
        
        
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func filterContentForSearchText(searchText: String) {
        
        
        filteredCountryName = countryList.filter({ (searchText) -> Bool in
            let tmp: NSString = searchText as NSString
            let range = tmp.range(of: searchText, options: .caseInsensitive)
            return range.location != NSNotFound
        })
        
        
        if(filteredCountryName.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
            
        }
        self.countryListTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

