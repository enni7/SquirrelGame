//
//  UserDefault+contain.swift
//  SquirrelGame
//
//  Created by Anna Izzo on 07/04/22.
//

import Foundation

extension UserDefaults {
    func contains(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
