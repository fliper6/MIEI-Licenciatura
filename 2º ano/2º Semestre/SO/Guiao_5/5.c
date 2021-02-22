#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>

int main2()
{
    char** commands[4];
    char* grep[] = { "grep", "-v", "^#", "/etc/passwd", NULL };
    char* cut[] = { "cut", "-f7", "-d:", NULL };
    char* uniq[] = { "uniq", NULL };
    char* wc[] = { "wc", "-l", NULL };

    commands[0] = grep;
    commands[1] = cut;
    commands[2] = uniq;
    commands[3] = wc;

    int beforePipe = 0;
    int afterPipe[2];
    int n = 4;

    for (int i = 0; i < 4; i++) {
        if (i < 3)
            pipe(afterPipe);
        
        if (!fork()) {
            if (i > 0) {
                dup2(beforePipe, 0);
                close(beforePipe);
            }
            if (i < 3) {
                dup2(afterPipe[1], 1);
                close(afterPipe[0]);
                close(afterPipe[1]);
            }
            execvp(commands[i][0], commands[i]);
            _exit(1);
        }

        if (i < 3)
            close(afterPipe[1]);

        if (i > 0)
            close(beforePipe);
        
        beforePipe = afterPipe[0];
    }
    return 0;
}

int main(){
    int pd[2]; pipe(pd);
    if (!fork()){
        close(pd[0]);
        dup2(pd[1],1);
        close(pd[1]);
        execlp("grep","grep", "-v", "^#", "/etc/passwd", NULL);
        _exit(0);
    }
    wait(NULL);
    if (!fork()){
        dup2(pd[0],0);
        dup2(pd[1],1);
        close(pd[0]);close(pd[1]);
        execlp("cut","cut","-f7","-d:",NULL);
        _exit(0);
    }
    wait(NULL);
    if (!fork()){
        dup2(pd[0],0);
        dup2(pd[1],1);
        close(pd[0]);close(pd[1]);
        execlp("uniq","uniq",NULL);
        _exit(0);
    }
    wait(NULL);
    if (!fork()) {
        dup2(pd[0],0);
        close(pd[1]);
        close(pd[0]);
        execlp("wc","wc","-l",NULL);
        _exit(0);
    }
    close(pd[0]);
    close(pd[1]);
}