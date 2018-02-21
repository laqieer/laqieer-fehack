在给定代码段搜索IDA未自动探测到的函数。
需要根据具体rom设定代码段的结束地址。
已知问题：IDA自动检测函数结尾有时候会得出错误的结果，出现很多nullsub_xx等垃圾函数。

Seek and add undetected functions in .text section.
Set the end address of .text section according to your game rom image.
Known issue: IDA auto-detected function end address is not always true. Many trash functions like nullsub_xx will come out.