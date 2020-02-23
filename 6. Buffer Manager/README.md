# COL362632_Project2

- Code
	+ Keep all your C++ source files inside the home directory.
	+ You are supposed to use the functions mentioned in file_manager.h. Read documentation.txt for details of what each function does.
	+ Go through sample_run.cpp to get an idea of how to use the file manager.
	+ The whole source code has been shared with you for your debugging purposes and if you wish to compile in a different environment.

- Testcases
	+ Sample test files have been added to testcases directory. Read the README.txt for details on the testcases.

- Note
	+ Please don't try any funny business like by-passing the file_manager or storing the complete (large) file in your own memory. The file manager we provided must be used for every access to file.
	
# Project 2

## Due date: April 15, 2019, 11:55pm IST

## 1 Introduction

In this project, you will implement three different functions on top of the buffer manager provided to you.

```
1.Binary search: Given an integer, find whether the integer is present in the file using binary search.
```
```
2.Insertion: Given an integer, insert the integer into the file, while maintaining sorted order of integers
in the file.
```
```
3.Merge sort: Given an unsorted file of integers, perform merge sort and create a new file that contains
the integers in sorted order.
```
While all of you would have studied and implemented these algorithms in your data structures course,
the key differences between the implementation your are being asked to do now are the following:

- You can no longer assume that your data is in memory.
- Access to the data is only through a very specific API, provided to you by our implementation of a
    buffer manager.

## 1.1 Configuration

```
1.g++ compiler version:8.2.1. Requires C++ 11 standard.
```
2. We have tested on: Ubuntu 16.04 LTS
3. Your code should correctly compile and run on: Ubuntu 16.04 LTS
4. Only the standard C++ libraries (including STL) are allowed.

## 2 File Manager

The buffer manager implementation is available athttps://git.iitd.ac.in/cs5150292/COL362632_Project2.
It consists of two main files:buffermanager.h/cppandfilemanager.h/cppalong with a bunch of sup-
porting functions in various other files (look at the documentation for details). In this Section, we will briefly
describe the functionality provided in thefilemanager.
Important note: Your access to the data file issolelythrough the functions provided by thefilemanager.
Do notdirectly use any functions frombuffermanager. Some useful constants are defined the fileconstants.h.

## 2.1 Structure of the data file

Since we have not implemented a separate record manager, it is up to you to implement one if you like. Note
that the only record type we have is integers. The way in which integers are stored are shown in Figure 2.1.
The contents of a page are defined by the following parameters:

```
1.Size of the page: The constantPAGECONTENTSIZEdefined inconstants.h.
```

```
Size of an 4 bytes
int
```
### INT_MIN

```
Empty
```
### INT_MIN

```
Contents of
Page 2
```
```
Contents of
Page 1
```
```
Figure 1: Two pages of size 20B, containing 3 integers (including INTMIN), with occupancy fraction 0.
```
```
2.Occupancy fraction: Occupancy fraction decides how much of a page is occupied and how much is
left empty^1. By default, this is 1, which means that all available space is packed with integers.
```
Further, any file that is supplied as a test case or that you create as the output of your code has to strictly
adhere to the following format.

1. Integers occupysizeof(int)space. This is typically 4 bytes in most systems.
2. Integers are always packed from the beginning of the page. Therefore, the empty space is contiguous
    and starts after the last integer in the page until the end of the page.
3. There is no header in the page that tells you where to find the free space. Instead, the last integer in
    the page is indicated by the constantINTMIN(the minimum integer expressible in the system). That
    is, the integer that occurs just beforeINTMINis the last integer in the data that is stored in this page.
4. Only the last page in the file may have less integers than what the occupancy fraction specifies.
5. The number of integers per pageincludesINTMIN.
6. Your algorithmswill notneed to maintain any occupancy requirements.

## 3 File manager API

A typical usage of the file manager API can be found insamplerun.cpp. Please pay attention to how integers
are stored and retrieved from a page, since the same procedure has to be followed in order to generate output
files from your programs. Alternate ways of storing integers will result in erroneous reads from our testing
software.

1. Go through the File Manager API in detail and understand the use of functions such asMarkDirty()
    andUnpinPage(). These functions are essential to ensure that the buffer manager is able to evict pages
    to make way for new ones. Note that a page that is read is automatically pinned.
2. Go through theerrors.hfile to understand what kind of errors may be thrown.Do not make changes
    to this file.But you may need to make use of these errors in your owntry-catchblocks.
3. Go through theconstants.hfile. The two main constants that are of interest here areBUFFERSIZE
    which denotes the number of buffers available in memory andPAGESIZEwhich in turn determines the
    PAGECONTENTSIZE. All these constants may be change to test your code.

(^1) Recall that a B+-tree typically leaves a part of its nodes empty. We are trying to emulate a similar behaviour.


## 4 Binary Search

The binary search algorithm proceeds in the well-known way. However, recall that in database systems, we
do not accesselements, we accesspages. Therefore, binary search will access themiddle page, then either
access a page to the left or a page to the right. The process repeats until the element is found or not found.
Once the page is accessed, the computation is now in-memory.No restrictions are placed on in-memory
computations. Therefore, you are free to choose your own data structures or functions to perform the in-
memory operations.
Note: It isnot acceptableto simply read all the pages into memory and perform a binary search on
it. You are required to perform binary searchon disk. Our testing software will keep track of your access
patterns, and a sequential access to all blocks is easily detected.

```
Algorithm 1:Binary Search on disk
Input :A file accessible through the File Manager API containing the sorted integers,num, the
integer to search for
Output:(Page number, offset) containing the integer if present, else, (-1,-1)
1 mid=f loor((lastP ageN umber+f irstP ageN umber)/2)
2 Read pagemidinto the buffer
3 ifnumis present inmidthen
4 output (mid, offset at whichnumis present)
5 end
6 else
7 determine ifnumis present in pages to the left ofmidor the right ofmid
8 repeat the procedure by updating either thelastP ageN umberor thef irstP ageN umber
9 end
```
## 5 Insertion

