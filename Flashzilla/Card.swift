//
//  Card.swift
//  Flashzilla
//
//  Created by Brandon Glenn on 1/28/22.
//

import Foundation

struct Card: Codable, Hashable{
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
