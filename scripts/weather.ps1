# LA 날씨 + 미세먼지를 weather.txt 맨 아래에 추가합니다. (Open-Meteo, API 키 불필요)
$ErrorActionPreference = 'Stop'
$out = Join-Path $PSScriptRoot '..\weather.txt'
$utf8 = New-Object System.Text.UTF8Encoding($true)   # 새 파일일 때만 BOM이 붙어 메모장에서도 한글이 안 깨짐
$lat = 34.0522; $lon = -118.2437; $tz = 'America%2FLos_Angeles'

$codes = @{
  0='맑음'; 1='대체로 맑음'; 2='구름 조금'; 3='흐림'; 45='안개'; 48='서리 안개'
  51='약한 이슬비'; 53='이슬비'; 55='강한 이슬비'; 61='약한 비'; 63='비'; 65='강한 비'
  71='약한 눈'; 73='눈'; 75='강한 눈'; 80='약한 소나기'; 81='소나기'; 82='강한 소나기'
  95='뇌우'; 96='우박 동반 뇌우'; 99='강한 우박 동반 뇌우'
}
function F2C($f) { [math]::Round(($f - 32) * 5 / 9, 1) }
function AqiLabel($v) {
  if     ($v -le 50)  { '좋음' } elseif ($v -le 100) { '보통' }
  elseif ($v -le 150) { '민감군 나쁨' } elseif ($v -le 200) { '나쁨' }
  elseif ($v -le 300) { '매우 나쁨' } else { '위험' }
}

try {
  $w = Invoke-RestMethod ("https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon" +
    "&current=temperature_2m,apparent_temperature,relative_humidity_2m,weather_code,wind_speed_10m" +
    "&daily=temperature_2m_max,temperature_2m_min,precipitation_probability_max" +
    "&temperature_unit=fahrenheit&wind_speed_unit=mph&timezone=$tz&forecast_days=1")
  $a = Invoke-RestMethod ("https://air-quality-api.open-meteo.com/v1/air-quality?latitude=$lat&longitude=$lon" +
    "&current=us_aqi,pm2_5,pm10&timezone=$tz")

  $c = $w.current; $d = $w.daily; $q = $a.current
  $desc = $codes[[int]$c.weather_code]; if (-not $desc) { $desc = "코드 $($c.weather_code)" }
  $text = @"
==== $($c.time.Replace('T',' ')) (Los Angeles, CA) ====
날씨      : $desc
기온      : $($c.temperature_2m)°F ($(F2C $c.temperature_2m)°C) / 체감 $($c.apparent_temperature)°F ($(F2C $c.apparent_temperature)°C)
오늘      : 최고 $($d.temperature_2m_max[0])°F ($(F2C $d.temperature_2m_max[0])°C) / 최저 $($d.temperature_2m_min[0])°F ($(F2C $d.temperature_2m_min[0])°C)
습도·바람 : 습도 $($c.relative_humidity_2m)% / 바람 $($c.wind_speed_10m) mph
강수확률  : $($d.precipitation_probability_max[0])%
미세먼지  : US AQI $($q.us_aqi) ($(AqiLabel $q.us_aqi)) / PM2.5 $($q.pm2_5) µg/m³ / PM10 $($q.pm10) µg/m³

"@
} catch {
  $text = "==== $(Get-Date -Format 'yyyy-MM-dd HH:mm') (Los Angeles, CA) ====`r`n[오류] 가져오지 못했어요: $($_.Exception.Message)`r`n`r`n"
}

[System.IO.File]::AppendAllText($out, $text, $utf8)
Write-Output $text
