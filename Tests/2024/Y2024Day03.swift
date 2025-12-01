//import Testing
import XCTest

@testable import AdventOfCode

/*struct*/final class Day03Tests: XCTestCase {

  /*@Test*/ func testPart1() async throws {
    let testData = """
    xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
    """
    let challenge = Y2024Day03(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "161")
  }

  /*@Test*/ func testPart2() async throws {
    let testData = """
    xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
    """
    let challenge = Y2024Day03(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "48")
  }
}
