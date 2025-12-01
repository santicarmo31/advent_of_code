//import Testing
import XCTest

@testable import AdventOfCode

/*struct*/final class Day06Tests: XCTestCase {

  let testData = """
    ....#.....
    .........#
    ..........
    ..#.......
    .......#..
    ..........
    .#..^.....
    ........#.
    #.........
    ......#...
    """

  /*@Test*/ func testPart1() async throws {
    let challenge = Y2024Day06(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "41")
  }

  /*@Test*/ func testPart2() async throws {
    let challenge = Y2024Day06(data: testData)
    try XCTAssertEqual(String(describing: challenge.part2()), "6")
  }
}
