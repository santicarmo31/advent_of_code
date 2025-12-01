import Algorithms
import Foundation

struct Y2024Day10: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  private var entities: [[Int]] {
    data.split(separator: "\n").map {
      $0.compactMap { Int(String($0)) }
    }
  }

  private var startHeight: Int { 0 }
  private var endHeight: Int { 9 }

  func part1() -> Any {
    let map: [[Int]] = data.split(separator: "\n").map {
      $0.compactMap { Int(String($0)) }
    }

    var score = 0
    for i in 0..<map.count {
      for j in 0..<map[i].count {
        if map[i][j] == self.startHeight {
          score += self.findHikingTrail(from: (i, j), map: map, debug: "\(i), \(j)", foundPositions: []).count
        }
      }
    }
    return score
  }

  func part2() -> Any {
    let map = self.entities
    var score = 0
    for i in 0..<map.count {
      for j in 0..<map[i].count {
        if map[i][j] == self.startHeight {
          let positions = self.findHikingTrail(from: (i, j), map: map, debug: "trailHead", rating: [])          
          score += positions.count
        }
      }
    }
    return score
  }

  private func findHikingTrail(from start: (row: Int, column: Int), map: [[Int]], debug: String, foundPositions: Set<String>) -> Set<String> {
    let current = map[start.row][start.column]
    let next = current + 1
    if next == self.endHeight + 1 {
      return foundPositions.union(["\(start.row), \(start.column)"])
    }

    var foundPositions = foundPositions
    if start.column + 1 < map[start.row].count, map[start.row][start.column+1] == next {
      foundPositions.formUnion(self.findHikingTrail(from: (start.row, start.column+1), map: map, debug: "\(debug) -> \(start)", foundPositions: foundPositions))
    }
    if start.column - 1 >= 0, map[start.row][start.column-1] == next {
      foundPositions.formUnion(self.findHikingTrail(from: (start.row, start.column-1), map: map, debug: "\(debug) -> \(start)", foundPositions: foundPositions))
    }
    if start.row + 1 < map.count, map[start.row+1][start.column] == next {
      foundPositions.formUnion(self.findHikingTrail(from: (start.row+1, start.column), map: map, debug: "\(debug) -> \(start)", foundPositions: foundPositions))
    }
    if start.row - 1 >= 0, map[start.row-1][start.column] == next {
      foundPositions.formUnion(self.findHikingTrail(from: (start.row-1, start.column), map: map, debug: "\(debug) -> \(start)", foundPositions: foundPositions))
    }

    return foundPositions
  }

  private func findHikingTrail(from start: (row: Int, column: Int), map: [[Int]], debug: String, rating: Set<String>) -> Set<String> {
    let description = "\(start.row), \(start.column)"
    let current = map[start.row][start.column]
    let next = current + 1
    if current == self.endHeight {
      return rating.union(["\(debug) -> \(description)"])
    }

    var foundPositions: Set<String> = rating
    if start.column + 1 < map[start.row].count, map[start.row][start.column+1] == next {
      foundPositions.formUnion(self.findHikingTrail(from: (start.row, start.column+1), map: map, debug: "\(debug) -> \(description)", rating: foundPositions))
    }

    if start.column - 1 >= 0, map[start.row][start.column-1] == next {
      foundPositions.formUnion(self.findHikingTrail(from: (start.row, start.column-1), map: map, debug: "\(debug) -> \(description)", rating: foundPositions))
    }

    if start.row + 1 < map.count, map[start.row+1][start.column] == next {
      foundPositions.formUnion(self.findHikingTrail(from: (start.row+1, start.column), map: map, debug: "\(debug) -> \(description)", rating: foundPositions))
    }

    if start.row - 1 >= 0, map[start.row-1][start.column] == next {
      foundPositions.formUnion(self.findHikingTrail(from: (start.row-1, start.column), map: map, debug: "\(debug) -> \(description)", rating: foundPositions))
    }

    return foundPositions
  }
}
