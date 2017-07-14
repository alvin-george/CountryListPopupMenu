//
//  AppExtension.swift
//  SampleGooglePlaceAutocomplete
//
//  Created by apple on 13/07/17.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation
import UIKit

extension NSLocale {
    class func convertToCountryCode(countryName : String) -> String {
        let locales : String = ""
        for localeCode in NSLocale.isoCountryCodes {
            
            let countryName = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: localeCode)
            if countryName?.lowercased() == countryName?.lowercased() {
                return localeCode
            }
        }
        return locales
    }
}
extension UIView {

    func setCardView(view : UIView){
        
        view.layer.cornerRadius = 5.0
        view.layer.borderColor  =  UIColor.clear.cgColor
        view.layer.borderWidth = 5.0
        view.layer.shadowOpacity = 0.5
        view.layer.shadowColor =  UIColor.lightGray.cgColor
        view.layer.shadowRadius = 5.0
        view.layer.shadowOffset = CGSize(width:5, height: 5)
        view.layer.masksToBounds = false
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
        
    }
    
    
}
