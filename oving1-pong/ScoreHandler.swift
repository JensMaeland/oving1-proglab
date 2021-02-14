//
//  CalculateScore.swift
//  oving1-pong
//
//  Created by Jonas Sæther on 14/02/2021.
//

import Foundation
import SpriteKit

class Score {
    
    func increment(playerWinner: SKSpriteNode, score: Array<Int>) -> Array<Int> {
        var newScore = score;
        let winningScore = 4;
        
        checkWinner1:if playerWinner.name == "main" {
            newScore[0] += 1
            if score[0] >= winningScore {
                return [0,0];
            }
        }

        checkWinner2:if playerWinner.name == "enemy" {
            newScore[1] += 1
            if score[1] >= winningScore {
                return [0,0];
            }
        }
        
        return newScore;
}
}
