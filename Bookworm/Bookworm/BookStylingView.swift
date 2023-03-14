//
//  BookStylingView.swift
//  Bookworm
//
//  Created by Leon Grimmeisen on 05.04.22.
//

import SwiftUI

extension View {
    func styleBackground(for book: Book) -> some View {
        if book.rating == 1 {
            return self.listRowBackground(Color(red: 0.98, green: 0.82, blue: 0.816))
        }  else {
            return self.listRowBackground(Color(red: 0.827, green: 0.827, blue: 0.827))
        }
    }
}
