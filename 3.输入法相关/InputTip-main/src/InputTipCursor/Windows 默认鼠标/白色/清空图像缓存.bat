@echo off
echo 正在重建图标缓存，请稍候...
taskkill /f /im explorer.exe
attrib -h -s -r "%userprofile%\AppData\Local\IconCache.db"
del /f "%userprofile%\AppData\Local\IconCache.db"
start explorer.exe
echo 操作完成！
pause