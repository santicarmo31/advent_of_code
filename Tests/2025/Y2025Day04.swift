import Testing
@testable import AdventOfCode

struct Y2025Day04Tests {
  let testData = """
    ..@@.@@@@.
    @@@.@.@.@@
    @@@@@.@.@@
    @.@@@@..@.
    @@.@@@@.@@
    .@@@@@@@.@
    .@.@.@.@@@
    @.@@@.@@@@
    .@@@@@@@@.
    @.@.@@@.@.
    """

  @Test func testPart1() async throws {
    let challenge = Y2025Day04(data: testData)
    #expect(challenge.part1() == 13)
  }

  @Test func testPart2() async throws {
    let challenge = Y2025Day04(data: testData)
    #expect(challenge.part2() == 43)
  }
}
