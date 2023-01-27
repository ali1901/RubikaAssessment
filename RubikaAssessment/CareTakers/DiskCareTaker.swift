//
//  DiskCareTaker.swift
//  RubikaAssessment
//
//  Created by Yaas Mac on 11/8/1401 AP.
//

import Foundation

class DiskCareTaker {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private func objURL(for key: String) -> URL {
        let directories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let directory = directories.first!
        
        return directory.appendingPathComponent("\(key).json")
    }
    
    public func save<T: Encodable>(theObject object: T, withName name: String) throws {
        let url = objURL(for: name)
        do {
            let data = try encoder.encode(object)
            try data.write(to: url, options: .atomic)
        } catch (let error) {
            print("Error saving data to disk: \(error).")
        }
    }
    
    public func load<T: Codable>(toObject object: T.Type, withName name: String) throws -> T? {
        let url = objURL(for: name)
        do {
            let data = try Data(contentsOf: url)
            return try decoder.decode(object.self, from: data)
        } catch {
            print("Error loading data from disk: \(error).")
            return nil
        }
        
    }
}
