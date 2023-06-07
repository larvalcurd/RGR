PROGRAM Test(INPUT, OUTPUT);

VAR
  InputFile: TEXT;

FUNCTION ReadWord(VAR F: TEXT):STRING;
VAR
  Ch, PrevCh, Space: CHAR;
  Wrd, RWrd: STRING;
  Stop: BOOLEAN;
BEGIN
  Space := ' ';
  Wrd := '';
  PrevCh := ' ';
  Stop := False;
  WHILE NOT EOLN(F) AND (NOT Stop)
  DO
    BEGIN
      READ(F, Ch);
      IF Ch IN ['A'..'Z', 'a'..'z']
      THEN
        BEGIN
          Wrd := Wrd + Ch;
          PrevCh := Ch
        END;
      IF (Ch = '-') AND (PrevCh <> ' ') AND (PrevCh <> '-')
      THEN
        BEGIN
          Wrd := Wrd + Ch;
          PrevCh := Ch
        END;
        IF Ch = ' '
        THEN
          Stop := TRUE;
      END;
  IF EOLN(F) AND (NOT(EOF(F)))
  THEN
    READLN();
  IF pos(Space, Wrd) > 0 
  THEN
    RWrd := '!!!!'
  ELSE
    RWrd := Wrd;
  Wrd := '';
  ReadWord := RWrd
END;


BEGIN
  ASSIGN(InputFile, 'input.txt');
  RESET(InputFile);
  WHILE NOT EOF(InputFile)
  DO
    WRITELN(OUTPUT, ' ||', ReadWord(InputFile));
  CLOSE(InputFile)
END.
         
    
  
