import Testing
@testable import AdventOfCode

struct Y2025Day09Tests {
  let testData = """
  7,1
  11,1
  11,7
  9,7
  9,5
  2,5
  2,3
  7,3
  """

  @Test func testPart1() async throws {
    let challenge = Y2025Day09(data: testData)
    #expect(challenge.part1() == 50)
  }

  @Test func testPart2() async throws {
    let challenge = Y2025Day09(data: testData)
    #expect(challenge.part2() == 24)
    // 4503451603
    
  }
}
