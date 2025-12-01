//import Testing
import XCTest

@testable import AdventOfCode

/*struct*/final class Day11Tests: XCTestCase {
  /*@Test*/ func testPart1() async throws {
    let testData = """
    125 17
    """
    
    let challenge = Y2024Day11(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "55312")
  }

  /*@Test*/ func testPart2() async throws {
    let testData = """
    125 17
    """
    let challenge = Y2024Day11(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "65601038650482")
  }
}
