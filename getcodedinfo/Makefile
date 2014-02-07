SIF = ELFUN EXTER GROUP RANGE
LIB = -L$(CUTEST)/objects/$(MYARCH)/double -lcutest -lgfortran -lgfortranbegin \
			-lpthread -lm

all: sifdecode exec

sifdecode:
	$(SIFDECODE)/bin/sifdecoder $(MASTSIF)/$(PROBNAME).SIF &> /dev/null
	gfortran -c $(addsuffix .f,$(SIF))
	rm -f AUTOMAT.d

exec: main.o $(addsuffix .o,$(SIF))
	gcc $^ -o main $(LIB)

main.o: main.c
	gcc -c -Wall -Wextra -I$(CUTEST)/include main.c -o main.o

%.o: %.f
	gfortran -c $< -o $@

clean:
	rm -f *.o
	rm -f $(addsuffix .f,$(SIF))
	rm -f *.SIF
	rm -f main OUTSDIF.d
