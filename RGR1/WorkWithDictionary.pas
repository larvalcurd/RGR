UNIT WorkWithDictionary;
INTERFACE

CONST
  Letters = ['a'..'z', 'A'..'Z', 'Ä'..'ü', '†'..'Ô', 'Ò', '', '-'];

TYPE
  Len = 1..16000;
  ObjectOfDictionary = RECORD
                         Name: STRING;
                         NumberOfOccurrences: INTEGER;
                       END;
  WordDictionary = ARRAY [1..18000] OF ObjectOfDictionary;

FUNCTION LowerCaseEnglishRussian(VAR Ch: CHAR): CHAR;
FUNCTION ReadWord(VAR F: TEXT):STRING;
PROCEDURE AddWordsToDictionary(VAR Dict: WordDictionary; VAR L: Len; VAR F: TEXT);
PROCEDURE QuickSortDictionary(VAR Dict: WordDictionary; VAR Left: Len; VAR Right: Len);
PROCEDURE CountNumberOfOccurrences(VAR Dict: WordDictionary; VAR L: Len);
PROCEDURE RemoveRepeatedWords(VAR Dict: WordDictionary; VAR L: Len);
PROCEDURE ShowDictionary(VAR Dict: WordDictionary; VAR L: Len; VAR Total: INTEGER; VAR F: TEXT);

IMPLEMENTATION

VAR Ch: CHAR;



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
  IF Ch = 'Ä' THEN Ch := '†'
  ELSE IF Ch = 'Å' THEN Ch := '°'
  ELSE IF Ch = 'Ç' THEN Ch := '¢'
  ELSE IF Ch = 'É' THEN Ch := '£'
  ELSE IF Ch = 'Ñ' THEN Ch := '§'
  ELSE IF Ch = 'Ö' THEN Ch := '•'
  ELSE IF Ch = '' THEN Ch := 'Ò'
  ELSE IF Ch = 'Ü' THEN Ch := '¶'
  ELSE IF Ch = 'á' THEN Ch := 'ß'
  ELSE IF Ch = 'à' THEN Ch := '®'
  ELSE IF Ch = 'â' THEN Ch := '©'
  ELSE IF Ch = 'ä' THEN Ch := '™'
  ELSE IF Ch = 'ã' THEN Ch := '´'
  ELSE IF Ch = 'å' THEN Ch := '¨'
  ELSE IF Ch = 'ç' THEN Ch := '≠'
  ELSE IF Ch = 'é' THEN Ch := 'Æ'
  ELSE IF Ch = 'è' THEN Ch := 'Ø'
  ELSE IF Ch = 'ê' THEN Ch := '‡'
  ELSE IF Ch = 'ë' THEN Ch := '·'
  ELSE IF Ch = 'í' THEN Ch := '‚'
  ELSE IF Ch = 'ì' THEN Ch := '„'
  ELSE IF Ch = 'î' THEN Ch := '‰'
  ELSE IF Ch = 'ï' THEN Ch := 'Â'
  ELSE IF Ch = 'ñ' THEN Ch := 'Ê'
  ELSE IF Ch = 'ó' THEN Ch := 'Á'
  ELSE IF Ch = 'ò' THEN Ch := 'Ë'
  ELSE IF Ch = 'ô' THEN Ch := 'È'
  ELSE IF Ch = 'ö' THEN Ch := 'Í'
  ELSE IF Ch = 'õ' THEN Ch := 'Î'
  ELSE IF Ch = 'ú' THEN Ch := 'Ï'
  ELSE IF Ch = 'ù' THEN Ch := 'Ì'
  ELSE IF Ch = 'û' THEN Ch := 'Ó'
  ELSE IF Ch = 'ü' THEN Ch := 'Ô';
  LowerCaseEnglishRussian := Ch
END;

FUNCTION ReadWord(VAR F: TEXT):STRING;
VAR
  Ch, PrevCh: CHAR;
  Wrd: STRING;
BEGIN
  Wrd := '';
  PrevCh := ' ';
  READ(F, Ch);
  WHILE (Ch IN Letters) AND (NOT EOLN(F))
  DO
    BEGIN
      IF (Ch = '-') AND (PrevCh <> ' ') AND (PrevCh <> '-')
      THEN
        BEGIN
          Wrd := Wrd + Ch;
          PrevCh := Ch
        END
      ELSE
        IF Ch <> '-'
        THEN
          BEGIN
            Ch := LowerCaseEnglishRussian(Ch);
            Wrd := Wrd + Ch;
            PrevCh := Ch;
          END;
      READ(F, Ch);
    END;
  IF (Ch IN Letters) AND (Ch <> '-')
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
          WRITELN(OUTPUT, 'word ', I, ' read');
          Dict[I].Name := LowerCase(NewName);
          Dict[I].NumberOfOccurrences := 1;
          WRITELN(OUTPUT, 'word ', I, ' added');
          I := I + 1;
          IF EOLN(F) AND NOT EOF(F)
          THEN
            READLN()
        END;
    END;
  L := I
END;
PROCEDURE QuickSortDictionary(VAR Dict: WordDictionary; VAR Left: Len; VAR Right: Len);
VAR
  I, J: Len;
  Pivot, Temp: ObjectOfDictionary;
BEGIN
  I := Left;
  J := Right;
  Pivot := Dict[Left + (Right - Left) DIV 2];
  WHILE I <= J 
  DO
    BEGIN
      WHILE Dict[I].Name < Pivot.Name 
      DO
        I := I + 1;
      WHILE Dict[J].Name > Pivot.Name 
      DO
        J := J - 1;
      IF I <= J 
      THEN
        BEGIN
          Temp := Dict[I];
          Dict[I] := Dict[J];
          Dict[J] := Temp;
          I := I + 1;
          J := J - 1
        END
      END;
  IF Left < J 
  THEN
    QuickSortDictionary(Dict, Left, J);
  IF I < Right 
  THEN
    QuickSortDictionary(Dict, I, Right)
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
END.
