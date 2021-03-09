#ifndef CAT_CC_
#define CAT_CC_

#include "cat.h"

#include <stdio.h>

#include <fstream>
#include <iostream>
#include <regex>
#include <algorithm>

const SIZE_WORD = 16;
const std::string kFileExt = ".txt";

CAT::CAT() {}

CAT::~CAT() {}

CAT::CAT(std::string& inputProgFile, std::string& outputProgFile) {
  inputProgFile_ = inputProgFile;
  outputProgFile_ = outputProgFile;
  
  std::ofstream output_stream;
  output_stream.open(outputProgFile_);
  int lines = Count_lines(inputProgFile_);
  for (int i = 1; i <= lines; i++) {
     std::vector<std::string> temp_ = Split(Get_line(inputProgFile, i) ," ");
     for (int j = 0; j < temp_.size(); j++) {
       output_stream << GetToken(temp_.at(j));
     
     }
     output_stream << std::endl;
  }
  output_stream.close();
}

void CAT::FormatOutput(void) {
	int lines = Count_lines (outputProgFile_);
	std::ofstream output_stream;	
	output_stream.open(outputProgFile_);
	for (int i = 0; i < lines; i++) {
			
	}
}

std::string CAT::AddUnderscore(std::string opcode) {
	std::string underscore = "_";
	std::string str;
	str.append(opcode.begin(),opcode.begin()+4);
	str.append(underscore);
	str.append(opcode.begin()+4,opcode.begin()+8);
	str.append(underscore);
	str.append(opcode.begin()+8,opcode.begin()+12);
	str.append(underscore);
	str.append(opcode.begin()+12,opcode.begin()+16);
	return str;
}


void CAT::OutputOpenError(void) {
  /// @brief If output file got an error, we will notice it
  std::ofstream output_stream;
  output_stream.open("dfa_log_error.txt");
  output_stream << "Error opening the file.";
}

void CAT::OutFileSyntaxName(void) {
  /// @brief we add the .txt file to the output
  std::string temp_name = Get_outputProgFile();
  if (temp_name.size() <= 4) {
    Set_outputFile(temp_name + kFileExt);
  } else {
    std::string aux;
    for (unsigned int pos = temp_name.size() - 4; pos <= temp_name.size(); ++pos) {
      aux += temp_name[pos];
    }
    aux.resize(4);
    if (!(aux == kFileExt)) {
      Set_outputFile(temp_name + kFileExt);
    }
  }
}

std::string CAT::GetToken(std::string opcode) {
   int lines = Count_lines("define_list.txt");
   std::ifstream inputfile("define_list.txt");
   for (int i = 0; i <= lines; i++) {
     std::vector<std::string> temp_ = Split(Get_line("define_list.txt", i) ," ");
     if (opcode == temp_.at(0)) return temp_.at(1);
   }
}

bool CAT::CheckOpcode(std::string opcode) {
	int lenght = 0;
	int lines = Count_lines("define_list.txt");
	std::ifstream inputfile("define_list.txt");
	for (int i = 0; i <= lines; i++) {
		std::vector<std::string> temp_ = Split(Get_line("define_list.txt", i) ," ");
		if (opcode == temp_.at(0)) length = lenght + temp_.at(2);			
	}
	if (lenght == SIZE_WORD) return true;
	else return false;
}


std::string CAT::Get_line(const std::string& filename, const int& line_number) {
  /// @brief Return the string of the line read.
  std::ifstream inputfile(filename);
  auto temp(1);
  std::string line;
  while ((!(inputfile.eof())) && (temp < line_number)) {
    std::getline(inputfile, line);
    ++temp;
  }
  std::getline(inputfile, line);
  return line;
}

int CAT::Count_lines(const std::string file) {
  /// @brief Count total lines from a file
  int lines = 0;
  std::ifstream file_to_count(file);
  std::string unused;
  while (std::getline(file_to_count, unused)) {
    ++lines;
  }
  return lines;
}

const bool CAT::IsDigit(const std::string& str)  {
  return std::all_of(str.begin(), str.end(), ::isdigit);
}

std::vector<std::string> CAT::Split(std::string str, std::string delim) {
  /// @brief this func split in 2 the string and store them in vector,
  //         depending of the char
  std::vector<std::string> tokens;
  size_t prev = 0, pos = 0;
  do {
    pos = str.find(delim, prev);
    if (pos == std::string::npos) pos = str.length();
    std::string token = str.substr(prev, pos-prev);
    if (!token.empty()) tokens.push_back(token);
    prev = pos + delim.length();
  }
  while (pos < str.length() && prev < str.length());
  return tokens;
}

std::string CAT::ClearComments(std::string new_file_name) {
  std::ofstream output_stream;
  output_stream.open("temp_" + new_file_name);
  std::regex comment("(//.*)");
  // std::regex comment2("(\t+|\s+|\r\n)((\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+)|(.*))");
  // std::regex comment3("/\*(.|\n)*?\*/");
  std::string unused;
  std::ifstream file_to_count(new_file_name);
  while (std::getline(file_to_count, unused)) {
    if (!std::regex_match(unused, comment)) {
      output_stream << unused << std::endl;
    }
  }
  output_stream.close();
  return new_file_name;
}

void CAT::RemoveFile(const char * file_to_remove) {
  remove(file_to_remove);
}

#endif
