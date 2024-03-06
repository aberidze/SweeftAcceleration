import Foundation

// MARK: - Top K Frequent
func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
    var countNumbersDict = [Int: Int]()
    for num in nums {
        if countNumbersDict[num] != nil {
            countNumbersDict[num]! += 1
        } else {
            countNumbersDict[num] = 1
        }
    }
    print(countNumbersDict)
    return []
}

print(topKFrequent([1, 1, 1, 2, 2, 3], 5))
