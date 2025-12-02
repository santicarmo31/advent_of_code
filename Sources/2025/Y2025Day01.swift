import Foundation
import Algorithms

struct Y2025Day01: AdventDay {
  var data: String

  var entities: [String] {
    data.split(separator: "\n").map(String.init)
  }

  private let minusOperator = "L"
  private let plusOperator = "R"
  private let minimum: Int = 0
  private let maximum: Int = 99
  private let dialStartPoint: Int = 50

  func part1() -> Int {
    var dial = dialStartPoint
    var password = 0
    entities.forEach { entity in
      guard let operation = entity.first.map({ String($0) }),
            let value = Int(String(entity.filter { $0.isNumber })) else {
        dial = dialStartPoint
        fatalError("Parse error")
      }

      if operation == minusOperator {
        dial = subtract(value, from: dial)
      } else if operation == plusOperator {
        dial = add(value, to: dial)
      }

      if dial == 0 {
        password += 1
      }
    }

    return password
  }

  func part2() -> Int {
    var dial = dialStartPoint
    var password = 0
    entities.forEach { entity in
      guard let operation = entity.first.map({ String($0) }),
            var value = Int(String(entity.filter { $0.isNumber })) else {
        dial = dialStartPoint
        fatalError("Parse error")
      }

      if operation == minusOperator {
        while value != 0 {
          value -= 1
          dial -= 1

          if dial < minimum {
            dial = maximum
          }

          if dial == minimum {
            password += 1
          }
        }
      } else {
        while value != 0 {
          value -= 1
          dial += 1

          if dial > maximum {
            dial = minimum
          }

          if dial == minimum {
            password += 1
          }
        }
      }
    }

    return password
  }

  private func add(_ value: Int, to dial: Int) -> Int {
    let newValue = (dial + value) % 100
    print("\(dial) + \(value) = \(newValue)")
    return newValue
  }

  private func subtract(_ value: Int, from dial: Int) -> Int {
    let newValue = (((dial - value) % 100) + 100) % 100
    print("\(dial) - \(value) = \(newValue)")
    return newValue
  }
}
