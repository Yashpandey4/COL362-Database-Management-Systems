/* implementation of buffer manager interface */

#include <unistd.h>
#include <iostream>
#include "buffer_manager.h"
#include "errors.h"
#include <algorithm>
#include <cstdio>
#include <fcntl.h>
#include <cstring>
#include <cstdlib>

//constructor(default)
BufferManager::BufferManager(int num_buffers) {
	this->numPages = num_buffers;
	this->pageSize = PAGE_SIZE;
	this->buffers = new Frame[num_buffers];
	for(int i=0;i<num_buffers;i++) {
		buffers[i].data = new char[this->pageSize];
		freeList.push_back(i);
	}
}

//destructor(default)
BufferManager::~BufferManager() {
	//free up allocated memory
	for(int i=0;i<this->numPages;i++) 
		delete buffers[i].data;
	delete this->buffers;
	freeList.clear();
	usedList.clear();
	hashTable.clear();
}


char* BufferManager::GetPage(PageDescriptor pd) {
	auto slot = hashTable.find(pd);
	if(slot!=hashTable.end()) {
		//already in buffer 
		int slotNo = slot->second;
		// no need to read the page
		// to establish replacement policy, make page MRU 
		usedList.remove(slotNo); 
		usedList.push_front(slotNo); // put at front
		return buffers[slotNo].data;
	}
	else {
		// page not in buffers
		// find a suitable slot to load it
		int slotNo = FindSlot();
		if(slotNo==-1) throw NoBufferSpaceException (); //error no free slot could be obtained 
		// read data to the slot 
		bool _read_res = ReadPage(pd,buffers[slotNo].data);
		if(!_read_res) // read failed 
			throw BufferManagerException("BufferManagerException : Read request failed");
		// insert into hashTable the corresponding slot
		hashTable.insert(make_pair(pd,slotNo));
		// initialize the rest of Frame elements
		InitializeBuffer(pd,slotNo);
		return buffers[slotNo].data;
	}

}
//allocate a new page in buffers
//since new page, no contents in file
//rest same as GetPage
char* BufferManager::AllocatePage(PageDescriptor pd) {
	auto slot = hashTable.find(pd);
	if(slot!=hashTable.end()) {
		// error page already in buffers
		throw BufferManagerException("BufferManagerException : Page to be allocated already in buffer");
	}
	else {
		// page not in buffers
		// find a suitable slot to load it
		int slotNo = FindSlot();
		if (slotNo==-1) throw NoBufferSpaceException(); //error no free slot could be obtained 
		// insert into hashTable the corresponding slot
		hashTable.insert(make_pair(pd,slotNo));
		// initialize the rest of Frame elements
		InitializeBuffer(pd,slotNo);
		return buffers[slotNo].data;
	}
}

// mark the page in buffer as dirty
bool BufferManager::MarkDirty(PageDescriptor pd) {
	auto slot = hashTable.find(pd);
	if(slot==hashTable.end()) {
		//error page not in buffers
		return false;
	}
	int slotNo = slot->second;
	if(!buffers[slotNo].pinned) {
		//error page unpinned
		return false;
	}
	// set page dirty
	buffers[slotNo].dirty=true;
	//make this page MRU in buffers
	usedList.remove(slotNo); 
	usedList.push_front(slotNo); // put at front	
	return true;
}

// unpin page -- required so that buffer manager can free up space from such marked buffers

bool BufferManager::UnpinPage(PageDescriptor pd) {
	auto slot = hashTable.find(pd); //find slot 
	if(slot==hashTable.end()) {
		//error page not in buffers
		return false;
	}
	int slotNo = slot->second;
	if(!buffers[slotNo].pinned) {
		//error page unpinned
		return false;
	}
	buffers[slotNo].pinned = false; //set unpinned
	// set page as MRU
	usedList.remove(slotNo); 
	usedList.push_front(slotNo); // put at front
	return true;	
}

