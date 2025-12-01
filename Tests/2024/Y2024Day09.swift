//import Testing
import XCTest

@testable import AdventOfCode

/*struct*/final class Day09Tests: XCTestCase {

  let testData = """
    2333133121414131402
    """

  /*@Test*/ func testPart1() async throws {
    let challenge = Y2024Day09(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "1928")
  }

  /*@Test*/ func testPart2() async throws {
    let challenge = Y2024Day09(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "2858")
  }
}
