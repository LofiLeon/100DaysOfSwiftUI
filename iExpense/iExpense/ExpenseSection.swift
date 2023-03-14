//
//  ExpenseSection.swift
//  iExpense
//
//  Created by Leon Grimmeisen on 11.03.22.
//

import SwiftUI

struct ExpenseSection: View {
    
    let title: String
    let expenses: [ExpenseItem]
    let deleteItems: (IndexSet) -> Void
    
    var body: some View {
        Section(title) {
            ForEach(expenses) { item in //no id needed as it conforms to unique Identifier protocol
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                            .bold()
                        Text(item.type)
                            .font(.callout)
                    }
                    Spacer()
                    Text(item.amount, format: .localCurrency)
                        .bold()
                        .font(.title2)
                }
                .styleBackgound(for: item)
                .foregroundColor(.white)
            }
            .onDelete(perform: deleteItems)
        }
    }
}
struct ExpenseSection_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseSection(title: "Example", expenses: []) { _ in }
    }
}
