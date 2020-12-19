//
//  MOAlgorithm.swift
//  SwiftDemo
//
//  Created by moxiaoyan on 2020/9/24.
//  Copyright © 2020 moxiaohui. All rights reserved.
//

import Foundation

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

func test() {
//  let l1 = creatList([1, 2])
//  let l2 = creatList([5])
//  let res = longestCommonPrefix(["dog","racecar","car"])
//  print(res)
}


func lengthOfLongestSubstring(_ s: String) -> Int {
  if s.isEmpty {
    return 0
  }
  var maxStr = String()
  var curStr = String()
  for char in s {
    while curStr.contains(char) {
      curStr.remove(at: curStr.startIndex)
    }
    curStr.append(char)
    if curStr.count > maxStr.count {
      maxStr = curStr
    }
  }
  return maxStr.count
}

func isPalindrome(_ head: ListNode?) -> Bool {
  if head == nil {
    return true
  }
  let midNode: ListNode? = findMidNode(head)
  let lastHalfHead: ListNode? = reversedLink(midNode?.next) ?? nil
  var link1: ListNode? = head
  var link2: ListNode? = lastHalfHead
  
  var res: Bool = true
  while res && link2 != nil {
    if link1?.val == link2?.val {
      link1 = link1?.next
      link2 = link2?.next
    } else {
      res = false
    }
  }
  return res
}
// 快慢指针找中间结点
func findMidNode(_ head: ListNode?) -> ListNode? {
  var slow: ListNode? = head
  var fast: ListNode? = head
  while fast?.next != nil && fast?.next?.next != nil {
    fast = fast?.next?.next
    slow = slow?.next
  }
  return slow
}
// 反转链表
func reversedLink(_ head: ListNode?) -> ListNode? {
  var cur: ListNode? = head
  var pre: ListNode? = nil
  while cur != nil {
    let tmp = cur?.next
    cur?.next = pre
    pre = cur
    cur = tmp
  }
  return pre
}

fileprivate func creatList(_ nums: [Int]) -> ListNode? {
  if nums.isEmpty {
    return nil
  }
  var current: ListNode? = nil
  var res: ListNode? = nil
  for value in nums {
    if current == nil {
      current = ListNode(value)
      res = current
    } else {
      current?.next = ListNode(value)
      current = current?.next
    }
  }
  return res
}

