//import Testing
import XCTest

@testable import AdventOfCode

/*struct*/final class Day10Tests: XCTestCase {

  // 2
//  let testData = """
//    7770777
//    7771777
//    7772777
//    6543456
//    7777777
//    8777778
//    9777779
//    """

 // 4
//  let testData = """
//    7790779
//    7771798
//    7772777
//    6543456
//    7657987
//    8767777
//    9877777
//    """


  let testData = """
    89010123
    78121874
    87430965
    96549874
    45678903
    32019012
    01329801
    10456732
    """


  /*@Test*/ func testPart1() async throws {
    let challenge = Y2024Day10(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "36")
  }

  /*@Test*/ func testPart2() async throws {    
    let testData = """
    89010123
    78121874
    87430965
    96549874
    45678903
    32019012
    01329801
    10456732
    """
    let challenge = Y2024Day10(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "81")
  }
}
