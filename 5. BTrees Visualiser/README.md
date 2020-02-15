# B Tree Visualisation Software

## Introduction 
B-Tree should be familiar to most of college students who take Computer Science as their study major.  Its original purpose is to reduce the time being spent in computer hard drive by minimizing storage I/O operations as much as possible.  The technique has served very well in computer fields such as database and file system. 

## Requirements
* JDK 6+ is required to build the core B-Tree and all of its test cases
* JDK 8 is required if you would like to build B-Tree rendering tool that uses JGraphX

## Algorithms and Pseudo Codes

### Key Searching 

  Current-Processed-Node = Root-Node

    While (Current-Processed-Node is not NULL)
        Current-Index = 0

        While ((Current-Index < key number of Current-Processed-Node) AND
                (searched-key > Current-Processed-Node.Keys[Current-Index]))
            Current-Index++
        End While


        If ((Current-Index < key number of Current-Processed-Node) AND
             (searched-key == Current-Processed-Node.Keys[Current-Index]))
            searched-key is found
            Return it (We are done)

        End If

        Current-Processed-Node = Left/Right Child of Current-Processed-Node
    End While

    Return NULL

    
### Key Insertion
    
Key-Search (searched-key)
    Split-Node(parent-node, splitted-node)

    Create new-node
    Leaf[new-node] = Leaf[splitted-node]  (The new node must have the same leaf info)

    Copy right half of the keys from splitted-node to the new node

    If (Leaf[splitted-node] is FALSE) Then
        Copy right half of the child pointers from spitted-node to the new node
    End If

    Move some of parent children to the right accordingly

    parent-node.children[relevant index] = new-node

    Move some of parent keys to the right accordingly as well

    Parent-node.keys[relevant index] = splitted-node.keys[the right-most index]

Insert-Key-To-Node(current-node, inserted-key)

    If (Leaf[current-node] == TRUE) Then
        Put inserted-key in the node in ascending order
        Return (We are done)
    End If

    Find the child-node where inserted-key belong

    If (total number of keys in child-node == UPPER BOUND) Then
        Split-Node(current-node, child-node)
        Return Insert-Key-To-Node(current-node, inserted-key)
    End If

    Insert-Key-To-Node(child-node, inserted-key)

Insert-Key(inserted-key)

    If (root-node is NULL) Then
        Allocate for root-node
        Leaf[root-node] = TRUE
    End If


    If (total number of keys in root-node == UPPER BOUND) Then
        Create a new-node
        Assign root-node to be the child pointer of the new-node
        Assign new-node to be the root-node
        Split-Node(new-node, new-node.children[0])
    End If

    Insert-Key-To-Node(new-node, inserted-key)
    
### Key Deletion

Delete-Key-From-Node(parent-node, current-node, deleted-key)

    If (Leaf[current-node] == TRUE) Then
        Search for deleted-key in current-node

        If (deleted-key not found) Then
            Return (We are done)
        End If

        If (total number of keys in current-node > LOWER BOUND) Then
            Remove the key in current-node
            Return (We are done)
        End If

        Get left-sibling-node and right-sibling-node of current-node

        If (left-sibling-node is found AND total number of keys in left-sibling-node > LOWER BOUND) Then
            Remove deleted-key from current-node
            Perform right rotation
            Return (We are done)
        End If

        If (right-sibling-node is found AND total number of keys in right-sibling-node > LOWER BOUND) Then
            Remove deleted-key from current-node
            Perform left rotation
            Return (We are done)
        End If

        If (left-sibling-node is not NULL) Then
            Merge current-node with left-sibling-node
        Else
            Merge current-node with right-sibling-node
        End If

        Return Rebalance-BTree-Upward(current-node)
    End If

    Find predecessor-node of current-node

    Swap the right-most key of predecessor-node and deleted-key of current-node

    Delete-Key-From-Node(predecessor-parent-node, predecessor-node, deleted-key)
Hide   Copy Code
Rebalance-BTree-Upward(current-node)

    Create Stack

    For each step of the path from root-node to current-node Then
        Stack.push(step-node)
    End For

    While (Stack is not empty) Then
        step-node = Stack.pop()
        If (total number of keys in step-node < LOWER BOUND) Then
            Rebalance-BTree-At-Node(step-node)
        Else
            Return (We are done)
        End If
    End While

Rebalance-BTree-At-Node(step-node)

    If (step-node is NULL OR step-node is root-node) Then
        Return (We are done)
    End If

    Get left-sibling-node and right-sibling-node of step-node

    If (left-sibling-node is found AND total number of keys in left-sibling-node > LOWER BOUND) Then
        Remove deleted-key from step-node
        Perform right rotation
        Return (We are done)
    End If

    If (right-sibling-node is found AND total number of keys in right-sibling-node > LOWER BOUND) Then
        Remove deleted-key from step-node
        Perform left rotation
        Return (We are done)
    End If

    If (left-sibling-node is not NULL) Then
        Merge step-node with left-sibling-node
    Else
        Merge step-node with right-sibling-node
    End If

Delete-Key(deleted-key)

    Delete-Key-From-Node(NULL, root-node, deleted-key)
    
## Using the code
* Open the project using an IDE and run 'BTreeRenderer.java' in `src.org.apache.dts` directory
* Alternatively you can run it on terminal from the out/test/jdstructs folder by typing the following command -
`java org.apache.dts.BTreeRenderer`
 

Built with ♥ by Pratyush Pandey.
