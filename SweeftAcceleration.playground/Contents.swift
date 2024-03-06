import Foundation

// MARK: - Longest Substring Without Repeating Characters
func lengthOfLongestSubstring(_ s: String) -> Int {
    // Variables:
    var maxLength = 0, leftIdx = 0, rightIdx = 0
    var charArray = Array(s)
    var charCountDict = [Character: Int]()
    
    // Iterating through characters:
    while rightIdx < s.count {
        let character = charArray[rightIdx]
        // Updating left index for a sliding window:
        if let lastIndex = charCountDict[character] {
            leftIdx = max(leftIdx, lastIndex + 1)
        }
        // Getting & updating maximum length of a substring:
        charCountDict[character] = rightIdx
        maxLength = max(maxLength, rightIdx - leftIdx + 1)
        rightIdx += 1
    }

    // Returning maximum length of a substring:
    return maxLength
}

// Function Calls:
lengthOfLongestSubstring("abcabcbb")
lengthOfLongestSubstring("bbbbb")


// MARK: - Minimum Window
func minWindow(_ s: String, _ t: String) -> String {
    // Considering edge case of empty strings:
    if s.isEmpty || t.isEmpty { return "" }
    
    // Iterating over characters and counting character frequencies:
    var countCharsInT = [Character: Int]()
    for char in t {
        countCharsInT[char, default: 0] += 1
    }
    
    // Variables:
    var leftPointer = 0, rightPointer = 0
    var minWindow = ""
    var minWindowLength = Int.max
    var counter = countCharsInT.count
    
    let sArray = Array(s)
    
    // Iterating over s string array:
    while rightPointer < sArray.count {
        let char = sArray[rightPointer]
        
        // Updating character counts when a character is in string t
        if let count = countCharsInT[char] {
            countCharsInT[char] = count - 1
            if countCharsInT[char] == 0 { counter -= 1 }
        }
        
        rightPointer += 1
        
        // Minimizing the window by incrementing the left pointer
        while counter == 0 {
            // Updating the minimum window substring:
            if rightPointer - leftPointer < minWindowLength {
                minWindowLength = rightPointer - leftPointer
                minWindow = String(sArray[leftPointer..<rightPointer])
            }
            
            let leftChar = sArray[leftPointer]
            
            // Restore character count after moving the left pointer:
            if let count = countCharsInT[leftChar] {
                countCharsInT[leftChar] = count + 1
                if countCharsInT[leftChar] ?? 0 > 0 {
                    counter += 1
                }
            }
            
            leftPointer += 1
        }
    }
    
    // Returning result:
    return minWindow
}

// Function Calls:
minWindow("ADOBECODEBANC", "ABC")
minWindow("a", "aa")


// MARK: - Breaking Words
func wordBreak(_ s: String, _ words: [String]) -> Bool {
    // Checking if string is breakable:
    var isBreakable = [Bool](repeating: false, count: s.count + 1)
    isBreakable[0] = true
    
    let characters = Array(s)
    let wordSet = Set(words)
    
    // Iterating over characters:
    for i in 1...s.count {
        for j in 0..<i {
            guard isBreakable[j], wordSet.contains(String(characters[j..<i])) else { continue }
            isBreakable[i] = true
            break
        }
    }
    
    // Returning result:
    return isBreakable[s.count]
}

// Function Calls:
wordBreak("leetcode", ["leet", "code"])
wordBreak("applepenapple", ["apple", "pen"])


// MARK: - Top K Frequent
func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
    // Variables:
    var frequencies = [Int: Int]()
    
    // Iterating over numbers:
    for num in nums {
        frequencies[num, default: 0] += 1
    }
    
    // Sorting and getting top K frequencies:
    let sortedFrequencies = frequencies.sorted { $0.value > $1.value }
    var topKResults = [Int]()
    for i in 0..<k {
        topKResults.append(sortedFrequencies[i].key)
    }
    
    // Returning results:
    return topKResults
}

// Function Calls:
topKFrequent([1, 1, 1, 2, 2, 3], 2)
topKFrequent([1], 1)


// MARK: - Minimum Meeting Rooms
func minMeetingRooms(_ intervals: [[Int]]) -> Int {
    // Considering edge case of empty intervals:
    if intervals.isEmpty { return 0 }
    
    // Variable for storing room number:
    var roomsNeeded = 0
    
    // Separating start and end times, and sorting them:
    let startingTimes = intervals.map { $0[0] }.sorted()
    let endingTimes = intervals.map { $0[1] }.sorted()
    
    // Creating two pointers for iterating over intervals:
    var startPointer = 0, endPointer = 0
    
    // Iterating over intervals:
    while startPointer < intervals.count {
        // If meetings can not be held in one room, roomsNeeded is incremented:
        if startingTimes[startPointer] < endingTimes[endPointer] {
            roomsNeeded += 1
            
        // In other case, endPointer is incremented
        } else {
            endPointer += 1
        }
        
        // Incrementing startPointer:
        startPointer += 1
    }
    
    // Returning number of rooms needed:
    return roomsNeeded
}

// Function Calls:
minMeetingRooms([[0, 30], [5, 10], [15, 20]])
minMeetingRooms([[7, 10], [2, 4]])
