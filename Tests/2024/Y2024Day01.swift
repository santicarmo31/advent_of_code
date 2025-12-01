//import Testing
import XCTest

@testable import AdventOfCode

/*struct*/final class Day01Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
    5   6
    1   4
    """

  /*@Test*/ func testPart1() async throws {
    let expectedValues = "[[1, 5], [4, 6]]"
    let challenge = Y2024Day01(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), expectedValues)
  }

  /*@Test*/ func testPart2() async throws {
    let challenge = Y2024Day01(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "0")
//        #expect(String(describing: challenge.part2()) == "32000")
  }
}
