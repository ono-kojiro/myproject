CC   = gcc

SRCS = main.c
OBJS = $(SRCS:.c=.o)
PROG = hello.exe

all : obj prog

prog : $(PROG)

$(PROG) : $(OBJS)
	$(CC) -o $@ $(OBJS)

obj : $(OBJS)

%.o : %.c
	$(CC) -c -o $@ $<

test :
	$(PROG)

clean :
	DEL /Q /S $(OBJS) $(PROG)
