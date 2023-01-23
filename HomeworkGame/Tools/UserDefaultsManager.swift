//
//  UserDefaultsManager.swift
//  HomeworkGame
//
//  Created by Olha Dzhyhirei on 1/22/23.
//

import Foundation
struct UserDefaultsManager {
    private init() {}
    static let shared = UserDefaultsManager()
    
    func getUserDefaultScore() -> (Int) {
        UserDefaults.standard.integer(forKey: "score")
    }
    func setUserDefaultScore(value: Int) {
        UserDefaults.standard.set(value, forKey: "score")
    }
}
