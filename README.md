#  代码混淆说明

1、禁止混淆系统方法，包括和系统方法一样的方法，否则会导致编译报错。

2、禁止混淆realonly属性，因为realonly属性set时只能用下划线，编译时下划线无法作为指针来找到对应的属性，这样会导致编译报错。


#  代码混淆步骤

1、在target中找到Build Phases，点击左上角的“+”号，选择“New Run Script Phases”,创建一个新的脚本，并在脚本中实现“ $PROJECT_DIR/脚本名称.sh ”，用于指定加载脚本的绝对路径,例如 “$PROJECT_DIR/CodeConfuseScript.sh”，注意这里的$PROJECT_DIR表示指定到工程的根目录，即：.sh的脚本需要放置于工程根目录下，如果不放于根目录，则脚本中的绝对路径则需要根据实际情况更改。

2、将CodeConfuseScript.sh脚本放置于工程根目录中，并打开工程，选择“Add Files To 工程名称...”，把根目录中的CodeConfuseScript.sh脚本放入工程中。

3、打开CodeConfuseScript.sh脚本，脚本内容详见CodeConfuseScript.sh文件，需要根据实际情况对脚本进行更改，其中更改的点为“STRING_SYMBOL_FILE”、“CONFUSE_FILE”、和“HEAD_FILE”。“STRING_SYMBOL_FILE”为脚本创建一个名为func.list的文件的指定的绝对路径，“CONFUSE_FILE”为根目录下的下级目录（和工程名称同名的文件夹）。“HEAD_FILE”是指定脚本编译后穿甲的一个名为codeObfuscation.h的头文件的绝对路径。

4、command+B编译工程，如果编译成功，则在步骤（3）中所指定的func.list和codeObfuscation.h文件的绝对路径下会出现相应的文件。打开工程，选择“Add Files To 工程名称...”，把func.list和codeObfuscation.h文件添加到工程中。

5、把工程中需要混淆的方法或者属性名称分别填入func.list和codeObfuscation.h文件。注意，这里填入的格式不一样，由于脚本是利用桥接文件把工程中要混淆的内容进行宏替换，所以func.list只需要填入要混淆的内容，例如：“insertValueInArray”,而codeObfuscation.h文件则需要填入宏定义的混淆内容，例如：“#define insertValueInArray     oweiufoaswehfosefjsf”,这样在编译时，会动态把“oweiufoaswehfosefjsf”替换掉原本的“insertValueInArray”。

6、编译成功后，脚本默认会把func.list和codeObfuscation.h文件的内容清除。

#  代码混淆建议
监狱脚本中已经存在一个对工程文件过滤写入的功能，所以所有的属性名称和方法名称，建议使用前缀加“_”，例如：“@property (nonatomic, copy) NSString *hsy_filePath”,这样脚本会直接把索引到所有满足“hsy_”的属性名和方法名称都写入func.list和codeObfuscation.h文件中，然后只需要对codeObfuscation.h的补充完整宏定义即可。

