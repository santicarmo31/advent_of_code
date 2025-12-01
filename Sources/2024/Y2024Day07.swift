import Algorithms
import Foundation

struct Y2024Day07: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // What is their total calibration result?
  func part1() -> Any {
    return data.split(separator: "\n").reduce(0) { partialResult, line in
      let equation = line.split(separator: ":").map(String.init)

      guard let testValue: Int = Int(String(equation[0])) else {
        return partialResult
      }

      let numbers = equation[1].split(separator: " ").compactMap { Int(String($0)) }

      if evaluateExpression(index: 0, values: numbers, currentValue: numbers[0], testValue: testValue) {
        return partialResult + testValue
      }

      return partialResult
    }
  }


  func part2() -> Any {
    return data.split(separator: "\n").reduce(0) { partialResult, line in
      let equation = line.split(separator: ":").map(String.init)

      guard let testValue: Int = Int(String(equation[0])) else {
        return partialResult
      }

      let numbers = equation[1].split(separator: " ").compactMap { Int(String($0)) }

      if evaluateExpression(index: 0, values: numbers, currentValue: numbers[0], testValue: testValue, useOrOperator: true) {
        return partialResult + testValue
      }

      return partialResult
    }
  }

  private func evaluateExpression(index: Int, values: [Int], currentValue: Int, testValue: Int, useOrOperator: Bool = false, operation: String = "") -> Bool {
    if index == values.count - 1 {
      let isRunningUnitTests = NSClassFromString("XCTest") != nil
      if isRunningUnitTests {
        print(operation + "\(currentValue)")
      }
      return currentValue == testValue
    }

    let nextNumber = values[index + 1]

    let result = evaluateExpression(
      index: index + 1,
      values: values,
      currentValue: currentValue + nextNumber,
      testValue: testValue,
      useOrOperator: useOrOperator,
      operation: operation + "\(currentValue) + \(nextNumber) = "
    ) ||
    evaluateExpression(
      index: index + 1,
      values: values,
      currentValue: currentValue * nextNumber,
      testValue: testValue,
      useOrOperator: useOrOperator,
      operation: operation + "\(currentValue) * \(nextNumber) = "
    )

    if useOrOperator {
      return result ||
      evaluateExpression(
        index: index + 1,
        values: values,
        currentValue: Int(String("\(currentValue)\(nextNumber)"))!,
        testValue: testValue,
        useOrOperator: useOrOperator,
        operation: operation + "\(currentValue) || \(nextNumber) = "
      )
    }

    return result
  }
}

