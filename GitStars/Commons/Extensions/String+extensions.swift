//
//  String+extensions.swift
//  GitStars
//
//  Created by Matheus Lenke on 04/04/22.
//

import Foundation

extension String {
    func parseISO8601Date() -> String {
        let dateFormatterGet = ISO8601DateFormatter()
        if let date = dateFormatterGet.date(from: self) {
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "dd/MM/yyyy"
            
            let dateFormatted = dateFormatterPrint.string(from: date)
            return dateFormatted
        }
        return self
    }
}
