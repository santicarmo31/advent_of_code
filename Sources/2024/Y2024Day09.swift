import Algorithms
import Foundation

struct Y2024Day09: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  func part1() -> Any {
    var blocks = data.enumerated().reduce(into: [Int]()) { (partialResult, arg1) in
      let (index, value) = arg1
      let isFile = index % 2 == 0
      let count = Int(String(value)) ?? 0
      if isFile {
        return partialResult.append(contentsOf: Array(repeating: index / 2, count: count))
      }
      return partialResult.append(contentsOf: Array(repeating: -1, count: count))
    }

    var i = blocks.indices.first!
    var j = blocks.indices.last!

    while i < j {
      if blocks[i] != -1 {
        i = blocks.index(after: i)
        continue
      }

      if blocks[j] == -1 {
        j = blocks.index(before: j)
        continue
      }

      blocks.swapAt(i, j)
      i = blocks.index(after: i)
      j = blocks.index(before: j)
    }

    return blocks.enumerated().reduce(0) { partialResult, value in
      let fileId = value.offset
      guard value.element != -1 else {
        return partialResult
      }
      return partialResult + fileId * value.element
    }
  }


  func part2() -> Any {
    var blocks = data.enumerated().reduce(into: [Int]()) { (partialResult, arg1) in
      let (index, value) = arg1
      let isFile = index % 2 == 0
      let count = Int(String(value)) ?? 0
      if isFile {
        return partialResult.append(contentsOf: Array(repeating: index / 2, count: count))
      }
      return partialResult.append(contentsOf: Array(repeating: -1, count: count))
    }

    let i = blocks.indices.first!
    var j = blocks.indices.last!

    while j - 1 > i {
      guard blocks[j] != -1 else {
        j = blocks.index(before: j)
        continue
      }

      let fileId = blocks[j]
      var y = j
      while blocks[y] == fileId {
        y = blocks.index(before: y)
      }
      let fileIdCount = j - y

      var x = i
      while x < y {
        guard blocks[x] == -1  else {
          x = blocks.index(after: x)
          continue
        }

        var w = x
        while blocks[w] == -1 {
          w = blocks.index(after: w)
        }
        let emptyCount = w - x
        guard fileIdCount <= emptyCount else {
          x = blocks.index(after: x)
          continue
        }

        for value in 0..<fileIdCount {
          blocks.swapAt(x + value, j - value)
        }
        x = blocks.index(x, offsetBy: fileIdCount)
        break
      }

      j = y
    }

    return blocks.enumerated().reduce(0) { partialResult, value in
      let fileId = value.offset
      guard value.element != -1 else {
        return partialResult
      }
      return partialResult + fileId * value.element
    }
  }
}
