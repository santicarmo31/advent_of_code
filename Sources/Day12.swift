import Algorithms
import Foundation

struct Day12: AdventDay {
  var data: String

  private var entities: [[Character]] {
    data.split(separator: "\n").map {
      $0.map { $0 }
    }
  }

  func part1() -> Any {
//    var regions: Set<Region> = []
//    var price: Int = 0
//    for i in 0..<entities.count {
//      for j in 0..<entities.count {
//        let gardenPlot = GardenPlot(row: i, column: j, plant: entities[i][j])
//        if regions.contains(where: { $0.gardenPlots.contains(gardenPlot) }) {
//          continue
//        }
//        let region = self.formRegion(gardenPlot: gardenPlot)
//        regions.insert(region)
//        price += region.fencePrice
//      }
//    }
//
//    return price
    PartUnimplemented(day: 12, part: 2)
  }

  func part2() throws -> Any {
    throw PartUnimplemented(day: 12, part: 2)
  }

  private func formRegion(gardenPlot: GardenPlot) -> Region {
    let neighbors = self.neighbors(gardenPlot: gardenPlot, neighbors: .init())
    if neighbors.isEmpty {
      return Region(gardenPlots: [gardenPlot])
    }
    return Region(gardenPlots: neighbors)
  }

  private func neighbors(gardenPlot: GardenPlot, neighbors: Set<GardenPlot>) -> Set<GardenPlot> {
    let row = gardenPlot.row
    let column = gardenPlot.column

    if neighbors.contains(gardenPlot) {
      return neighbors
    }

    var neighbors: Set<GardenPlot> = neighbors

    if column + 1 < entities[row].count, entities[row][column+1] == gardenPlot.plant {
      let plot = GardenPlot(row: row, column: column+1, plant: gardenPlot.plant)
      neighbors.formUnion(self.neighbors(gardenPlot: plot, neighbors: neighbors.union([gardenPlot])))
    }

    if column - 1 >= 0, entities[row][column-1] == gardenPlot.plant {
      let plot = GardenPlot(row: row, column: column-1, plant: gardenPlot.plant)
      neighbors.formUnion(self.neighbors(gardenPlot: plot, neighbors: neighbors.union([gardenPlot])))
    }

    if row + 1 < entities.count, entities[row+1][column] == gardenPlot.plant {
      let plot = GardenPlot(row: row+1, column: column, plant: gardenPlot.plant)
      neighbors.formUnion(self.neighbors(gardenPlot: plot, neighbors: neighbors.union([gardenPlot])))
    }

    if row - 1 >= 0, entities[row-1][column] == gardenPlot.plant {
      let plot = GardenPlot(row: row-1, column: column, plant: gardenPlot.plant)
      neighbors.formUnion(self.neighbors(gardenPlot: plot, neighbors: neighbors.union([gardenPlot])))
    }

    return neighbors
  }
}

private struct Region: Hashable, CustomStringConvertible {
  let gardenPlots: Set<GardenPlot>
  var id: String { return UUID().uuidString }

  fileprivate var area: Int {
    return gardenPlots.count
  }

  fileprivate var fencePrice: Int {
    return area * perimeter
  }

  var description: String {
    return "\(gardenPlots.first!.plant) \(gardenPlots.count)"
  }

  /// The perimeter of a region is the number of sides of garden plots in the region that do not touch another
  /// garden plot in the same region.
  fileprivate var perimeter: Int {
    return gardenPlots.reduce(0) { partialResult, gardenPlot in

      let row = gardenPlot.row
      let column = gardenPlot.column
      let neighbors = [
        (row - 1, column),
        (row + 1, column),
        (row, column - 1),
        (row, column + 1)
      ].filter {
        let plot = GardenPlot(row: $0.0, column: $0.1, plant: gardenPlot.plant)
        return gardenPlots.contains(plot)
      }

      return partialResult + (4 - neighbors.count)
    }
  }
}

private struct GardenPlot: Hashable, CustomStringConvertible {
  let row: Int
  let column: Int
  let plant: Character

  var id: String {
    return "(\(row), \(column))"
  }
  
  var description: String {
    return id
  }
}
