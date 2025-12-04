import Foundation
import Algorithms

struct Y2025Day03: AdventDay {
  var data: String

  var entities: [String] {
    data.split(separator: "\n").map { String($0).replacingOccurrences(of: "\n", with: "")}
  }

  func part1() -> Int {
    return entities.reduce(into: 0) { partialResult, bank in
      guard bank.count > 2 else { return }
      var greatestValue = "0"
      for i in 0..<bank.count - 1 {
        let battery1 = bank[bank.index(bank.startIndex, offsetBy: i)]
        for j in i+1..<bank.count {
          let battery2 = bank[bank.index(bank.startIndex, offsetBy: j)]
          let newBattery = "\(battery1)\(battery2)"
          if newBattery > greatestValue {
            greatestValue = newBattery
          }
        }
      }
      partialResult += Int("\(greatestValue)") ?? 0
      
    }
  }

  func part2() -> Int {
    entities.reduce(into: 0) { partialResult, bank in
      partialResult += bestJoltage(for: bank, count: 12)
    }
  }

  func bestJoltage(for bank: String, count k: Int = 12) -> Int {
    let chars = Array(bank)
    let n = chars.count
    guard k > 0, k <= n else { return 0 }

    var result: [Character] = []
    result.reserveCapacity(k)

    var start = 0

    for i in 0..<k {
      let remainingToPick = k - i
      // We cannot start beyond this index, or we won't have enough chars left
      let maxStartIndex = n - remainingToPick

      var bestIndex = start
      var bestChar = chars[start]

      // Window 0 ... (15 - 12) = 3, Look from 0...3
      if start < maxStartIndex {
        var idx = start + 1
        while idx <= maxStartIndex {
          if chars[idx] > bestChar {
            bestChar = chars[idx]
            bestIndex = idx
          }
          idx += 1
        }
      }

      result.append(bestChar)
      start = bestIndex + 1
    }

    return Int(String(result)) ?? 0
  }
}
