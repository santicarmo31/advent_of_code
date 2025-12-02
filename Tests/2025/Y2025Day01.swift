import Testing
@testable import AdventOfCode

struct Y2025Day01Tests {
  let testData = """
    L68
    L30
    R48
    L5
    R60
    L55
    L1
    L99
    R14
    L82
    """
  let testData2 = """
    R1000
    """

  @Test func testPart1() async throws {
    let challenge = Y2025Day01(data: testData)
    #expect(challenge.part1() == 3)
  }

  @Test func testPart2() async throws {
    let challenge = Y2025Day01(data: testData)
    #expect(challenge.part2() == 6)

    let challenge2 = Y2025Day01(data: testData2)
    #expect(challenge2.part2() == 10)
  }
}
