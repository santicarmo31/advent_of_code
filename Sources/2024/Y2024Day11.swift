import Algorithms
import Foundation

struct Y2024Day11: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  private var entities: [Int] {
    data.split(separator: "\n").flatMap {
      $0.split(separator: " ").compactMap { Int(String($0)) }
    }
  }

  func part1() -> Any {
    let blinkingTimes = 25    
    return self.transformStones(self.entities, blinkingTimes: blinkingTimes).count
  }

  func part2() -> Any {
    let blinkingTimes = 75
    var cache: [String: Int] = [:]
    return self.entities
      .map { self.transformStone($0, blinkingTimes: blinkingTimes, cache: &cache) }
      .reduce(0, +)
  }

  private func transformStones(_ stones: [Int], blinkingTimes: Int) -> [Int] {
    if blinkingTimes == 0 {
      return stones
    }

    return self.transformStones(stones.flatMap(self.firstRuleTransform), blinkingTimes: blinkingTimes - 1)
  }

  private func transformStone(_ stone: Int, blinkingTimes: Int, cache: inout [String: Int]) -> Int {

    if blinkingTimes == 0 {
      return 1
    }

    let key = "\(blinkingTimes)-\(stone)"
    if let cachedValue = cache[key] {
      return cachedValue
    }

    let result: Int
    if stone == 0 {
      result = self.transformStone(1, blinkingTimes: blinkingTimes - 1, cache: &cache)
    } else {
      let stringValue = String(stone)
      if stringValue.count.isMultiple(of: 2) {
        let leftHalf = stringValue.prefix(stringValue.count / 2)
        let rightHalf = stringValue.suffix(stringValue.count / 2)
        result =
        self.transformStone(Int(leftHalf)!, blinkingTimes: blinkingTimes - 1, cache: &cache) +
        self.transformStone(Int(rightHalf)!, blinkingTimes: blinkingTimes - 1, cache: &cache)
      } else {
        result = self.transformStone(stone * 2024, blinkingTimes: blinkingTimes - 1, cache: &cache)
      }
    }
    
    cache[key] = result
    return result
  }

  /// If the stone is engraved with the number 0, it is replaced by a stone engraved with the number 1.
  private func firstRuleTransform(_ value: Int) -> [Int] {
    return value == 0 ? [1] : self.secondRuleTransform(value)
  }

  /// If the stone is engraved with a number that has an even number of digits, it is replaced by two stones.
  ///  The left half of the digits are engraved on the new left stone, and the right half of the digits are engraved on the
  ///  new right stone. (The new numbers don't keep extra leading zeroes: 1000 would become stones 10 and 0.)
  private func secondRuleTransform(_ value: Int) -> [Int] {
    let stringValue = String(value)
    guard stringValue.count.isMultiple(of: 2) else {
      return self.defaultRuleTransform(value)
    }

    let leftHalf = stringValue.prefix(stringValue.count / 2)
    let rightHalf = stringValue.suffix(stringValue.count / 2)

    return [Int(leftHalf)!, Int(rightHalf)!]
  }

  /// The stone is replaced by a new stone; the old stone's number multiplied by 2024 is engraved on the new stone.
  private func defaultRuleTransform(_ value: Int) -> [Int] {
    return [value * 2024]
  }
}
