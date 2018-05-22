//
//  Profile.swift
//  iHobby_Portfolio4
//
//  Created by Prajwal Ramamurthy on 5/9/18.
//  Copyright © 2018 Prajwal Ramamurthy. All rights reserved.
//

import Foundation
import UIKit

class Profile{
    var name: String?
    var email: String?
    var location: String?
    var picture: UIImage?
    var id: String?
    
    init(iName: String?, iEmail: String?, iLocation: String?, iPicture: UIImage?, iId: String?){
        self.name = iName
        self.email = iEmail
        self.location = iLocation
        self.picture = iPicture
        self.id = iId
        
    }
}
