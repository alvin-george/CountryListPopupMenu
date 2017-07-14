//
//  AppExtension.swift
//  SampleGooglePlaceAutocomplete
//
//  Created by apple on 13/07/17.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation

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
