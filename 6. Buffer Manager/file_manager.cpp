/* implementation of interfaces in file_manager.h */

#include <cstdio>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include "constants.h"
#include "buffer_manager.h"
#include "errors.h"
#include <cstring>
#include <iostream>

// implement PageHandler interface
 

// constructor (default)
PageHandler::PageHandler() {
	pageNum = -1;
	data = NULL;
}
// constructor (parameterized)
PageHandler::PageHandler(int pageNum,char *data) {
	this->pageNum = pageNum;
	this->data = data;
}

// constructor (copy)
PageHandler::PageHandler(const PageHandler &pageHandle) {
	this-> pageNum = pageHandle.pageNum;
	this-> data = pageHandle.data;
}

bool PageHandler::operator==(const PageHandler &pageHandle) {
	return this->pageNum == pageHandle.pageNum && this->data == pageHandle.data;
}

// access method - get access to data char-array
char* PageHandler::GetData() {
	return data;
}

// access method - get access to page number
int PageHandler::GetPageNum() {
	return pageNum;
}

// implement PageHandler interface

// constructor (default)
FileHandler::FileHandler() {
	isOpen = false;
	hdrChanged = false;
	unix_file_desc = -1;
	bufferManager = NULL;
}

// constructor (copy)
FileHandler::FileHandler(const FileHandler &fileHandle) {
	this->isOpen = fileHandle.isOpen;
	this->hdr = fileHandle.hdr;
	this->bufferManager = fileHandle.bufferManager;
	this->hdrChanged = fileHandle.hdrChanged;
	this->unix_file_desc = fileHandle.unix_file_desc;
	this->fileName = fileHandle.fileName;
}

bool FileHandler::operator==(const FileHandler &fileHandle) {
	return this->unix_file_desc == fileHandle.unix_file_desc;
}

// return first page in file 
PageHandler FileHandler::FirstPage() {
	// logic - use NextPage with page number -1 == same as fetch first valid page
	return NextPage(-1);	
}

// return last page in file
PageHandler FileHandler::LastPage() {
	// logic - use PrevPage with page number = total_pages == same as fetch first valid page from last (total_pages-1)
	int total_pages = (this->hdr).totalPages;
	return PrevPage(total_pages);
}

// return page at page index page_number 
PageHandler FileHandler::PageAt(int page_number) {
	PageHandler pageHandle;
	if(!checkPageValid(page_number)) {
		// return invalid page
		throw InvalidPageException();
	}
	// get page from bufferManager
 
	char *page_in_buffer = bufferManager->GetPage(PageDescriptor(this->unix_file_desc,page_number));	
	// get page header
	PageHdr *page_hdr = (PageHdr*) page_in_buffer;
	// if slot is not free
	// set page number 
	// and set page data to point to starting position of data part in page obtained from buffer manager
	if (page_hdr->nextFreePage==NOT_FREE) {
		pageHandle.pageNum = page_number;
		pageHandle.data = page_in_buffer+sizeof(PageHdr);
	}
	else {
		// unpin page according to redbase logic
		UnpinPage(page_number);
	}
	return pageHandle;
}

// get next page from given page number
PageHandler FileHandler::NextPage(int page_number) {
	PageHandler pageHandle;
	if(!checkPageValid(page_number) && page_number!=-1) { //allow -1
		// return invalid page
		throw InvalidPageException();
	}
	// start searching for next valid(used) page 
	page_number = page_number + 1;
	for(;page_number<=hdr.totalPages;page_number++) { // MR: page_number <= totalpages to ensure that it runs this at least once if file contains only one page
		pageHandle = PageAt(page_number);
		// if page retrieved without error, stop checking further
		if(pageHandle.GetPageNum()!=-1) break;
	}
	return pageHandle;
}

// get prev page from given page number
PageHandler FileHandler::PrevPage(int page_number) {
	if(!checkPageValid(page_number) && page_number!=hdr.totalPages) { //allow totalPages (call from LastPage)
		// return invalid page
		throw InvalidPageException();
	}
	// start searching for prev valid(used) page 
	page_number = page_number - 1;
	PageHandler pageHandle;
	for(;page_number>=0;page_number--) {
		pageHandle = PageAt(page_number);
		// if page retrieved without error, stop checking further
		if(pageHandle.GetPageNum()!=-1) break;
	}
	return pageHandle;
}

// allocate a new page in file ( either add at end (if free list empty) or use one from the free list)
// incase of errors - returns INVALID_PAGE
PageHandler FileHandler::NewPage() {
	int page_number ; // new page number
	char *page_buffer ; //to store page read from buffer manager
	PageHandler pageHandle;
	//if free list not empty 
	if(hdr.firstFreePage!= END_FREE) {
		// first free page number will be the new page number 
		page_number = hdr.firstFreePage;
		//contents of page are read using the buffer manager
		page_buffer = bufferManager->GetPage(PageDescriptor(this->unix_file_desc,page_number));
		// update the head of free page list for file	
		hdr.firstFreePage = ((PageHdr*)page_buffer)->nextFreePage;
	}
	else { // free pages
		page_number = hdr.totalPages; // new page will be added at the end of file
		page_buffer = bufferManager->AllocatePage(PageDescriptor(this->unix_file_desc,page_number)); //allocate and load the page in buffer manager
		//increase number of pages by one
		hdr.totalPages++;
	}
	//mark file header is changed
	this->hdrChanged = true;
	// mark the new page as used
    ((PageHdr *)page_buffer)->nextFreePage = NOT_FREE;
    //overwrite page contents
    memset(page_buffer+sizeof(PageHdr),0,PAGE_CONTENT_SIZE);
    //mark the page dirty due to next pointer of free list changed
    MarkDirty(page_number);
    pageHandle.pageNum = page_number;
    pageHandle.data = page_buffer+sizeof(PageHdr);
 
    return pageHandle;
}

