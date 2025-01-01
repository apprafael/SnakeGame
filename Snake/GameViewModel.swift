//
//  GameViewModel.swift
//  Snake
//
//  Created by Rafael Almeida on 10/26/22.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published var matrix: [[SquareType]] = [[SquareType]](repeating: [SquareType](repeating: .empty, count: 12), count: 12)
    @Published var gameStarted: Bool = false

    private var selectedDirection: Directions = .right
    private var headPositon = (1,1)
    private var foodPositon = (1,1)
    private var body = [(Int,Int)]()
    private var size = 1
    private var timer: Timer?
    private var speed = 1.0
    private var foodtype: SquareType = .food

    func updateSnakePositon(columIndex: Int, rowIndex: Int) {
        matrix[columIndex][rowIndex] = .snake
    }
    
    func updateFoodPositon(columIndex: Int, rowIndex: Int) {
        matrix[columIndex][rowIndex] = foodtype
    }
    
    func startGame() {
        headPositon = (1,1)
        foodPositon = (1,1)
        body = [(1,1)]
        size = 0
        speed = 1.0
        
        matrix = [[SquareType]](repeating: [SquareType](repeating: .empty, count: 12), count: 12)
        foodPositon = (Int.random(in: 0..<matrix.count - 1), Int.random(in: 0..<matrix[0].count - 1))
        updateFoodPositon(columIndex: foodPositon.0, rowIndex: foodPositon.1)
        playGame()

        gameStarted = true
    }
    
    func pauseGame() {
        timer?.invalidate()
    }
    
    func playGame() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: speed, target: self, selector: #selector(move), userInfo: nil, repeats: true)
    }

    func userMovement(direction: Directions) {
        switch direction {
        case .right:
            if selectedDirection == .left && body.count > 1 {
                return
            }
        case .left:
            if selectedDirection == .right && body.count > 1 {
                return
            }
        case .up:
            if selectedDirection == .down && body.count > 1 {
                return
            }
        case .down:
            if selectedDirection == .up && body.count > 1 {
                return
            }
        }
                
        timer?.invalidate()
        selectedDirection = direction
        
        move()
        playGame()
    }
    
    @objc func move() {
        switch selectedDirection {
        case .right:
            headPositon.1 += 1
        case .left:
            headPositon.1 -= 1
        case .up:
            headPositon.0 -= 1
        case .down:
            headPositon.0 += 1
        }
        
        wallColider()
        selfBodyColider()
        eatFood()

        updateFoodPositon(columIndex: foodPositon.0, rowIndex: foodPositon.1)
        updateSnakePositon(columIndex: headPositon.0, rowIndex: headPositon.1)

        genareteBody()
    }
    
    func wallColider() {
        if headPositon.1 == matrix.count {
            headPositon.1 = 0
        } else if headPositon.1 == -1 {
            headPositon.1 = matrix.count - 1
        } else if headPositon.0 == matrix[0].count {
            headPositon.0 = 0
        } else if headPositon.0 == -1 {
            headPositon.0 = matrix[0].count - 1
        }
    }
    
    func selfBodyColider() {
        if body.contains(where: { bodyPart in
            bodyPart == headPositon
        }) {
            gameStarted = false
        }
    }
    
    func eatFood() {
        if headPositon == foodPositon {
            size += matrix[foodPositon.0][foodPositon.1] == .growthPotion ? 5 : 1
            foodPositon = (Int.random(in: 0..<matrix.count - 1), Int.random(in: 0..<matrix[0].count - 1))
            speed -= matrix[foodPositon.0][foodPositon.1] == .speedPotion ? 0.05 : 0.02

            let items: [SquareType] = [.food, .growthPotion, .speedPotion]
            foodtype = items.randomElement() ?? .food
        }
    }
    
    func genareteBody() {
        body.append(headPositon)

        body.forEach { bodyPart in
            updateSnakePositon(columIndex: bodyPart.0, rowIndex: bodyPart.1)
        }
        
        if body.count > size + 1 {
            matrix[body.first?.0 ?? 0][body.first?.1 ?? 0] = .empty
            body.removeFirst()
        }
    }
}
