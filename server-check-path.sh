#!/bin/bash

echo "========================================="
echo "检查前端文件部署路径"
echo "========================================="
echo ""

# 从 nginx 配置中查找 root 路径
echo "1. 检查 nginx 配置的 root 路径："
NGINX_ROOT=$(grep -r "root.*douyin" /etc/nginx/nginx.conf /etc/nginx/conf.d/*.conf 2>/dev/null | grep -v "#" | head -1 | awk '{print $2}' | tr -d ';')

if [ -n "$NGINX_ROOT" ]; then
    echo "   nginx root 路径: $NGINX_ROOT"
else
    echo "   未找到配置，请手动检查 nginx.conf"
fi

echo ""
echo "2. 检查该路径下的文件："
if [ -d "$NGINX_ROOT" ]; then
    echo "   ✅ 目录存在"
    ls -lh "$NGINX_ROOT" | head -10
    echo ""
    echo "   文件修改时间："
    ls -lt "$NGINX_ROOT" | head -5

    echo ""
    echo "3. 检查 JS 文件："
    if [ -d "$NGINX_ROOT/js" ]; then
        JS_COUNT=$(ls "$NGINX_ROOT/js"/*.js 2>/dev/null | wc -l)
        echo "   JS 文件数量: $JS_COUNT"
        ls -lh "$NGINX_ROOT/js" | head -5

        echo ""
        echo "4. 检查 JS 文件中是否包含 localhost:"
        if grep -r "localhost:8080" "$NGINX_ROOT/js/" 2>/dev/null; then
            echo "   ❌ 发现 localhost:8080（需要重新构建和上传）"
        else
            echo "   ✅ 没有 localhost:8080"
        fi
    else
        echo "   ❌ js 目录不存在"
    fi
else
    echo "   ❌ 目录不存在: $NGINX_ROOT"
fi

echo ""
echo "========================================="
echo "5. 检查可能的其他路径："
echo "========================================="
find /var/www /usr/share/nginx /home -maxdepth 3 -type d -name "*douyin*" 2>/dev/null | while read dir; do
    if [ -f "$dir/index.html" ]; then
        echo "找到前端项目: $dir"
        ls -lh "$dir" | head -5
        echo ""
    fi
done

echo ""
echo "========================================="
echo "解决方案："
echo "========================================="
echo "1. 确认 nginx 的 root 路径"
echo "2. 上传到正确的路径"
echo "3. 或修改 nginx 配置指向正确的路径"
echo ""
echo "示例命令："
echo "  scp -r dist/* root@43.161.216.248:$NGINX_ROOT/"
echo "  或"
echo "  rsync -avz --delete dist/ root@43.161.216.248:$NGINX_ROOT/"
echo ""
