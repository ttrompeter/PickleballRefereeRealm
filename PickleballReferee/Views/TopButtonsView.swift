//
//  TopButtonsView.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 7/28/22.
//
import RealmSwift
import SwiftUI

struct TopButtonsView: View {
    
    @EnvironmentObject var scoresheetManager: ScoresheetManager
    @ObservedRealmObject var match: Match
    
    @State private var presentCoinTossAlert = false
    @State private var showingCorrection = false
    @State private var showingMatchSetup = false
    @State private var showingPreMatchBriefing = false
    @State private var showingTimeOut = false
    @State private var showingViolation = false
    
    let randomCoinToss = Int.random(in: 1...2)
    
    var body: some View {
        
        VStack (spacing: 20) {
            Button {
                showingTimeOut.toggle()
            } label: {
                Text("Timeout")
            }
            .buttonStyle(FunctionsButtonStyle())
            .sheet(isPresented: $showingTimeOut) { TimeOutsView(match: match) }
            
            Button {
                showingPreMatchBriefing.toggle()
            } label: {
                Text("Briefing")
            }
            .buttonStyle(FunctionsButtonStyle())
            .sheet(isPresented: $showingPreMatchBriefing) { PreMatchBriefingView() }
            
            Button {
                showingMatchSetup.toggle()
            } label: {
                if scoresheetManager.isMatchSetupComplete {
                    Text("Edit Match")
                } else {
                    Text("Match Setup")
                }
            }
            .buttonStyle(FunctionsButtonStyleGreen())
            .disabled(match.isMatchCompleted)
            .sheet(isPresented: $showingMatchSetup) { MatchSetupView(match:match) }
            
            Button {
                showingCorrection.toggle()
            } label: {
                Text("Correction")
            }
            .buttonStyle(FunctionsButtonStyle())
            .disabled(!scoresheetManager.isMatchStarted)
            .sheet(isPresented: $showingCorrection) { CorrectionView(match: match) }
            
            if match.isMatchCompleted {
                Button {
                    //createNewMatch()
                } label: {
                    Text("New Match")
                }
                .buttonStyle(FunctionsButtonStyleGreen())
            } else if !scoresheetManager.isMatchStartingServerSet {
                Button {
                    presentCoinTossAlert.toggle()
                } label: {
                    Text("Coin Toss")
                }
                .buttonStyle(FunctionsButtonStyleGreen())
                .disabled(!scoresheetManager.isMatchSetupComplete)
                .alert("\(randomCoinToss)", isPresented: $presentCoinTossAlert) {
                    Button("Done", role: .cancel) {
                    }
                }
            } else {
                Button {
                    showingViolation.toggle()
                } label: {
                    Text("Violation")
                }
                .buttonStyle(FunctionsButtonStyle())
                .sheet(isPresented: $showingViolation) { ViolationView(match: match) }
            }
            
        }
        .padding(10)
        .background(Constants.CLOUDS)
    }
    
    mutating func createNewMatch() {
        
        let newMatch = Match()
        let game1 = Game()
        game1.gameNumber = 1
        newMatch.games.append(game1)
        let game2 = Game()
        game2.gameNumber = 2
        newMatch.games.append(game2)
        let game3 = Game()
        game3.gameNumber = 3
        newMatch.games.append(game3)
        let game4 = Game()
        game4.gameNumber = 4
        newMatch.games.append(game4)
        let game5 = Game()
        game5.gameNumber = 5
        newMatch.games.append(game5)
        match = newMatch
        //saveMatch()
    }
}

struct TopButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        TopButtonsView(match: Match())
    }
}
