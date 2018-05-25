//
//  CreateEvent.swift
//  iHobby_Portfolio4
//
//  Created by Prajwal Ramamurthy on 5/16/18.
//  Copyright © 2018 Prajwal Ramamurthy. All rights reserved.
//

import Foundation

class CreateEvent: NSObject{
    var eventTitle: String?
    var eventTime: String?
    var eventLocation: String?
    var eventDescription: String?
    var eventDate: String?
    var id: String?
    var userId: String?
    
    override init(){
        eventTitle = " "
        eventTime = ""
        eventDate = ""
        eventDescription = ""
        eventLocation = ""
        id = ""
        userId = ""
    }
    
    init(ieventTitle: String?, ieventTime: String?, ieventLocation: String?, ieventDescription: String?, ieventDate: String?, initId: String?, initUserId: String?) {
        self.eventDate = ieventDate
        self.eventTitle = ieventTitle
        self.eventTime = ieventTime
        self.eventLocation = ieventLocation
        self.eventDescription = ieventDescription
        self.id = initId
        self.userId = initUserId
        
    }
    
    
}