The insertion algorithm is provided a file of sorted integers and a new integer or set of integers to insert.
The insertion should be asortedinsertion. That is, the file remains sorted after the insertion.
Algorithm 2 shows how the insertion should proceed. Your code will be tested with both single insertions
as well as multiple insertions at a time. Therefore, you have opportunities to optimize your code for the
latter^2.
Note:It is not acceptable to use linear search to find the relevant page. Further, no occupancy restrictions
are enforced. That is, while the initial input file may have an occupancy factor<1, the file resulting from
multiple insertions will not need to adhere to any such constraints.However, note that the final file cannot

(^2) Recall that “optimize” in this scenario means reducing the number of disk reads and writes


have a page with occupancyless thanthe initial file.

```
Algorithm 2:Insertion
Input :A file accessible through the File Manager API containing sorted integers into which integers
are to be inserted, a file accessible through the API that contains the integers to be inserted
Output:None
1 // Note : below steps are only for inserting single integer into file
2 Use a modification of Algorithm 1 to locate the pagepwherenumshould be inserted
3 repeat
4 ifthere is space in thepthen
5 // Note: Ensure that the file correctly follows the structure explained in
Section 2.
6 insertnumin the correct offset in pagep(use in memory operations)
7 break
8 end
9 else
10 // sincenum is to be inserted in pageponly
11 // we will shift the last integer integer in pto next page(if exists)
12 lastnum= last integer in pagep
13 eraselastnum
14 insertnumin the correct offset in pagep(use in memory operations)
15 // shiftinglastnumto pagep+ 1 is same as inserting it in next page
16 ifpagep+ 1existsthen
17 repeat loop withp=p+ 1 andnum=lastnum
18 end
19 else
20 create pagep+ 1 at end of file
21 writelastnumin pagep+ 1 (addIN TM INat end)
22 break
23 end
24 end
25 untilnumis inserted;
```
## 6 Merge Sort

For merge sort, we will follow the algorithm provided in Section 12.4 of the textbook by Silberschatz et. al.
The following is a reproduction of the algorithm with a few modifications. Algorithms 3 and 4 together show
how the external merge sort algorithm should be implemented.

```
Algorithm 3:Creating sorted runs
Input :A file accessible through the File Manager API, containing the integers
Output:A set of run filesRi, each of which are sorted and accessible through the File Manager API
1 // Note: The output file can have any occupancy
2 // Assumptions: No. of buffers available = B
3 i= 0;
4 repeat
5 // Reserve 1 frame of the buffer for the output file
6 readB−1 blocks of integers (or the remaining set of integers) into the buffer;
7 sort the integers;
8 write the sorted data to fileRi, one block at a time;
9 i=i+ 1
10 untiluntil no more blocks are available in the input file;
```

```
Algorithm 4:Merging the sorted runs
Input :The list of run files
Output:A file accessible through the File Manager API, containing the sorted integers
1 // Note: The output filemust have occupancy 1
2 ifNo. of buffers available = B, no. of run filesN < Bthen
3 read one block of each of theNfilesRiinto the buffer
4 repeat
5 // Reserve at least 1 frame of the buffer for the output file
6 choose the first integer (in sort order) among all frames
7 write the integer to the output buffer, delete it from the frame
8 ifthe frame is emptyand notend-of-file (Ri)then
9 read the next block ofRiinto the frame
10 end
11 untiluntil all buffer blocks are empty;
12 end
13 else
14 // You will have to work out the caseN >= Byourself
15 end
```
## 7 Submission details

#### 7.1 Submission format

You will need to submit a zip file containing your code namedentrynumber1entrynumber2entrynumber3.zip
(e.g. 2017MCS00012017MCS00022017MCS0003.zip ).

1. The zip file shall create a folder with same name.
2. The folder shall only contain your code(and not the buffer manager files). We will add buffer manager
    code to it during evaluation.
3. The folder shall contain aMakefile. The Makefile will be used to compile your code.

The Makefile will be used to compile your code with the following fixed targets. The executable for each
program should have the same name as the targets given below -

1. Binary Search -make binarysearch
2. Insertion -make insertion
3. Merge sort -make mergesort

Your Makefile should also contain ”clean” target for cleaning up compiled binaries. Our format checker
will check whether your submission follows the above format or not at submission time.

#### 7.2 Program execution

1. Binary Search
    Your compiled submission file will be run as -

```
./binarysearch filename integertosearch
```
```
As specified in Algorithm 1, your program shall print (Page number,offset) to standard output if
integertosearchis present infilenamefile, otherwise (-1,-1). Note both page number and offset
start from 1.
E.g., ifintegertosearchis present as 16th integer in 4th page offilename, you have to print
```

##### 4,

```
If integer is not found, print
-1,-
```
2. Insertion
    Your compiled submission file will be run as -

```
./insertion sortedinputfile inputintegerfile
```
```
For each integer ininputintegerfile, your program shall insert it in correct place insortedinputfile.
Note you do not need to print anything to standard output for this program.
```
3. Merge sort
    Your compiled submission file will be run as -

```
./mergesort inputunsortedfile outputsortedfile
```
```
Your program shall sort the integers present ininputunsortedfilefile and write them tooutputsortedfile.
Note you don’t need to output anything to the standard output for this program.
```
A submission VPL activity will be available on Moodle (details will be updated on Piazza later). You
will receive a feedback regarding whether the submission conforms to the above submission format. Note -
A successful submission shall not mean it is correct - your submission will be evaluated after the submission
deadline is over.


