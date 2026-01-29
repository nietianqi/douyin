// 检查构建配置的脚本
const fs = require('fs');
const path = require('path');

console.log('====================================');
console.log('检查构建配置');
console.log('====================================\n');

// 1. 检查 .env.production 文件
const envProdPath = path.join(__dirname, '.env.production');
if (fs.existsSync(envProdPath)) {
  console.log('✅ .env.production 文件存在');
  console.log('内容:', fs.readFileSync(envProdPath, 'utf-8'));
} else {
  console.log('❌ .env.production 文件不存在');
}

// 2. 检查 src/config/index.ts
const configPath = path.join(__dirname, 'src/config/index.ts');
if (fs.existsSync(configPath)) {
  const content = fs.readFileSync(configPath, 'utf-8');
  console.log('\n✅ src/config/index.ts 配置:');

  // 提取 BASE_URL_MAP
  const match = content.match(/BASE_URL_MAP\s*=\s*{([^}]+)}/);
  if (match) {
    console.log('BASE_URL_MAP:', match[0]);
  }

  // 检查是否有 localhost
  if (content.includes('localhost:8080')) {
    console.log('\n⚠️  警告: 配置中仍包含 localhost:8080');
  } else {
    console.log('\n✅ 配置中没有 localhost:8080');
  }
}

// 3. 检查 dist 目录（如果存在）
const distPath = path.join(__dirname, 'dist');
if (fs.existsSync(distPath)) {
  console.log('\n✅ dist 目录存在');

  // 查找 JS 文件
  const jsDir = path.join(distPath, 'js');
  if (fs.existsSync(jsDir)) {
    const jsFiles = fs.readdirSync(jsDir);
    console.log(`\n找到 ${jsFiles.length} 个 JS 文件`);

    // 检查是否包含 localhost
    let hasLocalhost = false;
    jsFiles.forEach(file => {
      const content = fs.readFileSync(path.join(jsDir, file), 'utf-8');
      if (content.includes('localhost:8080')) {
        hasLocalhost = true;
        console.log(`❌ ${file} 包含 localhost:8080`);
      }
    });

    if (!hasLocalhost) {
      console.log('✅ 所有 JS 文件都不包含 localhost:8080');
    }
  }
} else {
  console.log('\n⚠️  dist 目录不存在，需要先构建');
}

console.log('\n====================================');
console.log('建议操作:');
console.log('====================================');
console.log('1. 确认 src/config/index.ts 中 PROD: \'/api\'');
console.log('2. 删除 dist 目录: rm -rf dist');
console.log('3. 重新构建: npm run build');
console.log('4. 检查构建结果: node check-build-config.js');
console.log('5. 上传到服务器');
console.log('====================================\n');
