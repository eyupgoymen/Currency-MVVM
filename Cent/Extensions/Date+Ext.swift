//
//  Date+Ext.swift
//  Cent
//
//  Created by Eyup Kazım Göymen on 5.08.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

extension Date {
    
    //Get Previous day
    static var yesterday: Date { return Date().dayBefore }
    
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    //Get formatted day
    func getFormattedDateAsString() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        return dateFormatterGet.string(from: self)
    }
}
