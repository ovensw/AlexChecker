document.addEventListener('DOMContentLoaded', function() {
  const decodeButton = document.getElementById('decodeButton');
  if (decodeButton) {
    decodeButton.addEventListener('click', function() {
      const codeInput = document.getElementById('codeInput');
      const code = codeInput.value.trim();
      if (!code) {
        alert('\u041f\u043e\u0436\u0430\u043b\u0443\u0439\u0441\u0442\u0430, \u0432\u0441\u0442\u0430\u0432\u044c\u0442\u0435 \u043a\u043e\u0434.');
        return;
      }
      try {
        const decoded = atob(code);
        document.getElementById('results').style.display = 'block';
        document.getElementById('infoOutput').textContent = decoded;
        generateRecommendations(decoded);
      } catch (err) {
        alert('\u041d\u0435\u0432\u0435\u0440\u043d\u044b\u0439 \u043a\u043e\u0434. \u0423\u0431\u0435\u0434\u0438\u0442\u0435\u0441\u044c, \u0447\u0442\u043e \u0432\u044b \u0432\u0441\u0442\u0430\u0432\u0438\u043b\u0438 \u043f\u0440\u0430\u0432\u0438\u043b\u044c\u043d\u0443\u044e \u0441\u0442\u0440\u043e\u043a\u0443.');
      }
    });
  }
});

function generateRecommendations(info) {
  const recs = [];
  // Recommend OS upgrade for Windows 7 or 8
  if (/Windows\s*7|Windows\s*8/i.test(info)) {
    recs.push('\u041e\u0431\u043d\u043e\u0432\u0438\u0442\u0435 \u043e\u043f\u0435\u0440\u0430\u0446\u0438\u043e\u043d\u043d\u0443\u044e \u0441\u0438\u0441\u0442\u0435\u043c\u0443 \u0434\u043e Windows 10 \u0438\u043b\u0438 11.');
  }
  // Check memory size if available (in MB)
  const memMatch = info.match(/Total Physical Memory:\s*([\d,]+)\s*MB/i);
  if (memMatch) {
    const memStr = memMatch[1].replace(',', '');
    const memMB = parseInt(memStr, 10);
    if (!isNaN(memMB) && memMB < 4096) {
      recs.push('\u0414\u043e\u0431\u0430\u0432\u044c\u0442\u0435 \u0431\u043e\u043b\u044c\u0448\u0435 \u043e\u043f\u0435\u0440\u0430\u0442\u0438\u0432\u043d\u043e\u0439 \u043f\u0430\u043c\u044f\u0442\u0438 (\u0440\u0435\u043a\u043e\u043c\u0435\u043d\u0434\u0443\u0435\u0442\u0441\u044f 8 \u0413\u0411 \u0438\u043b\u0438 \u0431\u043e\u043b\u0435\u0435).');
    }
  }
  // Default message if no recommendations
  if (recs.length === 0) {
    recs.push('\u0421\u0438\u0441\u0442\u0435\u043c\u0430 \u0432 \u0445\u043e\u0440\u043e\u0448\u0435\u043c \u0441\u043e\u0441\u0442\u043e\u044f\u043d\u0438\u0438 \u0438\u043b\u0438 \u0434\u043e\u043f\u043e\u043b\u043d\u0438\u0442\u0435\u043b\u044c\u043d\u044b\u0435 \u0440\u0435\u043a\u043e\u043c\u0435\u043d\u0434\u0430\u0446\u0438\u0438 \u043e\u0442\u0441\u0443\u0442\u0441\u0442\u0432\u0443\u044e\u0442.');
  }
  const list = document.getElementById('recommendations');
  list.innerHTML = '';
  recs.forEach(function(rec) {
    const li = document.createElement('li');
    li.textContent = rec;
    list.appendChild(li);
  });
}
