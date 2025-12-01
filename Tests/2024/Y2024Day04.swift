//import Testing
import XCTest

@testable import AdventOfCode

/*struct*/final class Day04Tests: XCTestCase {

  /*@Test*/ func testPart1() async throws {
    let testData = """
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
    """
    let challenge = Y2024Day04(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "18")
  }

  /*@Test*/ func testPart2() async throws {
    let testData = """
    .M.S......
    ..A..MSMS.
    .M.S.MAA..
    ..A.ASMSM.
    .M.S.M....
    ..........
    S.S.S.S.S.
    .A.A.A.A..
    M.M.M.M.M.
    ..........
    """
    let challenge = Y2024Day04(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "9")
  }
}
