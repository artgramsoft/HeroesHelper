rd /s /q .\release
md .\release
copy .\heroes.exe .\release\
copy .\heroes_x86.exe .\release\
copy .\heroes.ini .\release\
copy .\pipet.png .\release\
copy .\msvcr100.dll .\release\
copy .\screenshot_manager.exe .\release\
xcopy .\heroes\*.* .\release\heroes\ /e /h /k /y