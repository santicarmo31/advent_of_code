import Foundation
import Algorithms

struct Y2025Day09: AdventDay {
  var data: String

  private var entities: [Tile] {
    data.split(separator: "\n").map {
      let components = String($0).split(separator: ",")
      guard components.count == 2,
            let y = Int(components[0]),
            let x = Int(components[1]) else {
        fatalError()
      }
      return Tile(x: x, y: y)
    }
  }

  func part1() -> Int {
    entities.combinations(ofCount: 2).map {
      let distanceX = abs($0[0].x - $0[1].x) + 1
      let distanceY = abs($0[0].y - $0[1].y) + 1
      return distanceX * distanceY
    }
    .max() ?? 0
  }

  func part2() -> Int {
    let vertices = entities
    let vertexCount = vertices.count
    guard vertexCount >= 2 else { return 0 }

    // Build polygon edges (each red tile connected to the next, wrapping around).
    let edges: [(Tile, Tile)] = (0..<vertexCount).map { index in
      let start = vertices[index]
      let end = vertices[(index + 1) % vertexCount]
      return (start, end)
    }

    var bestArea = 0

    // Try every pair of red tiles as opposite corners of a candidate rectangle.
    for firstIndex in 0..<vertexCount {
      for secondIndex in (firstIndex + 1)..<vertexCount {
        let firstTile = vertices[firstIndex]
        let secondTile = vertices[secondIndex]

        let minX = min(firstTile.x, secondTile.x)
        let maxX = max(firstTile.x, secondTile.x)
        let minY = min(firstTile.y, secondTile.y)
        let maxY = max(firstTile.y, secondTile.y)

        // Inclusive area (same as part 1).
        let width = maxX - minX + 1
        let height = maxY - minY + 1
        let area = width * height

        // Tiny optimization: skip if area can't beat best so far.
        guard area > bestArea else { continue }

        // 1. Reject if any red tile lies STRICTLY inside the rectangle.
        //    (Corners and edges are OK.)
        var hasInnerRedTile = false
        for tile in vertices {
          if minX < tile.x && tile.x < maxX && minY < tile.y && tile.y < maxY {
            hasInnerRedTile = true
            break
          }
        }
        if hasInnerRedTile {
          continue
        }

        // 2. Reject if any polygon edge "cuts through" the rectangle
        //    according to an AABB-style collision test.
        if rectangleCollidesWithAnyEdge(
          minX: minX,
          maxX: maxX,
          minY: minY,
          maxY: maxY,
          edges: edges
        ) {
          continue
        }

        // If we get here, this rectangle is considered valid for THIS
        // problem's input. Keep the best area.
        bestArea = area
      }
    }

    return bestArea
  }

  private func rectangleCollidesWithAnyEdge(
    minX: Int,
    maxX: Int,
    minY: Int,
    maxY: Int,
    edges: [(Tile, Tile)]
  ) -> Bool {
    for (start, end) in edges {
      if edgeAABBCollidesWithRectangle(
        edgeStart: start,
        edgeEnd: end,
        rectMinX: minX,
        rectMaxX: maxX,
        rectMinY: minY,
        rectMaxY: maxY
      ) {
        return true
      }
    }
    return false
  }

  /// AABB-style collision test between a (horizontal or vertical) edge and
  /// the candidate rectangle.
  ///
  /// IMPORTANT:
  /// - We treat **strict interior overlap** as collision.
  /// - Pure boundary touching (sharing only edges or corners) is allowed.
  private func edgeAABBCollidesWithRectangle(
    edgeStart: Tile,
    edgeEnd: Tile,
    rectMinX: Int,
    rectMaxX: Int,
    rectMinY: Int,
    rectMaxY: Int
  ) -> Bool {
    // Build the edge's bounding box.
    let edgeMinX = min(edgeStart.x, edgeEnd.x)
    let edgeMaxX = max(edgeStart.x, edgeEnd.x)
    let edgeMinY = min(edgeStart.y, edgeEnd.y)
    let edgeMaxY = max(edgeStart.y, edgeEnd.y)

    // We want to know if there is an overlap in the **interior** of the rectangle.
    //
    // So we shrink the rectangle by 1 in each direction for the interior test.
    // That way, a rectangle that just "hugs" the border won't be seen as colliding.
    //
    // Example: rectMinX=2, rectMaxX=5
    //   interiorX: 3 ..< 5   (tiles strictly inside horizontally)
    let interiorMinX = rectMinX + 1
    let interiorMaxX = rectMaxX - 1
    let interiorMinY = rectMinY + 1
    let interiorMaxY = rectMaxY - 1

    // If the rectangle is only 1 cell wide or tall, there is no interior
    // to speak of, so it can't be "cut through" – only share borders.
    if interiorMinX > interiorMaxX || interiorMinY > interiorMaxY {
      return false
    }

    // Classic AABB overlap check, but using the *interior* box instead of the full rect.
    let separatedHorizontally = interiorMaxX < edgeMinX || interiorMinX > edgeMaxX
    let separatedVertically = interiorMaxY < edgeMinY || interiorMinY > edgeMaxY

    return !(separatedHorizontally || separatedVertically)
  }

  private struct Tile: Hashable, CustomStringConvertible {
    var description: String { "(\(x), \(y))" }

    let x: Int
    let y: Int
  }
}
