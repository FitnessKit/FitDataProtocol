//
//  CardioExerciseName.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/11/18.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

/// Cardio Exercise Name
public struct CardioExerciseName: ExerciseName {
    public typealias ExerciseNameType = CardioExerciseName

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension CardioExerciseName: Hashable {

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    public var hashValue: Int {
        return name.hashValue ^ number.hashValue
    }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: CardioExerciseName, rhs: CardioExerciseName) -> Bool {
        return lhs.name == rhs.name &&
            lhs.number == rhs.number
    }
}

public extension CardioExerciseName {

    public static var supportedExerciseNames: [CardioExerciseName] {

        return [.bobAndWeaveCircle,
                .weightedBobAndWeaveCircle,
                .cardioCoreCrawl,
                .weightedCardioCoreCrawl,
                .doubleUnder,
                .weightedDoubleUnder,
                .jumpRope,
                .weightedJumpRope,
                .jumpRopeCrossover,
                .weightedJumpRopeCrossover,
                .jumpRopeJog,
                .weightedJumpRopeJog,
                .jumpingJacks,
                .weightedJumpingJacks,
                .skiMoguls,
                .weightedSkiMoguls,
                .splitJacks,
                .weightedSplitJacks,
                .squatJacks,
                .weightedSquatJacks,
                .tripleUnder,
                .weightedTripleUnder
        ]
    }
}

public extension CardioExerciseName {

    public static func create(rawValue: UInt16) -> CardioExerciseName? {

        for name in CardioExerciseName.supportedExerciseNames {
            if name.number == rawValue {
                return name
            }
        }

        return nil
    }
}

// MARK: - Exercise Types
public extension CardioExerciseName {

    /// Bob and Weave Circle
    public static var bobAndWeaveCircle: CardioExerciseName {
        return CardioExerciseName(name: "Bob and Weave Circle", number: 0)
    }

    /// Weighted Bob and Weave Circle
    public static var weightedBobAndWeaveCircle: CardioExerciseName {
        return CardioExerciseName(name: "Weighted Bob and Weave Circle", number: 1)
    }

    /// Cardio Core Crawl
    public static var cardioCoreCrawl: CardioExerciseName {
        return CardioExerciseName(name: "Cardio Core Crawl", number: 2)
    }

    /// Weighted Cardio Core Crawl
    public static var weightedCardioCoreCrawl: CardioExerciseName {
        return CardioExerciseName(name: "Weighted Cardio Core Crawl", number: 3)
    }

    /// Double Under
    public static var doubleUnder: CardioExerciseName {
        return CardioExerciseName(name: "Double Under", number: 4)
    }

    /// Weighted Double Under
    public static var weightedDoubleUnder: CardioExerciseName {
        return CardioExerciseName(name: "Weighted Double Under", number: 5)
    }

    /// Jump Rope
    public static var jumpRope: CardioExerciseName {
        return CardioExerciseName(name: "Jump Rope", number: 6)
    }

    /// Weighted Jump Rope
    public static var weightedJumpRope: CardioExerciseName {
        return CardioExerciseName(name: "Weighted Jump Rope", number: 7)
    }

    /// Jump Rope Crossover
    public static var jumpRopeCrossover: CardioExerciseName {
        return CardioExerciseName(name: "Jump Rope Crossover", number: 8)
    }

    /// Weighted Jump Rope Crossover
    public static var weightedJumpRopeCrossover: CardioExerciseName {
        return CardioExerciseName(name: "Weighted Jump Rope Crossover", number: 9)
    }

    /// Jump Rope Jog
    public static var jumpRopeJog: CardioExerciseName {
        return CardioExerciseName(name: "Jump Rope Jog", number: 10)
    }

    /// Weighted Jump Rope Jog
    public static var weightedJumpRopeJog: CardioExerciseName {
        return CardioExerciseName(name: "Weighted Jump Rope Jog", number: 11)
    }

    /// Jumping Jacks
    public static var jumpingJacks: CardioExerciseName {
        return CardioExerciseName(name: "Jumping Jacks", number: 12)
    }

    /// Weighted Jumping Jacks
    public static var weightedJumpingJacks: CardioExerciseName {
        return CardioExerciseName(name: "JWeighted umping Jacks", number: 13)
    }

    /// Ski Moguls
    public static var skiMoguls: CardioExerciseName {
        return CardioExerciseName(name: "Ski Moguls", number: 14)
    }

    /// Weighted Ski Moguls
    public static var weightedSkiMoguls: CardioExerciseName {
        return CardioExerciseName(name: "Weighted Ski Moguls", number: 15)
    }

    /// Split Jacks
    public static var splitJacks: CardioExerciseName {
        return CardioExerciseName(name: "Split Jacks", number: 16)
    }

    /// Weighted Split Jacks
    public static var weightedSplitJacks: CardioExerciseName {
        return CardioExerciseName(name: "Weighted Split Jacks", number: 17)
    }

    /// Squat Jacks
    public static var squatJacks: CardioExerciseName {
        return CardioExerciseName(name: "Squat Jacks", number: 18)
    }

    /// Weighted Squat Jacks
    public static var weightedSquatJacks: CardioExerciseName {
        return CardioExerciseName(name: "Weighted Squat Jacks", number: 19)
    }

    /// Triple Under
    public static var tripleUnder: CardioExerciseName {
        return CardioExerciseName(name: "Triple Under", number: 20)
    }

    /// Weighted Triple Under
    public static var weightedTripleUnder: CardioExerciseName {
        return CardioExerciseName(name: "Weighted Triple Under", number: 21)
    }
}
