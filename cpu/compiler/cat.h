#ifndef CAT_H_
#define CAT_H_

#include <string>
#include <vector>

class CAT {
 public:
  CAT();
  CAT(std::string& inputProgFile, std::string& outputProgFile);
  ~CAT();

 private:
  std::string inputProgFile_;
  std::string outputProgFile_;
  std::string Get_line(const std::string&, const int&);
  std::vector<std::string> Split(std::string, std::string);
  void OutputOpenError(void);
  void OutFileSyntaxName(void);
  constexpr const int& CountChar(void);
  inline const std::string& Get_outputProgFile (void)  {return outputProgFile_;}
  inline void Set_outputFile(const std::string& filename) {outputProgFile_ = filename;}
  int Count_lines(const std::string);
  const bool IsDigit(const std::string&);
  void RemoveFile(const char * file_to_remove);
  std::string ClearComments(std::string new_file_name);
  std::string GetToken(std::string);
  // permissions
  // size for file
  // error type
};

#endif  // CAT_H_
