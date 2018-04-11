#!/usr/bin/env bash
#创建func.list文件并指定绝对路径
STRING_SYMBOL_FILE="$PROJECT_DIR/JXMagicVoice/CodeConfusion/func.list"
#工程文件夹目录，在根目录的里面一层
CONFUSE_FILE="$PROJECT_DIR/JXMagicVoice"
#创建codeObfuscation.h桥接文件并指定绝对路径
HEAD_FILE="$PROJECT_DIR/JXMagicVoice/CodeConfusion/codeObfuscation.h"

export LC_CTYPE=C

#遍历工程中所有以"hsy_"为开头的方法，写入codeObfuscation.h文件和func.list文件
#grep -h -r -I  "^[-+]" $CONFUSE_FILE  --include '*.[mh]' |sed "s/[+-]//g"|sed "s/[();,: *\^\/\{]/ /g"|sed "s/[ ]*</</"| sed "/^[ ]*IBAction/d"|awk '{split($0,b," "); print b[2]; }'| sort|uniq |sed "/^$/d"|sed -n "/^hsy_/p" >$STRING_SYMBOL_FILE

#遍历工程中的所有h文件，将所有方法名称全部写入list文件中
grep -h -r -I  "^[-+]" $CONFUSE_FILE  --include '*.[h]' |sed "s/[+-]//g"|sed "s/[();,: *\^\/\{]/ /g"|sed "s/[ ]*</</"| sed "/^[ ]*IBAction/d"|awk '{split($0,b," "); print b[2]; }'| sort|uniq |sed "/^$/d" >$STRING_SYMBOL_FILE

rm -f $HEAD_FILE

touch $HEAD_FILE
echo '#ifndef Demo_codeObfuscation_h
#define Demo_codeObfuscation_h' >> $HEAD_FILE
echo "//confuse string at `date`" >> $HEAD_FILE
cat "$STRING_SYMBOL_FILE" | while read -ra line; do
if [[ ! -z "$line" ]]; then
ramdom=`ramdomString`
echo $line $ramdom
insertValue $line $ramdom
echo "#define $line $ramdom" >> $HEAD_FILE
fi
done
echo "#endif" >> $HEAD_FILE
