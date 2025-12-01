import Algorithms
import Foundation

struct Y2024Day05: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [String] {
    data.split(separator: "\n\n").map { String($0) }
  }

  // What do you get if you add up the middle page number from those correctly-ordered updates
  func part1() -> Any {
    let rules = entities.first!.split(separator: "\n").reduce(into: [Int:[Int]]()) { partialResult, rule in
      let numbers = rule.split(separator: "|").map { String($0) }.compactMap(Int.init)
      return partialResult[numbers[0], default: []].append(numbers[1])
    }

    let lines: [[Int]] = entities.last!.split(separator: "\n").map {
      $0.split(separator: ",").compactMap { Int($0) }
    }

    return lines.reduce(0) { partialResult, line in
      let sortedLine = line.sorted { rules[$0]?.contains($1) == true }
      guard line == sortedLine else { return partialResult }
      return partialResult + (sortedLine.middle ?? 0)
    }
  }


  func part2() -> Any {
    let rules = entities.first!.split(separator: "\n").reduce(into: [Int:[Int]]()) { partialResult, rule in
      let numbers = rule.split(separator: "|").map { String($0) }.compactMap(Int.init)
      return partialResult[numbers[0], default: []].append(numbers[1])
    }

    let lines: [[Int]] = entities.last!.split(separator: "\n").map {
      $0.split(separator: ",").compactMap { Int($0) }
    }

    return lines.reduce(0) { partialResult, line in
      let sortedLine = line.sorted { rules[$0]?.contains($1) == true }
      guard line != sortedLine else { return partialResult }
      return partialResult + (sortedLine.middle ?? 0)
    }
  }
}

extension Array {
  fileprivate var middle: Element? {
    guard count != 0 else { return nil }

    let middleIndex = (count > 1 ? count - 1 : count) / 2
    return self[middleIndex]
  }
}
