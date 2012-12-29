PROGRAM = dhltrack
SRC = main.vala
PKGS = --pkg gtk+-2.0 --pkg libsoup-2.4
VALAC = valac
VALACOPTS = -g --save-temps -X -lncurses
BUILD_ROOT = 1
all:
  @$(VALAC) $(VALACOPTS) $(SRC) -o $(PROGRAM) $(PKGS)
release: clean
	@$(VALAC) -X -O2 $(SRC) -o main_release $(PKGS)
clean:
	@rm -v -fr *~ *.c $(PROGRAM)
