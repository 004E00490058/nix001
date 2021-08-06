#!/bin/bash
#в вашей системе должна быть установлена программа ImageMagick
if [ -n "$1" ] # проверка, если ли на вход файл со списком
then 
cat $1 | while read line # читаем строки в файле со списком
do
filename=${line%.*}
if [[ $filename != *"_thumbnail" ]]; then #проверяем не сжат ли уже файл
OUTPUT1=`identify $line | awk '{print $3}' | tr "x" " " | awk '{print $1}'` # узнаем ширину
OUTPUT2=`identify $line | awk '{print $3}' | tr "x" " " | awk '{print $2}'` # узнаем высоту
if [[ "$OUTPUT1" > "$OUTPUT2" ]]; then # сравниваем, и узнаем длинную сторону, записываем в переменную change
change='x360' 
else 
change='360' 
fi
convert -resize $change "$filename.jpg" $filename\_thumbnail.jpg # изменяем размер до 360, в завимости от длинной стороны и добавляем _thumbnail к имени.
else 
break
fi
done

else # если файла со списком нет, то обработка всех файлов формата jpg

for img in *.jpg; 
do  filename=${img%.*}

if [[ $filename != *"_thumbnail" ]] #проверяем не сжат ли уже файл
then
OUTPUT1=`identify $img | awk '{print $3}' | tr "x" " " | awk '{print $1}'` # узнаем ширину
OUTPUT2=`identify $img | awk '{print $3}' | tr "x" " " | awk '{print $2}'` # узнаем высоту
if [[ "$OUTPUT1" > "$OUTPUT2" ]]; then # сравниваем, и узнаем длинную сторону, записываем в переменную change
change='360' 
else 
change='x360' 
fi
convert  -verbose -resize $change "$filename.jpg" $filename\_thumbnail.jpg # изменяем размер до 360, в завимости от длинной стороны и добавляем _thumbnail к имени.
else
break
fi
done
fi
