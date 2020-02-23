/* Header file for ALL constants used */

#ifndef CONSTANTS_H
#define CONSTANTS_H

// fix buffer size 
const int BUFFER_SIZE=40;

// constants relation to page

// page content size 
const int PAGE_SIZE=4096;
// Page content size
const int PAGE_CONTENT_SIZE = PAGE_SIZE - sizeof(int); // integer excluded since that is part of page header

// constants for PageHdr class
const int END_FREE=-1; 
const int NOT_FREE=-2; 

// file header size - first page of file set as file header
const int FILE_HDR_SIZE  = PAGE_SIZE;

#endif