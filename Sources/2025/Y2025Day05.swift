import Foundation
import Algorithms

struct Y2025Day05: AdventDay {
  var data: String

  var entities: [String] {
    data.split(separator: "\n\n").map(String.init)
  }

  func part1() -> Int {
    let ranges: [(Int, Int)] = entities[0]
      .split(separator: "\n")
      .compactMap { range in
        return self.range(from: String(range))
      }


    return entities[1].split(separator: "\n").reduce(into: 0) { partialResult, number in
      guard let number = Int(number) else { return }
      let isInRange = ranges.contains(where: { $0.0 <= number && number <= $0.1 })
      partialResult += isInRange ? 1 : 0
    }
  }

  func part2() -> Int {
    let ranges: [(Int, Int)] = entities[0]
      .split(separator: "\n")
      .compactMap { line -> (Int, Int)? in
        range(from: String(line))
      }

    guard !ranges.isEmpty else { return 0 }

    let sortedRanges = ranges.sorted { lhs, rhs in
      lhs.0 < rhs.0
    }

    var totalCount = 0
    var currentStart = sortedRanges[0].0
    var currentEnd   = sortedRanges[0].1

    for (start, end) in sortedRanges.dropFirst() {
      if start <= currentEnd + 1 {
        // Overlapping or touching ranges → merge them
        // Example: current: 10–14, next: 12–18 → currentEnd becomes 18
        currentEnd = max(currentEnd, end)
      } else {
        // Disjoint range → close the previous one and start a new one
        totalCount += currentEnd - currentStart + 1
        currentStart = start
        currentEnd = end
      }
    }

    // Don't forget to add the last merged range
    totalCount += currentEnd - currentStart + 1

    return totalCount
  }

  private func range(from line: String) -> (Int, Int)? {
    let parts = line.split(separator: "-")
    guard parts.count == 2, let lower = Int(parts[0]), let upper = Int(parts[1]) else { return nil }
    return (lower, upper)
  }
}

