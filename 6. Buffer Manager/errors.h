/* Author: Maya Ramanath
 * Defines exceptions that could occur
 */

#ifndef ERRORS_H
#define ERRORS_H

#include<exception>

using namespace std;

/* Buffer manager cannot allocate a new page */
struct NoBufferSpaceException : public exception {
  const char *what () const throw () {
    return "BufferManagerException : There is no space in the buffer and the buffer manager is unable to evict any page (perhaps you need to unpin a few pages?)";
  }
};


// General class for Buffer Manager errors that would be thrown
// mess describes the reason for exception/error
struct BufferManagerException : public exception {
	const char* mess = "";
	BufferManagerException() {
		mess = "BufferManagerException : reason unknown";
	}
	BufferManagerException(const char *s) {
		mess =s ;
	}
	const char *what () const throw () {
    return mess;
  }

};

// Page request is invalid 
struct InvalidPageException : public exception {
	const char *what () const throw () {
    return "InvalidPageException : Page request is invalid (perhaps page number requested is not in the valid range)";
  }
};

//File request is invalid
struct InvalidFileException : public exception {
	const char *what () const throw () {
    return "InvalidFileException : File request is invalid. If you are trying to create a file , then probably a file with same name already exists. If you intend to open a file, then perhaps the file doesn't already exist.";
  }
};

// Exception to notify user of more than one instance creation of FileManager
struct FileManagerInstanceException : public exception {
	const char *what () const throw () {
    return "FileManagerException : More than 1 instance of File manager cannot be created.";
  }
};

#endif
