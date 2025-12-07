import Testing
@testable import AdventOfCode

struct Y2025Day06Tests {
  let testData = """
  123 328  51 64 
   45 64  387 23 
    6 98  215 314
  *   +   *   +  
  """

  @Test func testPart1() async throws {
    let challenge = Y2025Day06(data: testData)
    #expect(challenge.part1() == 4277556)
  }

  @Test func testPart2() async throws {
    let challenge = Y2025Day06(data: testData)
    #expect(challenge.part2() == 3263827)
  }
}
