//
//  JokeModel.swift
//  RandomJoke
//
//  Created by Brendon Crowe on 1/11/23.
//

import Foundation

// MARK: Because Joke is a created type, we must tell swift that this type conforms to equatable so that we may determine if an Array of Joke, [Joke], .contains(element: Joke)

struct Joke: Decodable, Equatable {
    let id: Int
    let type: String
    let setup: String
    let punchline: String
}

