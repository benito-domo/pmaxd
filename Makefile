# build helloworld executable when user executes "make"
CFLAGS          += -I $(SRCDIR)/FLU $(OPTIMIZE) $(DEBUG) -fsigned-char
LDFLAGS         += -fsigned-char
CC              = $(CROSS_COMPILE)gcc
all: pmaxd xplsendjson jsongetxplstate testpmaxd jsonwritexplstate

install: pmaxd xplsendjson jsongetxplstate testpmaxd jsonwritexplstate
	cp -f pmaxd /usr/bin/pmaxd
	cp -f testpmaxd /usr/bin/testpmaxd
	cp -f xplsendjson.cgi /usr/lib/cgi-bin/xplsendjson.cgi
	cp -f jsongetxplstate.cgi /usr/lib/cgi-bin/jsongetxplstate.cgi
	cp -f jsonwritexplstate /usr/bin/jsonwritexplstate

pmaxd: pmaxd.o
	$(CC) $(LDFLAGS) pmaxd.o -o pmaxd -lxPL -lconfig
pmaxd.o: pmaxd.c
	$(CC) $(CFLAGS) -c pmaxd.c 
xplsendjson: xplsendjson.o
	$(CC) $(LDFLAGS) xplsendjson.o -o xplsendjson.cgi -lxPL 
xplsendjson.o: xplsendjson.c
	$(CC) $(CFLAGS) -c xplsendjson.c
jsongetxplstate: jsongetxplstate.o
	$(CC) $(LDFLAGS) jsongetxplstate.o -o jsongetxplstate.cgi -lxPL
jsongetxplstate.o: jsongetxplstate.c
	$(CC) $(CFLAGS) -c jsongetxplstate.c
testpmaxd: testpmaxd.o
	$(CC) $(LDFLAGS) testpmaxd.o -o testpmaxd -lxPL -lconfig
testpmaxd.o: testpmaxd.c
	$(CC) $(CFLAGS) -c testpmaxd.c
jsonwritexplstate: jsonwritexplstate.o
	$(CC) $(LDFLAGS) jsonwritexplstate.o -o jsonwritexplstate -lxPL
jsonwritexplstate.o: jsonwritexplstate.c
	$(CC) $(CFLAGS) -c jsonwritexplstate.c


# remove object files and executable when user executes "make clean"
clean:
	rm *.o pmaxd testpmaxd xplsendjson.cgi jsongetxplstate.cgi jsonwritexplstate
