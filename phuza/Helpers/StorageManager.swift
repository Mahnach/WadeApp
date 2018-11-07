//
//  StorageManager.swift
//  phuza
//
//  Created by Sorochinskiy Dmitriy on 04.11.2018.
//  Copyright © 2018 phuza. All rights reserved.
//

import Foundation

class StorageManager {
    
    enum Keys: String {
        case favourites
    }
    
    static func getFavoritesIds() -> [String] {
        return UserDefaults.standard.array(forKey:  Keys.favourites.rawValue) as? [String] ?? []
    }
    
    static func removeFromFavorite(id: String) {
        var ids = UserDefaults.standard.array(forKey:  Keys.favourites.rawValue) as? [String] ?? []
        ids = ids.filter { return $0 != id }
        UserDefaults.standard.setValue(ids, forKey: Keys.favourites.rawValue)
    }
    
    static func addToFavourite(id: String) {
        var ids = UserDefaults.standard.array(forKey:  Keys.favourites.rawValue) as? [String] ?? []
        ids.append(id)
        UserDefaults.standard.setValue(ids, forKey: Keys.favourites.rawValue)
    }
    
    static func removeFavourites() {
        UserDefaults.standard.removeObject(forKey: Keys.favourites.rawValue)
    }
}
