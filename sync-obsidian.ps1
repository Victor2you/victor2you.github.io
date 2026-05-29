# sync-obsidian.ps1
# Obsidian 41_Drafts_Articles의 blog_*.md 파일을 Quartz content/에 동기화
# 사용법: .\sync-obsidian.ps1

$source = "C:\Users\victo\Obsidian\Victor-Book\04_Output\41_Drafts_Articles"
$dest = "$PSScriptRoot\content"

Write-Host "📂 Obsidian → Quartz 동기화 시작..." -ForegroundColor Cyan

# blog_*.md 파일만 복사 (linkedin_* 제외)
$files = Get-ChildItem "$source\blog_*.md" -ErrorAction SilentlyContinue
if ($files.Count -eq 0) {
    Write-Host "⚠️  복사할 blog_*.md 파일이 없습니다." -ForegroundColor Yellow
    exit 1
}

foreach ($file in $files) {
    Copy-Item $file.FullName -Destination $dest -Force
    Write-Host "  ✅ 복사됨: $($file.Name)" -ForegroundColor Green
}

Write-Host ""
Write-Host "✨ 동기화 완료! 변경사항을 커밋하려면:" -ForegroundColor Cyan
Write-Host "   git add content/" -ForegroundColor Gray
Write-Host "   git commit -m 'sync: update blog articles from Obsidian'" -ForegroundColor Gray
Write-Host "   git push" -ForegroundColor Gray
