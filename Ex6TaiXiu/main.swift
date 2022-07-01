//
//  main.swift
//  Ex6TaiXiu
//
//  Created by Nhung Tran on 29/06/2022.
//

import Foundation

func inputBetMoney(playerMoney: Int) -> Int {
    var betMoney = 0
    print("How much do you want to bet?", terminator: " ")
    repeat {
        // ! unwrap return string input in readLine -> ??: check if nil -> return value is -1
        betMoney = Int(readLine()!) ?? -1
        if (betMoney < 0) {
            print("Money must be a number. Please try again:", terminator: " ")
            continue
        }
        else if (betMoney > playerMoney) {
            print("You do not have enough money. You only have \(playerMoney) left. Please try again:", terminator: " ")
            continue
        }
        else if (betMoney == 0) {
            print("You must enter a number to bet. Please try again:", terminator: " ")
            continue
        }
        print("You have bet \(betMoney)$")
            
    } while (betMoney > playerMoney || betMoney <= 0)
    return betMoney
}
func inputBet() -> String {
    print("Do you want to bet big or small?(big/small) ", terminator: "")
    var bet = ""
    repeat {
        bet = readLine()?.trimmingCharacters(in: .whitespaces) ?? ""
        if (bet.lowercased() == "big" || bet.lowercased() == "small") {
            return bet
        }
        else {
            print("Please only input 'big' or 'small':", terminator: " ")
        }
    } while (true)
    return bet
}
func rollDices() -> Int {
    let dices = [0, 0, 0].map {_ in Int.random(in: 1...6)}
    print("The dices are:", dices.map{String($0)}.joined(separator: " "))
    
    var total = dices.reduce(0, {x, y in x + y})
    print("The sum of dices is \(total)")
    // mark that this contain 3 same number on dices
    if (dices.indices.filter{dices[0] == dices[$0]}.count == dices.count) {
        total = -1
    }
    return total
}
func isPlayerWin(resultRoll: Int, betType: String, betAmount: Int) -> Bool {
    if ((4...10 ~= resultRoll && betType != "small") || (11...17 ~= resultRoll && betType != "big")) {
        return true
    }
    else {
        return false
    }
}
func displayFinalResult() {
    let betMoney = inputBetMoney(playerMoney: playerMoney)
    let betType = inputBet()
    let total = rollDices()
    let finalResult = isPlayerWin(resultRoll: total, betType: betType, betAmount: betMoney)
    if (finalResult) {
        print("You Won \(betMoney)!")
        playerMoney += betMoney
        houseMoney -= betMoney
    }
    else {
        print("You Lose \(betMoney)")
        playerMoney -= betMoney
        houseMoney += betMoney
    }
    print("The house has \(houseMoney)$",
          "The player has \(playerMoney)$",
          separator: "\n")
}
func checkContinue() -> Bool {
    print("Do you still want to continue to play?(true/false) ", terminator: "")
    var answer = "true"
    repeat {
        answer = readLine()?.trimmingCharacters(in: .whitespaces) ?? ""
        if (answer.lowercased() == "true") {
            return true
        }
        else if (answer.lowercased() == "false") {
            return false
        }
        else {
            print("User can only choose true/ false: ", terminator: "")
        }
    } while (true)
}
func generateGame() {
    var currentRound: Int = 1
    repeat {
        print("Round \(currentRound): ")
        displayFinalResult()
        if (playerMoney == 0) {
            print("You are out of money. Bye!")
            exit(1)
        }
        if !checkContinue() {
            print("Exitting the game")
            exit(1)
        }
        currentRound += 1
        print("")
    } while (houseMoney != 0 || playerMoney != 0)
}

var houseMoney = 1000
var playerMoney = 100
print("The house has \(houseMoney)$",
      "The player has \(playerMoney)$",
      "Try your luck to win all money of the house!",
      separator: "\n")
generateGame()

