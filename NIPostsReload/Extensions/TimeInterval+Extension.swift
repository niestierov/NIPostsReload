//
//  TimeInterval+Extension.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 06.12.2023.
//

import Foundation

extension TimeInterval {
    private enum Constant {
        static let defaultDateFormat = "MMM d, HH:mm"
        static let defaultDateLocale = "en_US"
    }
    
    func convertToDate(
        with format: String = Constant.defaultDateFormat,
        locale: String = Constant.defaultDateLocale
    ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: locale)

        return dateFormatter.string(
            from: Date(timeIntervalSince1970: self)
        )
    }
}
