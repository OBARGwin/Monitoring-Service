#include <fcgiapp.h>
#include <stdio.h>

#define SOCKET_PATH "127.0.0.1:8080"

int main() {
    FCGX_Request request;
    FCGX_Init();
    FCGX_InitRequest(&request, 0, 0);

    while (FCGX_Accept_r(&request) >= 0) {
        FCGX_FPrintF(request.out,
                     "Content-Type: text/html\r\n"
                     "\r\n"
                     "<html><body><h1>Hello World!</h1></body></html>\r\n");
    }

    return 0;
}
