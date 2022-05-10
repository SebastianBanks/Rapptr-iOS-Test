//
//  Message.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

struct TopLevelObject: Decodable {
    var data: [Message]
}

struct Message: Decodable {
    var user_id: String
    var name: String
    var avatar_url: String
    var message: String
    
    init(testName: String, withTestMessage message: String) {
        self.user_id = "0"
        self.name = testName
        self.avatar_url = "https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Smiley.svg/220px-Smiley.svg.png"
        self.message = message
    }
}
