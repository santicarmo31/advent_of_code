import Foundation
import Algorithms

struct Y2025Day06: AdventDay {
  var data: String

  var entities: [[String]] {
    data
      .split(whereSeparator: \.isNewline).map { $0.split(separator: " ").map(String.init) }
  }

  func part1() -> Int {
    var count: Int = 0
    for column in 0..<entities[0].count {
      guard let operation = entities.last?[column] else {
        continue
      }

      // Avoid looking at last row which is the operation
      guard var value: Int = Int(entities[0][column]) else { continue }
      for row in 1...entities.count - 2 {
        guard let number = Int(entities[row][column]) else {
          continue
        }

        switch operation {
        case "+":
          value += number
        case "-":
          value -= number
        case "*":
          value *= number
        default:
          fatalError("Unknown operation: \(operation)")
        }
      }
      count += value
    }

    return count
  }

  func part2() -> Int {
    let grid: [[Character]] = data.split(separator: "\n").map { $0.map(Character.init) }

    var numbersToCalculate: [Int] = []
    var numberString: String = ""
    var count: Int = 0
    for column in stride(from: grid[0].count - 1, to: -1, by: -1) {
      for row in 0..<grid.count {
        let char = grid[row][column]
        switch char {
        case "0"..."9":
          numberString.append(char)
        default:
          if row == grid.count - 1 {
            if let number = Int(numberString) {
              numbersToCalculate.append(number)
            }
            numberString = ""
          }

          if char == "+" {
            let result = numbersToCalculate.reduce(0, +)
            count += result
            numbersToCalculate = []
          } else if char == "*" {
            let result = numbersToCalculate.reduce(1, *)
            count += result
            numbersToCalculate = []
          }
        }
      }
    }
    return count
  }
}
