program count_words;

uses
  SysUtils;

var
  input_file, output_file: TextFile;
  word_count: array [Char] of Integer;
  word: String;
  ch: Char;

begin
  // открываем файлы
  AssignFile(input_file, 'voyna-i-mir.txt');
  Reset(input_file);
  AssignFile(output_file, 'words_count.txt');
  Rewrite(output_file);

  // инициализируем счетчики слов
  for ch := 'A' to 'Z' do
    word_count[ch] := 0;

  // читаем произведение по словам и увеличиваем счетчики
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

  // записываем результаты в файл в алфавитном порядке
  for ch := 'A' to 'Z' do
  begin
    if word_count[ch] > 0 then
      WriteLn(output_file, ch, ': ', word_count[ch]);
  end;

  // закрываем файлы
  CloseFile(input_file);
  CloseFile(output_file);

  // сообщаем пользователю, что программа завершена
  WriteLn('Готово! Результаты сохранены в файле words_count.txt');
end.
