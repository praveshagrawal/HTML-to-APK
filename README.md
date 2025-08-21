<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
  <meta charset="UTF-8">
  <title>HANZO — مولّد زخرفة الأسماء</title>
  <style>
    body {
      font-family: "Arial", sans-serif;
      background: #111;
      color: #eee;
      text-align: center;
      padding: 20px;
    }
    h1 {
      font-size: 3rem;
      color: #ff0066;
      text-shadow: 0 0 10px #ff3399, 0 0 20px #ff66cc;
      margin-bottom: 0;
    }
    h2 {
      font-size: 1.2rem;
      color: #ccc;
      margin-top: 5px;
      margin-bottom: 20px;
    }
    input {
      padding: 10px;
      font-size: 1rem;
      border-radius: 10px;
      border: none;
      width: 250px;
      text-align: center;
    }
    button {
      padding: 10px 20px;
      margin: 10px;
      font-size: 1rem;
      border: none;
      border-radius: 10px;
      background: #ff0066;
      color: white;
      cursor: pointer;
    }
    button:hover {
      background: #ff3385;
    }
    .result {
      margin: 15px auto;
      padding: 10px;
      background: #222;
      border-radius: 12px;
      box-shadow: 0 0 5px #555;
      width: 90%;
      max-width: 400px;
      font-size: 1.2rem;
      word-wrap: break-word;
    }
  </style>
