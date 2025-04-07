# WZ_FIX Utility

## Русский 🇷🇺

### О программе
WZ_FIX - это утилита, разработанная для игроков Call of Duty: Warzone, которая временно останавливает работу сервисов VPN и анти-цензуры (таких как WinDivert, GoodbyeDPI и другие), мешающих нормальной работе игры. После закрытия утилиты все сервисы автоматически восстанавливаются.

### Функции
- Автоматически определяет и останавливает сервисы WinDivert, GoodbyeDPI и zapret
- Запускает игру через Steam
- Восстанавливает все сервисы при закрытии утилиты
- Требует прав администратора

### Использование
1. Запустите WZ_FIX.bat от имени администратора
2. Утилита автоматически запустит игру и свернется
3. После завершения игры нажмите ENTER в окне утилиты для восстановления сервисов

### Важно
- Утилита работает только при запуске с правами администратора

### Исправление проблем
Если у вас возникает ошибка: `"C:\Users\<username>\AppData\Local\Temp\wz_fix_cleanup.bat" не является внутренней или внешней командой, исполняемой программой или пакетным файлом`, выполните следующие шаги:

1. Откройте командную строку от имени администратора
2. Выполните команду: `reg delete "HKCU\Software\Microsoft\Command Processor" /v AutoRun /f`
3. После этого используйте WZ_FIX.bat

---

## English 🇬🇧

### About
WZ_FIX is a utility designed for Call of Duty: Warzone players that temporarily stops VPN and anti-censorship services (such as WinDivert, GoodbyeDPI, and others) that may interfere with the game's normal operation. When the utility is closed, all services are automatically restored.

### Features
- Automatically detects and stops WinDivert, GoodbyeDPI, and zapret services
- Launches the game through Steam
- Restores all services when the utility is closed
- Requires administrator privileges

### Usage
1. Run WZ_FIX.bat as administrator
2. The utility will automatically launch the game and minimize itself
3. After finishing the game, press ENTER in the utility window to restore services

### Important
- The utility only works when run with administrator privileges

### Troubleshooting
If you encounter the error: `"C:\Users\<username>\AppData\Local\Temp\wz_fix_cleanup.bat" is not recognized as an internal or external command, operable program or batch file`, follow these steps:

1. Open command prompt as administrator
2. Execute the command: `reg delete "HKCU\Software\Microsoft\Command Processor" /v AutoRun /f`
3. After that, use WZ_FIX.bat