// release all pages for file and put them onto free list
bool BufferManager::FlushPages(int fd) {
	// do a linear scan for all pages belonging to this file
	for(int i=0;i<numPages;i++) {
		if(find(usedList.begin(),usedList.end(),i)==usedList.end()) continue; // skip free slots
		if(buffers[i].pageDescriptor.fd != fd) continue;
		//write back page if dirty
		if(buffers[i].dirty) {
			bool _res = WritePage(PageDescriptor(fd,buffers[i].pageDescriptor.pagenum),buffers[i].data);
			if(!_res) return false;
			buffers[i].dirty = false;
		}
		//remove slot from hashTable and usedList and add to free list
		hashTable.erase(PageDescriptor(fd,buffers[i].pageDescriptor.pagenum));
		usedList.remove(i);
		freeList.push_front(i);
	}
	return true;
}

// release given page of file from buffers
bool BufferManager::FlushPage(PageDescriptor pd) {
	// do a linear scan to find the corresponding page 
	for(int i=0;i<numPages;i++) {
		if(find(usedList.begin(),usedList.end(),i)==usedList.end()) continue; // skip free slots
		if(!(buffers[i].pageDescriptor== pd)) continue;
		//write back page if dirty
		if(buffers[i].dirty) {
			bool _res = WritePage(pd,buffers[i].data);
			if(!_res) return false;
			buffers[i].dirty = false;
		}
		//remove slot from hashTable and usedList and add to free list
		hashTable.erase(pd);
		usedList.remove(i);
		freeList.push_front(i);
		break; // only once instance 
	}
	return true;
}

void BufferManager::PrintBuffer() {
	cout << "Buffer contains " << numPages << " pages of size "
      << pageSize <<".\n";
   cout << "Contents in order from most recently used to "
      << "least recently used.\n";

    for(auto slot:usedList) {
    	cout << slot << " :: \n";
      	cout << "  fd = " << buffers[slot].pageDescriptor.fd << "\n";
      	cout << "  pageNum = " << buffers[slot].pageDescriptor.pagenum << "\n";
      	cout << "  Dirty = " << buffers[slot].dirty << "\n";
      	cout << "  pinned = " << buffers[slot].pinned << "\n";
      
    }
}

void BufferManager::ClearBuffer() {
	while(!usedList.empty()) {
		int slot = usedList.front();
		usedList.pop_front(); // remove front usedList
		hashTable.erase(buffers[slot].pageDescriptor); //remove from hash table
		freeList.push_front(slot); // add to free list
	}
}

//FindSlot - find a free slot , if no free, then find a victim slot from unpinned pages 
// return -1 if replacement not possible
int BufferManager::FindSlot() {
	// if free slot available
	if(!freeList.empty()) {
		int slot = freeList.front();
		freeList.pop_front();
		usedList.push_front(slot);
		return slot;
	}
	else {
		// since used list has MRU in front 
		// start search for a unpinned page from last 
		for(auto slot = usedList.rbegin();slot!=usedList.rend();slot++) {
			if(!buffers[*slot].pinned) {
				// page will be replaced
				// if dirty write to the file
				if(buffers[*slot].dirty) {
					int _res = WritePage(buffers[*slot].pageDescriptor,buffers[*slot].data);
					if(_res<0) continue;
					buffers[*slot].dirty=false;
				}
				//remove from hash table , and usedList
				hashTable.erase(buffers[*slot].pageDescriptor);
				// move the slot to MRU (front of used list)
				int slot_val = *slot;
				usedList.remove(slot_val);
				usedList.push_front(slot_val);
				return slot_val;
			}
		}
	}
	return -1; // no slot available
}
// read page from the file and return character array to it
bool BufferManager::ReadPage(PageDescriptor pd,char *dest) {
	// calculate file offset
	long offset = pd.pagenum*(long)pageSize + FILE_HDR_SIZE;
	lseek(pd.fd,offset,0); // seek to location
	int count = -1;
	count = read(pd.fd, dest, pageSize);
	if(count != pageSize) //read failed
		return false;
	return true;
}
// write page contents to file 
bool BufferManager::WritePage(PageDescriptor pd,char *src) {
	// calculate file offset
	long offset = pd.pagenum*(long)pageSize + FILE_HDR_SIZE;
	lseek(pd.fd,offset,0); // seek to location
	if(write(pd.fd,src,pageSize)!=pageSize) //write failed
		return false;
	return true;

}	
// helper function to initialize buffer page after page read 
void BufferManager::InitializeBuffer(PageDescriptor pd,int slot) {
	buffers[slot].pageDescriptor = pd;
	buffers[slot].dirty = false;
	buffers[slot].pinned = true;
}
