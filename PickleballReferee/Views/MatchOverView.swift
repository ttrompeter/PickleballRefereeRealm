//
//  MatchOver.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/23/22.
//

import RealmSwift
import SwiftUI

struct MatchOverView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var scoresheetManager: ScoresheetManager
    @EnvironmentObject var sheetManager: SheetManager
    @ObservedRealmObject var match: Match
    @FocusState private var matchOverInFocus: matchOverFocusable?
    
    
    enum matchOverFocusable: Hashable {
        case initials
    }
    
    var body: some View {
        
        VStack {
            
            Text("Match is Over")
                .bold()
                .font(.largeTitle)
                .padding(.top, 30)
            
            VStack {
                VStack {
                    Text("Winning Team")
                    Text(match.matchWinner)
                    VStack {
                        HStack {
                            Text("Match Score: ")
                            Text(match.matchFinalScore)
                        }
                        HStack {
                            Text("Game Scores: ")
                            Text(scoresheetManager.matchFinalGameScores)
                        }
                    }
                    .padding(.top, 10 )
                    .font(.headline)
                }
                .padding()
                .font(.title3)
                .foregroundColor(Constants.MINT_LEAF)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Constants.MINT_LEAF, lineWidth: 3)
                )
                
                VStack {
                    Text("Losing Team: ")
                    Text(match.matchLoser)
                }
                .font(.headline)
                .foregroundColor(Constants.DARK_SLATE)
            }
            .padding(.vertical, 20)
            
            VStack {
                HStack {
                    Text("Winning Team Player Initials: ")
                    TextField("Initials", text: $scoresheetManager.playerInitials)
                        .frame(width: 60)
                        .foregroundColor(Constants.POMAGRANATE)
                        .keyboardType(.numberPad)
                        .focused($matchOverInFocus, equals: .initials)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                                self.matchOverInFocus = .initials
                            }
                        }
                }
                .padding(10)
                .font(.headline)
                .foregroundColor(Constants.POMAGRANATE)
            }
            .padding(.horizontal, 120)
            
            MatchStatisticsView(match: match)
            
            Spacer()
            HStack (spacing: 40) {
                Button("Close") {
                    dismiss()
                }
                .buttonStyle(SheetButtonStyle())
            }
            .padding(.bottom, 20)
        }
    }
}

struct MatchOverView_Previews: PreviewProvider {
    static var previews: some View {
        MatchOverView(match: Match())
    }
}