</head>
<body>
  <h1>HANZO</h1>
  <h2>مولّد زخرفة الأسماء</h2>
  
  <input type="text" id="nameInput" placeholder="أدخل اسمك هنا">
  <button onclick="generate()">توليد</button>
  <button onclick="copyAll()">نسخ كل النتائج</button>
  <button onclick="randomOne()">زخرفة عشوائية</button>

  <div id="results"></div>

  <script>
    // زخارف الرموز
    const patterns = [
      "✦✧ {n} ✧✦","★彡 {n} 彡★","♛ {n} ♛","☬ {n} ☬","卍 {n} 卍",
      "꧁༺ {n} ༻꧂","『 {n} 』","【 {n} 】","︵‿︵‿୨♡୧‿︵‿︵ {n}",
      "♥‿♥ {n} ♥‿♥","★·.·´¯`·.·★ {n} ★·.·´¯`·.·★","✿◕ ‿ ◕✿ {n} ✿◕ ‿ ◕✿",
      "☾✩ {n} ✩☽","⚡🔥 {n} 🔥⚡","🦋 {n} 🦋","✪✪ {n} ✪✪",
      "❤❥❣ {n} ❣❥❤","➳➶➴➵ {n} ➵➴➶➳","☠💀 {n} 💀☠","⚔🗡 {n} 🗡⚔",
      "👑👑 {n} 👑👑","🌹✿ {n} ✿🌹","◤✞ {n} ✞◥","༺✦ {n} ✦༻",
      "▄▀▄▀▄ {n} ▀▄▀▄▀","◥✰◤ {n} ◥✰◤","░▒▓█ {n} █▓▒░","⇝⇝ {n} ⇜⇜",
      "↤↤ {n} ↦↦","☆*:・°★ {n} ★°・:*☆","｡☆✼★━━━━━━★✼☆｡ {n}",
      "❖━━━❖ {n} ❖━━━❖","✘✘ {n} ✘✘","웃❤유 {n} 웃❤유",
      "♜♞ {n} ♞♜","ミ★ {n} ★彡","◦•●◉✿ {n} ✿◉●•◦",
      "๑۩۩๑ {n} ๑۩۩๑","ღ {n} ღ","✧༚ {n} ༚✧",
    ];

    // زخارف الحروف (كبير وصغير)
    const fontMaps = {
      fancy1: { H:"ℌ", h:"ℌ", A:"𝔄", a:"𝔄", N:"𝔑", n:"𝔑", Z:"ℨ", z:"ℨ", O:"𝔒", o:"𝔒" },
      fancy2: { H:"н", h:"н", A:"α", a:"α", N:"и", n:"и", Z:"z", z:"z", O:"σ", o:"σ" },
      fancy3: { H:"ʜ", h:"ʜ", A:"ᴀ", a:"ᴀ", N:"ɴ", n:"ɴ", Z:"ᴢ", z:"ᴢ", O:"ᴏ", o:"ᴏ" },
      fancy4: { H:"Ｈ", h:"Ｈ", A:"Ａ", a:"Ａ", N:"Ｎ", n:"Ｎ", Z:"Ｚ", z:"Ｚ", O:"Ｏ", o:"Ｏ" },
      fancy5: { H:"Ħ", h:"Ħ", A:"₳", a:"₳", N:"₦", n:"₦", Z:"Ⱬ", z:"Ⱬ", O:"Ø", o:"Ø" },
      fancy6: { H:"𝓗", h:"𝓗", A:"𝓐", a:"𝓐", N:"𝓝", n:"𝓝", Z:"𝓩", z:"𝓩", O:"𝓞", o:"𝓞" },
      fancy7: { H:"ʍ", h:"ʍ", A:"ค", a:"ค", N:"ภ", n:"ภ", Z:"չ", z:"չ", O:"๏", o:"๏" },
      fancy8: { H:"Ḧ", h:"Ḧ", A:"Ã", a:"ã", N:"Ń", n:"ń", Z:"Ẑ", z:"ẑ", O:"Õ", o:"õ" },
      fancy9: { H:"Ң", h:"Ң", A:"Δ", a:"Δ", N:"П", n:"п", Z:"乙", z:"乙", O:"Ө", o:"ө" },
      fancy10: { H:"♓", h:"♓", A:"Λ", a:"Λ", N:"П", n:"п", Z:"ℤ", z:"ℤ", O:"◎", o:"◎" },
      fancy11: { H:"Һ", h:"Һ", A:"ą", a:"ą", N:"и", n:"и", Z:"ʑ", z:"ʑ", O:"ơ", o:"ơ" },
      fancy12: { H:"Ĥ", h:"Ĥ", A:"Λ", a:"Λ", N:"И", n:"и", Z:"Ž", z:"ž", O:"Θ", o:"θ" },
      fancy13: { H:"♅", h:"♅", A:"Ḁ", a:"Ḁ", N:"И", n:"и", Z:"Ẕ", z:"Ẕ", O:"Ѻ", o:"Ѻ" },
      fancy14: { H:"н", h:"н", A:"ą", a:"ą", N:"η", n:"η", Z:"ƶ", z:"ƶ", O:"ø", o:"ø" },
      fancy15: { H:"Ħ", h:"Ħ", A:"Â", a:"Â", N:"Й", n:"й", Z:"Ž", z:"ž", O:"Ỗ", o:"ỗ" }
    };

    function applyFont(name, font) {
      return name.split("").map(ch => font[ch] || ch).join("");
    }

    function generate() {
      const name = document.getElementById("nameInput").value.trim();
      const resultsDiv = document.getElementById("results");
      resultsDiv.innerHTML = "";
      if (!name) return;

      // أنماط الحروف المزخرفة
      Object.values(fontMaps).forEach(font => {
        addResult(applyFont(name, font), resultsDiv);
      });

      // أنماط الرموز
      patterns.forEach(p => {
        addResult(p.replace("{n}", name), resultsDiv);
      });
    }

    function addResult(text, resultsDiv) {
      const div = document.createElement("div");
      div.className = "result";
      div.textContent = text;

      const copyBtn = document.createElement("button");
      copyBtn.textContent = "نسخ";
      copyBtn.onclick = () => {
        navigator.clipboard.writeText(text);
        copyBtn.textContent = "✓";
        setTimeout(() => copyBtn.textContent = "نسخ", 1500);
      };

      div.appendChild(document.createElement("br"));
      div.appendChild(copyBtn);
      resultsDiv.appendChild(div);
    }

    function copyAll() {
      const all = Array.from(document.querySelectorAll(".result"))
        .map(r => r.textContent.replace("نسخ", "").trim())
        .join("\n");
      navigator.clipboard.writeText(all);
      alert("تم نسخ كل الزخارف!");
    }

    function randomOne() {
      const name = document.getElementById("nameInput").value.trim();
      if (!name) return;
      const resultsDiv = document.getElementById("results");
      resultsDiv.innerHTML = "";

      if (Math.random() < 0.5) {
        const font = Object.values(fontMaps)[Math.floor(Math.random() * Object.values(fontMaps).length)];
        addResult(applyFont(name, font), resultsDiv);
      } else {
        const p = patterns[Math.floor(Math.random() * patterns.length)];
        addResult(p.replace("{n}", name), resultsDiv);
      }
    }

    // توليد تلقائي لاسم HANZO عند فتح الصفحة
    window.onload = () => {
      document.getElementById("nameInput").value = "HANZO";
      generate();
    };
  </script>
</body>
</html>
