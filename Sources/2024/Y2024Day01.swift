import Algorithms

struct Y2024Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [[Int]] {
    var firstList = [Int]()
    var secondList = [Int]()
    data.split(separator: "\n").forEach {
      let values = $0.split(separator: "   ").compactMap { Int($0) }
      firstList.append(values[0])
      secondList.append(values[1])
    }

    return [firstList, secondList]
  }

  // find the total distance between the left list and the right list
  func part1() -> Any {
    let sortedData = entities.map { $0.sorted(by: <) }
    var distance = 0
    for (i, j) in zip(sortedData[0], sortedData[1]) {
      distance += abs(i - j)
    }

    return distance
  }

  // Calculate a total similarity score between the two lists
  func part2() -> Any {
    guard entities.count == 2 else {
      return 0
    }

    let firstList = entities[0]
    let lastList = entities[1]

    return firstList.reduce(0) { partialResult, nextValue in
      return partialResult + nextValue * lastList.filter { $0 == nextValue }.count
    }
  }
}
