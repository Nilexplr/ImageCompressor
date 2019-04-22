##
## ImageCompressor
## Makefile
##

PROJECT_NAME	=	imageCompressor

all: $(PROJECT_NAME)

$(PROJECT_NAME):
	stack install --local-bin-path . --allow-different-user --exec 'mv ImageCompressor-exe imageCompressor'

tests_run:
	stack test

tests_run_coverage:
	stack test --coverage --allow-different-user

clean:
	rm -f $(PROJECT_NAME)

fclean: clean

re: fclean all