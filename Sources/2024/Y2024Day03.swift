import Algorithms
import Foundation

struct Y2024Day03: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // How many reports are safe
  func part1() -> Any {
    self.calculateMultiplications(from: self.data)
  }

  // Handle situations where the Problem Dampener can remove a single level from unsafe reports
  func part2() -> Any {
    return self.calculateMultiplicationsUsingDoAndDont(from: self.data)
  }
}

extension Y2024Day03 {
  func calculateMultiplications(from data: String) -> Int {
    let scanner = Scanner(string: data)
    let initialPattern = "mul("
    let endPattern = ")"
    var result = 0

    while !scanner.isAtEnd {
      _ = scanner.scanUpToString(initialPattern)
      _ = scanner.scanString(initialPattern)
      let firstNumber = scanner.scanCharacters(from: .decimalDigits)
      _ = scanner.scanString(",")
      let secondNumber = scanner.scanCharacters(from: .decimalDigits)
      if scanner.scanString(endPattern) != nil, let firstNumber, firstNumber.count <= 3,
         let secondNumber, secondNumber.count <= 3 {
        result += Int(firstNumber)! * Int(secondNumber)!
      }
    }
    return result
  }

  func calculateMultiplicationsUsingDoAndDont(from data: String) -> Int {
    let scanner = Scanner(string: data)
    let doPattern = "do()"
    let dontPattern = "don't()"
    let initialPattern = "mul("
    let endPattern = ")"
    var result = 0
    var disableMultiplication = false

    while !scanner.isAtEnd {
      if let value = scanner.scanUpToString(initialPattern) {
        let doIndex = value.range(of: doPattern, options: .backwards)
        let dontIndex = value.range(of: dontPattern, options: .backwards)

        if let doIndex = doIndex, let dontIndex = dontIndex {
          disableMultiplication = dontIndex.upperBound > doIndex.upperBound
        } else if doIndex != nil {
          disableMultiplication = false
        } else if dontIndex != nil {
          disableMultiplication = true
        }
      }
      _ = scanner.scanString(initialPattern)
      let firstNumber = scanner.scanCharacters(from: .decimalDigits)
      _ = scanner.scanString(",")
      let secondNumber = scanner.scanCharacters(from: .decimalDigits)
      if scanner.scanString(endPattern) != nil,
         disableMultiplication == false,
         let firstNumber, firstNumber.count <= 3,
         let secondNumber, secondNumber.count <= 3 {
        result += Int(firstNumber)! * Int(secondNumber)!
      }
    }
    return result
  }
}