// dispose a page in the file 
// that page becomes available to be used in future by adding it to the free list
bool FileHandler::DisposePage(int page_number) {

	if(!checkPageValid(page_number)) return false; // invalid request
	// read the page from the buffer manager 
	char *page_buffer;
	page_buffer = bufferManager->GetPage(PageDescriptor(this->unix_file_desc,page_number));
	PageHdr * page_header = (PageHdr*) page_buffer;
	// if already free - 
	if (page_header->nextFreePage!=NOT_FREE) {
		UnpinPage(page_number); // since page read into buffer manager
		return false;
	}
	// update the head of free list by adding this page at the head
	page_header->nextFreePage = hdr.firstFreePage;
	hdr.firstFreePage = page_number;
	this->hdrChanged = true;
	// mark the page as dirty and then unpin it 
	MarkDirty(page_number);
	UnpinPage(page_number);
	return true;
}

// mark the page as dirty
// then before page is unpinned from buffer
// it will be written to the file
bool FileHandler::MarkDirty(int page_number) {
	return bufferManager->MarkDirty(PageDescriptor(this->unix_file_desc,page_number));
}

// unpin page wrapper for buffer manager unpin page function
bool FileHandler::UnpinPage(int page_number) {
	return bufferManager->UnpinPage(PageDescriptor(this->unix_file_desc,page_number));
}

// flush all pages to file
// note if header is changed, we need to write it back here
// since buffer manager would only deal with pages
bool FileHandler::FlushPages() {
	if(this->hdrChanged) {
		lseek(this->unix_file_desc,0,0); // seek file pointer to start
		int _wr_res = write(this->unix_file_desc,(char *)&hdr,sizeof(FileHdr));
		if(_wr_res<0) return false; //write error
		this->hdrChanged =false;
	}
	return bufferManager->FlushPages(this->unix_file_desc);
}

// flush individual page out of buffer manager
bool FileHandler::FlushPage(int page_number) {
	if(this->hdrChanged) {
		lseek(this->unix_file_desc,0,0); // seek file pointer to start
		int _wr_res = write(this->unix_file_desc,(char *)&hdr,sizeof(FileHdr));
		if(_wr_res<0) return false; //write error
		this->hdrChanged =false;
	}
	return bufferManager->FlushPage(PageDescriptor(this->unix_file_desc,page_number));
}

// check if page number is valid (in range)
bool FileHandler::checkPageValid(int page_number) {
	if(isOpen && page_number>=0 && page_number < hdr.totalPages) return true;
	return false;
}

// implement FileManager interface

int FileManagerInstanceCount = 0;

FileManager::FileManager() {
	// intialize manager with a buffer manager
	// thus buffer manager will be hidden from student API access 
	if(FileManagerInstanceCount==1) {
		throw FileManagerInstanceException();
	}
	FileManagerInstanceCount = 1;
	bufferManager = new BufferManager(BUFFER_SIZE);
 
	
}

FileManager::~FileManager() {
	// destroy buffer manager in destructor
	FileManagerInstanceCount = 0;
	delete bufferManager;
 
}

// create a file and return a file handle for it 
FileHandler FileManager::CreateFile(const char* filename) {
	// open file for writing
	int fd = open(filename,O_CREAT|O_EXCL|O_RDWR,0660); // updated to fail if file already exists
	if(fd==-1) throw InvalidFileException();
	// write out the initial header
	char hdr_buf[FILE_HDR_SIZE];
	memset(hdr_buf,0,FILE_HDR_SIZE);
	FileHdr *hdr= (FileHdr*) hdr_buf;
	hdr->firstFreePage = END_FREE;
	hdr->totalPages = 0;
	write(fd,hdr_buf,FILE_HDR_SIZE);
	close(fd);
	return OpenFile(filename);
}

// delete file, return true if success
bool FileManager::DestroyFile(const char* filename) {
	int res = unlink(filename); // reduce the open file count
	return (res == 0) ; // success if return code == 0 
}


// open already existing file, return File handle for it
FileHandler FileManager::OpenFile(const char *filename) {
	FileHandler fileHandle; 
	// open file 
	fileHandle.fileName = new char[strlen(filename)+1];
	strcpy(fileHandle.fileName, filename);
 

	fileHandle.unix_file_desc = open(filename,O_RDWR);
	if(fileHandle.unix_file_desc==-1) throw InvalidFileException();
	//read header
	fileHandle.hdr.firstFreePage = 0;
	fileHandle.hdr.totalPages = 0;
	int _temp_res = read(fileHandle.unix_file_desc,(char *)&fileHandle.hdr,
            sizeof(FileHdr));
    // update file metadata
    fileHandle.isOpen = true;
    fileHandle.hdrChanged = false;
    fileHandle.bufferManager = bufferManager;
    return fileHandle;
}

//close file using its file Handle
bool FileManager::CloseFile(FileHandler &fileHandle) {
	if(!fileHandle.isOpen) return false; // if not already open
	if(!fileHandle.FlushPages()) return false; //flush pages to file, if error in flushing all pages , return false
	close(fileHandle.unix_file_desc); // close the file
 

	//update meta data
	fileHandle.isOpen = false;
	fileHandle.bufferManager = NULL;	
	return true;
}

// interface to clearing buffer 
void FileManager::ClearBuffer() {
	bufferManager->ClearBuffer();
}
// interface to printing buffer contents
void FileManager::PrintBuffer() {
	bufferManager->PrintBuffer();
}
