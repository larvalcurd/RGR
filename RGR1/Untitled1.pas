program count_words;

uses
  SysUtils;

var
  input_file, output_file: TextFile;
  word_count: array [Char] of Integer;
  word: String;
  ch: Char;

begin
  // ��������� �����
  AssignFile(input_file, 'voyna-i-mir.txt');
  Reset(input_file);
  AssignFile(output_file, 'words_count.txt');
  Rewrite(output_file);

  // �������������� �������� ����
  for ch := 'A' to 'Z' do
    word_count[ch] := 0;

  // ������ ������������ �� ������ � ����������� ��������
  while not Eof(input_file) do
  begin
    Read(input_file, word);
    word := AnsiUpperCase(word);
    for ch in word do
    begin
      if ch in ['A'..'Z'] then
        Inc(word_count[ch]);
    end;
  end;

  // ���������� ���������� � ���� � ���������� �������
  for ch := 'A' to 'Z' do
  begin
    if word_count[ch] > 0 then
      WriteLn(output_file, ch, ': ', word_count[ch]);
  end;

  // ��������� �����
  CloseFile(input_file);
  CloseFile(output_file);

  // �������� ������������, ��� ��������� ���������
  WriteLn('������! ���������� ��������� � ����� words_count.txt');
end.
