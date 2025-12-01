//import Testing
import XCTest

@testable import AdventOfCode

/*struct*/final class Day12Tests: XCTestCase {
  /*@Test*/ func testPart1() async throws {
    let testData = """
    RRRRIICCFF
    RRRRIICCCF
    VVRRRCCFFF
    VVRCCCJFFF
    VVVVCJJCFE
    VVIVCCJJEE
    VVIIICJJEE
    MIIIIIJJEE
    MIIISIJEEE
    MMMISSJEEE
    """

    let challenge = Day12(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "1930")
  }

  /*@Test*/ func testPart2() async throws {
    let testData = """
    RRRRIICCFF
    RRRRIICCCF
    VVRRRCCFFF
    VVRCCCJFFF
    VVVVCJJCFE
    VVIVCCJJEE
    VVIIICJJEE
    MIIIIIJJEE
    MIIISIJEEE
    MMMISSJEEE
    """
    let challenge = Day12(data: testData)
    XCTAssertEqual(String(describing: try challenge.part2()), "1206")
  }
}
