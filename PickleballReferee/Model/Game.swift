//
//  Game.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 7/28/22.
//

import RealmSwift
import SwiftUI

class Game: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var asstRefereeName = ""
    @Persisted var gameElapsedTime = 0.0
    @Persisted var gameFinalScore = "N/A"
    @Persisted var gameFirstServerName = "Adam Rocafeller"  // Should be Undetermined
    @Persisted var gameFirstServerPlayerNumber = 1  // Should be 0
    @Persisted var gameNumber = 0
    @Persisted var gameWinner = ""
    @Persisted var gameWinningTeam = 0
    @Persisted var isGameCompleted = false
    @Persisted var isGameWinner = false
    @Persisted var isServerSideSet = true    // Should be false
    @Persisted var lineJudge1Name = ""
    @Persisted var lineJudge2Name = ""
    @Persisted var lineJudge3Name = ""
    @Persisted var lineJudge4Name = ""
    @Persisted var player1Team1Points = 0
    @Persisted var player2Team1Points = 0
    @Persisted var player1Team2Points = 0
    @Persisted var player2Team2Points = 0
    @Persisted var refereeName = "Buddy Vistok"  // Should be ""
    @Persisted var selectedFirstServerTeam1 = 1     // Should be 0
    @Persisted var selectedFirstServerTeam2 = 4     // Should be 0
    @Persisted var sideOutsTeam1 = 0
    @Persisted var sideOutsTeam2 = 0
    @Persisted var timeOutsTeam1 = 0
    @Persisted var timeOutsTeam2 = 0
    @Persisted var traineeName = ""
    
    @Persisted(originProperty: "games") var match: LinkingObjects<Match>
    
    
    var gameScoreTeam1: Int {
        player1Team1Points + player2Team1Points
    }
    
    var gameScoreTeam2: Int {
        player1Team2Points + player2Team2Points
    }
    
    var finalScoreWinningTeam: Int {
        if isGameCompleted {
            if gameScoreTeam1 > (gameScoreTeam2 + 1) {
                return gameScoreTeam1
            } else {
                return gameScoreTeam2
            }
        }
        return 0
    }
    
    var finalScoreLosingTeam: Int {
        if isGameCompleted {
            if (gameScoreTeam1 + 1) < gameScoreTeam2 {
                return gameScoreTeam1
            } else {
                return gameScoreTeam2
            }
        }
        return 0
    }
    
    // Add Example Data
    static let exampleGame = Game()
    
    // Change Equatable test to only test on id since it is unique. Makes code faster
    static func ==(lhs: Game, rhs: Game) -> Bool {
        lhs.id == rhs.id
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }

}
