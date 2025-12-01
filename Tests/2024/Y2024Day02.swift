//import Testing
import XCTest

@testable import AdventOfCode

/*struct*/final class Day02Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 9 7
    8 9 6 4 1
    6 4 9 3 1
    8 7 6 9 5
    8 7 6 5 8
    8 8 6 5 3
    8 7 6 6 3
    """

  /*@Test*/ func testPart1() async throws {
    let challenge = Y2024Day02(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "1")
  }

  /*@Test*/ func testPart2() async throws {
    let challenge = Y2024Day02(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "10")
    //        #expect(String(describing: challenge.part2()) == "32000")
  }
}
