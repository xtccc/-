#!/bin/env bash 
# Dependencies: tesseract-ocr imagemagick gnome-screenshot xclip

#Name: OCR Picture
#Author:andrew
#Fuction: take a screenshot and OCR the letters in the picture
#Path: /home/Username/...
#Date: 2020-02-10

#you can only scan one character at a time
SCR="/home/xtcc/tmp/picture"

####take a shot what you wana to OCR to text
#gnome-screenshot -a -f $SCR.png
spectacle -rbno $SCR.png


####increase the png
mogrify -modulate 100,0 -resize 400% $SCR.png 
#should increase detection rate

####OCR by tesseract
tesseract $SCR.png $SCR &> /dev/null -l eng+chi1

##使用sed 替换所有换行符
sed -i ":a;N;s/\n//g;ta" $SCR.txt

###翻译英文
cat $SCR.txt | xargs -i python ~/translator/translator.py --engine=google {} > $SCR.chi.txt

####get the text and copy to clipboard
cat $SCR.txt | xclip -selection clipboard

#cat $SCR.txt |xargs -i kdialog --msgbox  {}
#cat $SCR.chi.txt |xargs -i kdialog --msgbox  {}
kdialog --geometry 500x400+00+0 --textbox  $SCR.chi.txt


exit