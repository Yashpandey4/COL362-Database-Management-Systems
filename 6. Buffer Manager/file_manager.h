/* header file for file_manager */
/* Actual cpp library API that will be visible to students */

#ifndef FILE_MANAGER_H
#define FILE_MANAGER_H

#include "constants.h"

class BufferManager;
class StatsManager;

// Page header as stored along with page contents in each page - page = page header + page contents
struct PageHdr {
    int nextFreePage;       // nextFreePage can be any of these values:
                        //  - the number of the next free page
                        //  - END_FREE if this is last free page
                        //  - NOT_FREE if the page is not free
};


//define Page Handler class
//includes function to access data stored in page
//File handler objects return a page handler for the required page

class PageHandler {
   friend class FileHandler;
public:
   PageHandler();       
   PageHandler(int,char *);                     
   PageHandler(const PageHandler &pageHandle);
   bool operator==(const PageHandler &pageHandle);
   char* GetData(); //return character pointer to the data in page
   int GetPageNum(); // Return the page number
private:
   int  pageNum; // page number
   char *data;  // pointer to page data
};


// File header structure 
// stored at the start of file

struct FileHdr {
   int firstFreePage; // first free page in the free page linked list, i.e. head of free page linked list
   int totalPages; // total number of pages in the file, including freed pages
};


//define File handler class
//includes functions to get page access in file
//for both reading and allocating pages in file

class FileHandler {
   friend class FileManager;
public:
   FileHandler();                            // Default constructor
   // Copy constructor
   FileHandler(const FileHandler &fileHandle);
   bool operator==(const FileHandler &fileHandle);
   // Get the first page
   PageHandler FirstPage();
   // Get the next page after current
   PageHandler NextPage(int page_number);
   // Get a specific page
   PageHandler PageAt(int page_number);
   // Get the last page
   PageHandler LastPage();
   // Get the prev page after current
   PageHandler PrevPage(int page_number);

   PageHandler NewPage();    // Allocate a new page
   bool DisposePage (int pageNum);              // Dispose off a page
   bool MarkDirty(int pageNum);        // Mark page as dirty
   bool UnpinPage(int pageNum);        // Unpin the page

   // Flush pages from buffer pool.  Will write dirty pages to disk.
   bool FlushPages();

   // Force a page or pages to disk (but do not remove from the buffer pool)
   bool FlushPage(int page_number);

private:
   // helper function to check if page number is valid
   bool checkPageValid(int page_number);
   BufferManager *bufferManager;                      // pointer to buffer manager
   FileHdr hdr;                                // file header
   bool isOpen;                                 // file open flag
   bool hdrChanged;                               // dirty flag for file hdr
   int unix_file_desc;                                    // OS file descriptor
   char* fileName;
};

// hack to keep instance count of FileManager class
extern int FileManagerInstanceCount;
class FileManager {
public:
   FileManager();                              // Constructor
   ~FileManager();                              // Destructor
   FileHandler CreateFile(const char *fileName);       // Create a new file and return a File handler
   bool DestroyFile(const char *fileName);       // Delete a file

   // Open and close file methods
   FileHandler OpenFile(const char *fileName);
   bool CloseFile(FileHandler &fileHandle);

   void ClearBuffer();
   void PrintBuffer();
private:
   BufferManager *bufferManager;                      // page-buffer manager
};

#endif
