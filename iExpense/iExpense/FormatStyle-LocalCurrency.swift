//
//  FormatStyle-LocalCurrency.swift
//  iExpense
//
//  Created by Leon Grimmeisen on 11.03.22.
//

import Foundation

extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
    static var localCurrency: Self {
        .currency(code: Locale.current.currencyCode ?? "USD")
    }
}


