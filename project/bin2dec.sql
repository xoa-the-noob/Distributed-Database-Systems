CREATE OR REPLACE FUNCTION bin2dec (binval in char) RETURN number IS
  i                 number;
  digits            number;
  result            number := 0;
  current_digit     char(1);
  current_digit_dec number;
BEGIN
  digits := length(binval);
  for i in 1..digits loop
     current_digit := SUBSTR(binval, i, 1);
     current_digit_dec := to_number(current_digit);
     result := (result * 2) + current_digit_dec;
  end loop;
  return result;
END bin2dec;
/