{All unreadable characters are Russian letters. 
To read them, the file with the program, 
the input and output files must have encoding number 866 "OEM - Russian".}

PROGRAM CountWords(INPUT, OUTPUT);

CONST
  Letters = ['a'..'z', 'A'..'Z', '�'..'�', '�'..'�', '�', '�'];

TYPE
  Len = 1..MAXINT;
  ObjectOfDictionary = RECORD
                         Name: STRING;
                         NumberOfOccurrences: INTEGER;
                       END;
  WordDictionary = ARRAY [1..MAXINT] OF ObjectOfDictionary;

VAR
  Dictionary: WordDictionary;
  LengthOfDictionary: Len;
  InputFile, OutputFile: TEXT;
  TotalWords: INTEGER;

FUNCTION LowerCaseEnglishRussian(VAR Ch: CHAR): CHAR;
BEGIN
  IF Ch = 'A' THEN Ch := 'a'
  ELSE IF Ch = 'B' THEN Ch := 'b'
  ELSE IF Ch = 'C' THEN Ch := 'c'
  ELSE IF Ch = 'D' THEN Ch := 'd'
  ELSE IF Ch = 'E' THEN Ch := 'e'
  ELSE IF Ch = 'F' THEN Ch := 'f'
  ELSE IF Ch = 'G' THEN Ch := 'g'
  ELSE IF Ch = 'H' THEN Ch := 'h'
  ELSE IF Ch = 'I' THEN Ch := 'i'
  ELSE IF Ch = 'J' THEN Ch := 'j'
  ELSE IF Ch = 'K' THEN Ch := 'k'
  ELSE IF Ch = 'L' THEN Ch := 'l'
  ELSE IF Ch = 'M' THEN Ch := 'm'
  ELSE IF Ch = 'N' THEN Ch := 'n'
  ELSE IF Ch = 'O' THEN Ch := 'o'
  ELSE IF Ch = 'P' THEN Ch := 'p'
  ELSE IF Ch = 'Q' THEN Ch := 'q'
  ELSE IF Ch = 'R' THEN Ch := 'r'
  ELSE IF Ch = 'S' THEN Ch := 's'
  ELSE IF Ch = 'T' THEN Ch := 't'
  ELSE IF Ch = 'U' THEN Ch := 'u'
  ELSE IF Ch = 'V' THEN Ch := 'v'
  ELSE IF Ch = 'W' THEN Ch := 'w'
  ELSE IF Ch = 'X' THEN Ch := 'x'
  ELSE IF Ch = 'Y' THEN Ch := 'y'
  ELSE IF Ch = 'Z' THEN Ch := 'z';
  IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�'
  ELSE IF Ch = '�' THEN Ch := '�';
  LowerCaseEnglishRussian := Ch
END;
                                            
FUNCTION ReadWord(VAR F: TEXT):STRING;
VAR
  Ch: CHAR;
  Wrd: STRING;
BEGIN
  Wrd := '';
  READ(F, Ch);
  WHILE (Ch IN Letters) AND (NOT EOLN(F))
  DO
    BEGIN
      Ch := LowerCaseEnglishRussian(Ch);
      Wrd := Wrd + Ch;
      READ(F, Ch)
    END;
  IF Ch IN Letters
  THEN
    BEGIN
      Ch := LowerCaseEnglishRussian(Ch);
      Wrd := Wrd + Ch
    END;
  ReadWord := Wrd
END;

PROCEDURE AddWordsToDictionary(VAR Dict: WordDictionary; VAR L: Len; VAR F: TEXT);
VAR
  I: Len;
  NewName: STRING;
BEGIN
  I := 1;
  WHILE NOT EOF(F)
  DO
    BEGIN
      NewName := ReadWord(F);
      IF NewName <> ''
      THEN
        BEGIN
          Dict[I].Name := LowerCase(NewName);
          Dict[I].NumberOfOccurrences := 1;
          I := I + 1;
          IF EOLN(F) AND NOT EOF(F)
          THEN
            READLN()
        END;
    END;
  L := I
END;

PROCEDURE QuickSortDictionary(Left, Right: Len);
VAR
  I, J, FX: Len;
  X, Temp: ObjectOfDictionary;
BEGIN
  I := Left;
  J := Right;
  FX := (Left + Right) DIV 2;
  X := Dictionary[FX];
  REPEAT
    WHILE (Dictionary[I].Name < X.Name)
    DO
      I := I + 1;
    WHILE (X.Name < Dictionary[J].Name)
    DO
      J := J - 1;
    IF (I <= J)
    THEN
      BEGIN
        Temp := Dictionary[I];
	    Dictionary[I] := Dictionary[J];
	    Dictionary[J] := Temp;
        I := I + 1;
        J := J - 1
      END 
  UNTIL (I > J);
  IF (Left < J)
  THEN
    QuickSortDictionary(Left, J);
  IF (I < Right)
  THEN
    QuickSortDictionary(I, Right)   
END;

PROCEDURE CountNumberOfOccurrences(VAR Dict: WordDictionary; VAR L: Len);
VAR
  I, J: Len;
BEGIN
  FOR I := 1 TO L
  DO
    BEGIN
      FOR J := I + 1 TO L
      DO
        IF Dict[J].Name = Dict[I].Name
        THEN
          BEGIN
            Dict[I].NumberOfOccurrences := Dict[I].NumberOfOccurrences + 1;
            Dict[J].NumberOfOccurrences := Dict[J].NumberOfOccurrences + 1
          END
    END
END;

PROCEDURE RemoveRepeatedWords(VAR Dict: WordDictionary; VAR L: Len);
VAR
  NewDict: WordDictionary;
  Wrd: ObjectOfDictionary;
  I, J: Len;
BEGIN
  J := 1;
  Wrd := Dict[1];
  FOR I := 1 TO L
  DO
    IF Dict[I].Name <> Wrd.Name
    THEN
      BEGIN
        J := J + 1;
        NewDict[J] := Dict[I];
        Wrd := Dict[I]
      END;
  Dict := NewDict;
  L := J;
END;


PROCEDURE ShowDictionary(VAR Dict: WordDictionary; VAR L: Len; VAR Total: INTEGER; VAR F: TEXT);
VAR
  I: Len;
BEGIN
  FOR I := 1 TO L
  DO
    IF Dict[I].Name <> ''
    THEN
      BEGIN
        WRITELN(F, Dict[I].Name, ' ', Dict[I].NumberOfOccurrences);
        Total := Total + Dict[I].NumberOfOccurrences
      END;
  WRITELN(F, Total, ' words totally')
END;

BEGIN
  TotalWords := 0;
  ASSIGN(InputFile, 'input.txt');
  RESET(InputFile);
  WRITELN(OUTPUT, 'opened');
  AddWordsToDictionary(Dictionary, LengthOfDictionary, InputFile);
  WRITELN(OUTPUT, 'read');
  CLOSE(InputFile);
  WRITELN(OUTPUT, 'closed');
  {SortDictionary(Dictionary, LengthOfDictionary);}
  WRITELN(OUTPUT, 'sorting');
  QuickSortDictionary(1, LengthOfDictionary);
  WRITELN(OUTPUT, 'sorted');
  CountNumberOfOccurrences(Dictionary, LengthOfDictionary);
  RemoveRepeatedWords(Dictionary, LengthOfDictionary);
  ASSIGN(OutputFile, 'output.txt');
  REWRITE(OutputFile);
  ShowDictionary(Dictionary, LengthOfDictionary, TotalWords, OutputFile);
  CLOSE(OutputFile)
END.
