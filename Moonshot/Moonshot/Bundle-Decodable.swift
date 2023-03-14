//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Leon Grimmeisen on 13.03.22.
//

import Foundation

extension Bundle {
    func decode<T: Codable> (_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate file")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load file")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode file")
        }
        
        return loaded
    }
}
