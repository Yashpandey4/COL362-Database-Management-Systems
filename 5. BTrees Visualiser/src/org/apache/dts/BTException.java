package org.apache.dts;


public class BTException extends Exception
{
    public BTException() {
        super();
    }

    public BTException(String message) {
        super(message);
    }

    public BTException(String message, Throwable cause) {
        super(message, cause);
    }

    public BTException(Throwable cause) {
        super(cause);
    }
}
