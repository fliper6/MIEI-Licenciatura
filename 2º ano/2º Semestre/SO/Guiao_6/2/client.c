#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

int main(int argc, char** argv)
{
    int server = open("pip", O_WRONLY);
    if (server < 0) {
        printf("Server offline\n");
        return 1;
    }

    char buf[100];
    int n;
    while ((n = read(0,buf,100)) > 0)
        write(server,buf,n);
    close(server);

    return 0;
}