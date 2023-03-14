//
//  View-ExpenseStyling.swift
//  iExpense
//
//  Created by Leon Grimmeisen on 11.03.22.
//

import SwiftUI

extension View {
    func styleBackgound(for item: ExpenseItem) -> some View {
        if item.amount < 10 {
            return self.listRowBackground(Color.init(red: 0.259, green: 0.647, blue: 0.961))
        } else if item.amount < 100 {
                return self.listRowBackground(Color.init(red: 0.098, green: 0.463, blue: 0.824))
        } else {
            return self.listRowBackground(Color.init(red: 0.051, green: 0.278, blue: 0.631))
        }
    }
}
