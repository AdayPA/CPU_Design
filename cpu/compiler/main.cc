#include "cat.h"

int main(int argc, char** argv) {
	
      std::string output_prog(argv[2]);
      std::string input_prog(argv[1]);
      CAT cat(input_prog, output_prog);
	
	return 0;
}
