@echo off
chcp 65001 >nul
echo ========================================
echo 推送用户端代码到 GitHub
echo ========================================
echo.

echo 仓库信息:
echo   用户端前端: git@github.com:nietianqi/douyin.git
echo   用户端后端: git@github.com:nietianqi/douyin_backend.git
echo   分支: claude/design-java-backend-5SUIM
echo.

echo 当前工作目录: %CD%
echo.

echo ========================================
echo [1/2] 推送用户端前端代码
echo ========================================
echo.

REM 确定用户端前端的实际路径
REM 根据实际情况，用户端前端可能在以下位置之一：
REM 1. F:\douyin\douyin_frontend (用户期望的位置)
REM 2. 当前 WSL 映射：需要在 Windows 下确认

echo 注意：用户端前端代码在 WSL 的 /home/user/douyin
echo       在 Windows 下可能需要通过 \\wsl$\Ubuntu\home\user\douyin 访问
echo.

echo 请选择操作方式：
echo   1. 我已将代码复制到 Windows 可访问的位置（如 F:\douyin\douyin_frontend）
echo   2. 通过 WSL 路径访问
echo.

set /p choice="请输入选择 (1 或 2): "

if "%choice%"=="1" (
    set /p frontend_path="请输入用户端前端代码的完整路径: "
    cd /d "%frontend_path%"

    if not exist .git (
        echo.
        echo ❌ 错误：该目录不是 Git 仓库
        echo.
        pause
        exit /b 1
    )

    echo.
    echo 检查 Git 状态...
    git status

    echo.
    echo 配置远程仓库...
    git remote set-url origin git@github.com:nietianqi/douyin.git

    echo.
    echo 开始推送...
    git push -u origin claude/design-java-backend-5SUIM

    if %errorlevel% neq 0 (
        echo.
        echo ❌ 前端推送失败！
        echo.
        pause
        exit /b 1
    )

    echo ✅ 前端推送成功！

) else if "%choice%"=="2" (
    echo.
    echo 通过 WSL 访问需要特殊处理...
    echo 建议使用 Git Bash 或 WSL 终端执行推送
    echo.
    echo 在 Git Bash 中执行：
    echo   cd /home/user/douyin
    echo   git push -u origin claude/design-java-backend-5SUIM
    echo.
    pause
    exit /b 0
)

echo.

echo ========================================
echo [2/2] 推送用户端后端代码
echo ========================================
echo.

echo 注意：未找到用户端后端代码
echo.
echo 请确认用户端后端代码的位置：
echo   期望位置: F:\douyin\douyin_backend
echo   实际位置: （需要确认）
echo.

set /p backend_exists="用户端后端代码是否存在？(y/n): "

if /i "%backend_exists%"=="y" (
    set /p backend_path="请输入用户端后端代码的完整路径: "
    cd /d "%backend_path%"

    if not exist .git (
        echo.
        echo 初始化 Git 仓库...
        git init
        git add .
        git commit -m "feat: 用户端后端初始提交"
        git branch -M claude/design-java-backend-5SUIM
    )

    echo.
    echo 配置远程仓库...
    git remote remove origin 2>nul
    git remote add origin git@github.com:nietianqi/douyin_backend.git

    echo.
    echo 检查 Git 状态...
    git status

    echo.
    echo 开始推送...
    git push -u origin claude/design-java-backend-5SUIM

    if %errorlevel% neq 0 (
        echo.
        echo ❌ 后端推送失败！
        echo.
        pause
        exit /b 1
    )

    echo ✅ 后端推送成功！

) else (
    echo.
    echo ⚠️ 用户端后端代码不存在
    echo.
    echo 建议：
    echo 1. 确认后端代码是否已开发
    echo 2. 如需开发，请联系开发团队
    echo 3. 如果后端代码在其他位置，请手动推送
    echo.
)

echo.
echo ========================================
echo 推送完成
echo ========================================
echo.

if /i "%backend_exists%"=="y" (
    echo GitHub 仓库地址:
    echo   用户端前端: https://github.com/nietianqi/douyin/tree/claude/design-java-backend-5SUIM
    echo   用户端后端: https://github.com/nietianqi/douyin_backend/tree/claude/design-java-backend-5SUIM
) else (
    echo GitHub 仓库地址:
    echo   用户端前端: https://github.com/nietianqi/douyin/tree/claude/design-java-backend-5SUIM
    echo   用户端后端: ⚠️ 未推送
)

echo.
pause
