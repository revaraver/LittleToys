#### 0.AHK2Manager_x64 多脚本管理 (非自制)
#### 1.EngComma_swich 输入法自动切换英文标点
#### 2.Cubase_ShiftScrollInverse Cubase下shift+鼠标滚轮反转
#### 3.AlwaysCHS(非自制)
#### 4.ijkluoCaps
#### 5.keyboard_godot


一些可能有的狂暴吐槽可无视

0.多脚本管理 AHK2Manager
https://github.com/Jvcon/AHK2Manager

1.输入法自动切换英文标点

傻逼微软十年不改win10下中文输入英文标点的bug,具体表现是开启后完全没效果.每次都需要手动切换为英文符号
兼容性模式下的话,又tm有10次里面有9次没法调出中文输入界面,每次写完代码需要输入中文的时候需要狂按ctrl+space一万次.并且有时候还需要补充win+space.并且百分百第一次输入汉字时不显示汉字候选框真jb牛逼

用autohotkey写的,原理是检测到输入法切换事件完成后自动补充一个ctrl+.快捷键切换为英文标点
需要满足的前提是使用win+space切换输入法

2.Cubase下shift+鼠标滚轮反转

Cubuse的shift+滚轮操作方向与正经软件相反，有时候真不知道这群人脑子里装的是什么

3.永远中文输入法只能输入中文,别瞎几把乱跳英文(非自制)
https://gist.github.com/pernalin9/220d00016182acb7f13b96cd0506c0a9

4.5自用改键与godot对于不兼容输入法的单独提取(2024_07_16 17:00:22修正 添加了#用来限制代码的生命周期)