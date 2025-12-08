import Foundation
import Algorithms

struct Y2025Day08: AdventDay {

  let data: String
  let first: Int

  init(data: String) {
    self.init(data: data, first: 1000)
  }

  init(data: String, first: Int) {
    self.data = data
    self.first = first
  }

  var entities: [String] {
    data.split(separator: "\n").map(String.init)
  }

  // MARK: - Helpers

  struct BoxPair {
    let distanceSquared: Int
    let firstIndex: Int
    let secondIndex: Int
  }

  struct UnionFind {
    private(set) var parent: [Int]
    private(set) var size: [Int]
    private(set) var componentCount: Int

    init(count: Int) {
      parent = Array(0..<count)
      size = Array(repeating: 1, count: count)
      componentCount = count
    }

    mutating func find(_ index: Int) -> Int {
      if parent[index] != index {
        parent[index] = find(parent[index])
      }
      return parent[index]
    }

    /// Returns true if this call actually merged two different components.
    @discardableResult
    mutating func union(_ first: Int, _ second: Int) -> Bool {
      let rootFirst = find(first)
      let rootSecond = find(second)
      if rootFirst == rootSecond {
        return false
      }

      if size[rootFirst] < size[rootSecond] {
        parent[rootFirst] = rootSecond
        size[rootSecond] += size[rootFirst]
      } else {
        parent[rootSecond] = rootFirst
        size[rootFirst] += size[rootSecond]
      }

      componentCount -= 1
      return true
    }

    mutating func componentSizes() -> [Int] {
      var counts: [Int: Int] = [:]
      for index in parent.indices {
        let root = find(index)
        counts[root, default: 0] += 1
      }
      return Array(counts.values)
    }
  }

  /// Builds all unordered pairs of boxes with their squared Euclidean distance,
  /// sorted by ascending distance.
  private func sortedPairs(for boxes: [JunctionBox]) -> [BoxPair] {
    let count = boxes.count
    var pairs: [BoxPair] = []

    for firstIndex in 0..<count {
      for secondIndex in (firstIndex + 1)..<count {
        let dx = boxes[firstIndex].x - boxes[secondIndex].x
        let dy = boxes[firstIndex].y - boxes[secondIndex].y
        let dz = boxes[firstIndex].z - boxes[secondIndex].z
        let distanceSquared = dx * dx + dy * dy + dz * dz

        pairs.append(
          BoxPair(
            distanceSquared: distanceSquared,
            firstIndex: firstIndex,
            secondIndex: secondIndex
          )
        )
      }
    }

    pairs.sort { $0.distanceSquared < $1.distanceSquared }
    return pairs
  }

  // MARK: - Part 1

  func part1() -> Int {
    let boxes = entities.map(JunctionBox.init)
    let boxCount = boxes.count

    let pairs = sortedPairs(for: boxes)

    var unionFind = UnionFind(count: boxCount)

    // Connect the n closest pairs (or all, if fewer than 1000).
    let numberOfConnections = min(first, pairs.count)
    for index in 0..<numberOfConnections {
      let pair = pairs[index]
      unionFind.union(pair.firstIndex, pair.secondIndex)
    }

    let sizes = unionFind.componentSizes().sorted(by: >)
    let topThreeSizes = sizes.prefix(3)
    guard !topThreeSizes.isEmpty else { return 0 }

    return topThreeSizes.reduce(1, *)
  }

  // MARK: - Part 2

  func part2() -> Int {
    let boxes = entities.map(JunctionBox.init)
    let boxCount = boxes.count

    let pairs = sortedPairs(for: boxes)

    var unionFind = UnionFind(count: boxCount)
    var lastMergingPair: BoxPair? = nil

    for pair in pairs {
      // Only record pairs that actually merge two different components.
      if unionFind.union(pair.firstIndex, pair.secondIndex) {
        lastMergingPair = pair
      }

      // Stop once all boxes are in a single circuit.
      if unionFind.componentCount == 1 {
        break
      }
    }

    guard let finalPair = lastMergingPair else {
      // Graph was already fully connected or input is degenerate.
      return 0
    }

    let firstBox = boxes[finalPair.firstIndex]
    let secondBox = boxes[finalPair.secondIndex]

    return firstBox.x * secondBox.x
  }

  // MARK: - JunctionBox

  struct JunctionBox: Hashable, CustomStringConvertible {
    var description: String {
      return "\(x),\(y),\(z)"
    }

    let x, y, z: Int

    init(x: Int, y: Int, z: Int) {
      self.x = x
      self.y = y
      self.z = z
    }

    init(_ s: String) {
      let parts = s.split(separator: ",")
      precondition(parts.count == 3, "Expected three comma-separated integers, got: \(s)")
      guard
        let x = Int(parts[0].trimmingCharacters(in: .whitespaces)),
        let y = Int(parts[1].trimmingCharacters(in: .whitespaces)),
        let z = Int(parts[2].trimmingCharacters(in: .whitespaces))
      else {
        preconditionFailure("Failed to parse coordinates from: \(s)")
      }
      self.x = x
      self.y = y
      self.z = z
    }
  }
}
