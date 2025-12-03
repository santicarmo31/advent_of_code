import Foundation
import Algorithms

struct Y2025Day02: AdventDay {
  var data: String

  var entities: [String] {
    data.split(separator: ",").map { String($0).replacingOccurrences(of: "\n", with: "")}
  }

  func part1() -> Int {
    return entities.reduce(into: 0) { partialResult, entity in
      let ids = entity.split(separator: "-")
      guard ids.count == 2, let firstId = Int(ids[0]), let lastId = Int(ids[1]) else {
        return
      }

      for number in firstId...lastId {
        let numberString = String(number)
        let mid = numberString.count / 2
        let midIndex = numberString.index(numberString.startIndex, offsetBy: mid)
        let firstHalf = numberString.prefix(upTo: midIndex)
        let secondHalf = numberString.suffix(from: midIndex)
        if firstHalf == secondHalf {
          print("Found one invalid id: \(number)")
          partialResult += number
        }
      }
    }
  }

  func part2() -> Int {    
    return entities.reduce(into: 0) {
      partialResult,
      entity in
      print(entity)
      let ids = entity.split(separator: "-")
      guard ids.count == 2,
            let firstId = Int(ids[0]),
            let lastId = Int(ids[1]) else {
        return
      }
      for number in firstId...lastId {
        let numberString = String(number)
        guard numberString.count > 1 else { continue }
        let doubled = numberString + numberString
        if let range = doubled.range(
          of: numberString,
          options: [],
          range: doubled.index(after: doubled.startIndex)..<doubled.index(before: doubled.endIndex)
        ) {
          let periodLength = doubled.distance(from: doubled.startIndex, to: range.lowerBound)
          if periodLength > 0, numberString.count % periodLength == 0 {
            let unit = String(numberString.prefix(periodLength))
            let times = numberString.count / periodLength            
            if String(repeating: unit, count: times) == numberString {
              print("Found number: \(number) as \(unit) x \(times)")
              partialResult += number
            }
          }
        }
      }
    }
  }
}
