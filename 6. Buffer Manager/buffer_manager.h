/* Header file for buffer manager implementation */
#ifndef BUFFER_MANAGER_H
#define BUFFER_MANAGER_H

#include "constants.h"
#include "file_manager.h"
#include <unordered_map>
#include <list>
using namespace std;


/* This is only going to be used in the Frame class
 Each frame consists of a FileDescriptor and contents of the page
*/
struct PageDescriptor {
int fd;
int pagenum;
PageDescriptor() {
	fd = pagenum = -1;
}
PageDescriptor(int f,int pno) {
	this->fd = f;
	this->pagenum = pno;
}
inline bool operator==(const PageDescriptor& pd1) const { return (pd1.fd == fd && pd1.pagenum == pagenum); }
inline PageDescriptor& operator=(const PageDescriptor &pd1) { fd = pd1.fd; pagenum = pd1.pagenum; return *this;}
};

namespace std {
	// hash function for PageDescriptors
	template <>
  struct hash<PageDescriptor> {
    size_t operator()(const PageDescriptor& pd) const {
      return hash<int>()(pd.fd) ^ hash<int>()(pd.pagenum);
    }
  };
}

// information structure describing Frame information and actual page data
struct Frame {
    bool dirty;
    bool pinned;
    PageDescriptor pageDescriptor;
    char *data;
  };

class BufferManager {

	public : 
	BufferManager(int num_pages); // constructor
	~BufferManager(); //destructor
	char* GetPage(PageDescriptor pd); // get page contents (including header)
	char* AllocatePage(PageDescriptor pd); // allocate a page
	bool MarkDirty(PageDescriptor pd); // mark a page as dirty
	bool UnpinPage(PageDescriptor pd); // unpin the page in buffer
	bool FlushPages(int fd); // flush all pages for file fd
	bool FlushPage(PageDescriptor pd); // flush individual page
	void ClearBuffer(); // remove all pages from buffer 
	void PrintBuffer(); // print the contents of pages in buffer

private:
	list<int> freeList; // list of free slots
	list<int> usedList; // list of used slots
	Frame *buffers; //storage area for buffered pages
	int numPages;
	int pageSize;
	unordered_map<PageDescriptor,int> hashTable;
	int FindSlot(); // find a free slot and return it 
	bool ReadPage(PageDescriptor pd, char *dest ); // read the page from file into and store it in dest
	bool WritePage(PageDescriptor pd, char *data); //write page data to the file
	void InitializeBuffer(PageDescriptor pd,int slot_no); // helper code to initialize Buffer Frame elements
};

#endif