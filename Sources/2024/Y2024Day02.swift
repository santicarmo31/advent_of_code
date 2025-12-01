import Algorithms
import Foundation

struct Y2024Day02: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [[Int]] {
    data.split(separator: "\n").map {
      $0.split(separator: " ").compactMap { Int($0) }
    }
  }

  // How many reports are safe
  func part1() -> Any {
    var safeReports = 0
    entities.forEach {
      if self.findSafeReports(from: $0) {
        safeReports += 1
      }
    }
    return safeReports
  }

  // Handle situations where the Problem Dampener can remove a single level from unsafe reports
  func part2() -> Any {
    var safeReports = 0
    entities.forEach {
      guard self.findSafeReports(from: $0) else {
        for index in 0..<$0.count {
          var report = $0
          report.remove(at: index)
          if self.findSafeReports(from: report) {
            safeReports += 1
            return
          }
        }
        return
      }
      
      safeReports += 1
    }
    return safeReports
  }


  private func findSafeReports(from report: [Int]) -> Bool {
    guard var currentValue = report.first, report.count > 1 else {
      return false
    }

    let isIncreasing = report[1] > currentValue

    for index in 1..<report.count {
      let nextValue = report[index]
      let substraction = abs(nextValue - currentValue)
      let isSubstractionInRange = substraction >= 1 && substraction <= 3
      guard substraction > 0, isSubstractionInRange else {
        return false
      }

      if isIncreasing {
        guard nextValue > currentValue else {
          return false
        }
      } else {
        guard nextValue < currentValue else {
          return false
        }
      }

      currentValue = nextValue
    }
    return true
  }
}
