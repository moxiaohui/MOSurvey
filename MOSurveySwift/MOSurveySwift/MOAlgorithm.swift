//
//  MOAlgorithm.swift
//  SwiftDemo
//
//  Created by moxiaoyan on 2020/9/24.
//  Copyright © 2020 moxiaohui. All rights reserved.
//

import Foundation

// MARK: 链表
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

// MARK: 二叉树
public class TreeNode {
  public var val: Int
  public var left: TreeNode?
  public var right: TreeNode?
  public var isFirst: Bool // 是否第一次出现在栈顶（非递归后续遍历用到）
  public init(_ val: Int) {
    self.val = val
    self.left = nil
    self.right = nil
    self.isFirst = false
  }
}

func test() {
//  let l1 = creatList([1, 2])
//  let l2 = creatList([5])
//  let res = longestCommonPrefix(["dog","racecar","car"])
//  print(res)
  let node1 = TreeNode(1)
  let node2 = TreeNode(2)
  let node3 = TreeNode(3)
  let node4 = TreeNode(4)
  let node5 = TreeNode(5)
  let node6 = TreeNode(6)
  let node7 = TreeNode(7)
  let node8 = TreeNode(8)
  node1.left = node2
  node1.right = node3
  node2.left = node4
  node2.right = node5
  node3.right = node6
  node5.left = node7
  node5.right = node8
  postOrder(node1)
}

// MARK: 二叉树前序遍历(非递归)
func preOrder(_ root: TreeNode?) {
  var current: TreeNode? = root
  var stack: [TreeNode] = []
  while current != nil || !stack.isEmpty {
    if let cur = current {
      print(cur.val) //
      current = cur.left
      if let right = cur.right {
        stack.append(right)
      }
    } else {
      current = stack.popLast()
    }
  }
}
// MARK: 二叉树中序遍历(非递归)
func inOrder(_ root: TreeNode?) {
  var current: TreeNode? = root
  var stack: [TreeNode] = []
  while current != nil || !stack.isEmpty {
    if let cur = current {
      stack.append(cur)
      current = cur.left
    } else {
      let node: TreeNode = stack.popLast()!
      print(node.val) //
      current = node.right
    }
  }
}
// MARK: 二叉树后序遍历(非递归)
func postOrder(_ root: TreeNode?) {
  var stack: [TreeNode] = []
  var current: TreeNode? = root
  while current != nil || !stack.isEmpty {
    while let cur = current { // 沿着左子树一直往下，直到没有左子树为止
      cur.isFirst = true
      stack.append(cur)
      current = cur.left
    }
    if !stack.isEmpty {
      let node: TreeNode = stack.popLast()!
      if node.isFirst { // 第一次出现在栈顶
        node.isFirst = false
        stack.append(node)
        current = node.right
      } else { // 第二次出现在栈顶
        print(node.val)
        current = nil
      }
    }
  }
}

// MARK: 最长子串 长度
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

// MARK: 回文串
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

// MARK: 快慢指针找中间结点
func findMidNode(_ head: ListNode?) -> ListNode? {
  var slow: ListNode? = head
  var fast: ListNode? = head
  while fast?.next != nil && fast?.next?.next != nil {
    fast = fast?.next?.next
    slow = slow?.next
  }
  return slow
}

// MARK: 反转链表
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

