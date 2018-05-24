//
//  UserDefaultsExtension.swift
//  iHobby_Portfolio4
//
//  Created by Prajwal Ramamurthy on 5/24/18.
//  Copyright © 2018 Prajwal Ramamurthy. All rights reserved.
//

import Foundation
import UIKit

extension UserDefaults {
    
    // Save UIColor as a data object
    func set(color: UIColor, forKey key: String) {
        // Convert UI Color to Data by archiving
        let binaryData = NSKeyedArchiver.archivedData(withRootObject: color)
        // Save the binary data to user defaults
        self.set(binaryData, forKey: key)
    }
    
    // Get UI Color from the saved defaults with a key
    func color(forKey key: String) -> UIColor? {
        // Check for valid data
        if let binaryData = data(forKey: key) {
            // Is that data a UIColor?
            if let color = NSKeyedUnarchiver.unarchiveObject(with: binaryData) as? UIColor {
                return color
            }
        }
        // Didn't make it to the color return so return nil
        return nil
    }
}
