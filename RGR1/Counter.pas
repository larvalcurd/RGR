{All unreadable characters are Russian letters. 
To read them, the file with the program, 
the input and output files must have encoding number 866 "OEM - Russian".}

UNIT Counter;

INTERFACE

USES
  WorkWithDictionary;

PROCEDURE CountWords();

IMPLEMENTATION

PROCEDURE CountWords();
VAR
  Dictionary: WordDictionary;
  LengthOfDictionary, LeftSort: Len;
  InputFile, OutputFile: TEXT;
  TotalWords: INTEGER;
BEGIN
  TotalWords := 0;
  LeftSort := 1;
  ASSIGN(InputFile, 'input.txt');
  RESET(InputFile);
  WRITELN(OUTPUT, 'opened');
  AddWordsToDictionary(Dictionary, LengthOfDictionary, InputFile);
  WRITELN(OUTPUT, 'read');
  CLOSE(InputFile);
  WRITELN(OUTPUT, 'closed');
  WRITELN(OUTPUT, 'sorting');
  QuickSortDictionary(Dictionary, LeftSort, LengthOfDictionary);
  WRITELN(OUTPUT, 'sorted');
  CountNumberOfOccurrences(Dictionary, LengthOfDictionary);
  RemoveRepeatedWords(Dictionary, LengthOfDictionary);
  ASSIGN(OutputFile, 'output.txt');
  REWRITE(OutputFile);
  ShowDictionary(Dictionary, LengthOfDictionary, TotalWords, OutputFile);
  CLOSE(OutputFile)
END;



BEGIN
END.
