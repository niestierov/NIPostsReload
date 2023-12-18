//
//  TimeInterval+Extension.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 06.12.2023.
//

import Foundation

extension TimeInterval {
    func convertToDate(
        with format: String = "MMM d, HH:mm",
        locale: String = "en_US"
    ) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: locale)

        return dateFormatter.string(
            from: Date(timeIntervalSince1970: self)
        )
    }
}
