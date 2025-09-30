<html lang="fa" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>دستیار هوشمند گوشی</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .chat-bubble {
            animation: slideIn 0.3s ease-out;
        }
        
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .pulse-animation {
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
        }
        
        .voice-wave {
            animation: wave 1.5s ease-in-out infinite;
        }
        
        @keyframes wave {
            0%, 100% {
                height: 20px;
            }
            50% {
                height: 40px;
            }
        }
    </style>
</head>
<body class="bg-gradient-to-br from-blue-900 via-purple-900 to-indigo-900 min-h-screen">
    <!-- Phone Frame -->
    <div class="flex justify-center items-center min-h-screen p-4">
        <div class="bg-black rounded-3xl p-2 shadow-2xl max-w-sm w-full">
            <!-- Screen -->
            <div class="bg-gray-900 rounded-2xl overflow-hidden h-[700px] relative">
                <!-- Status Bar -->
                <div class="bg-gray-800 px-4 py-2 flex justify-between items-center text-white text-sm">
                    <div class="flex items-center gap-1">
                        <div class="w-4 h-2 bg-green-500 rounded-sm"></div>
                        <span>۹:۴۱</span>
                    </div>
                    <div class="flex items-center gap-1">
                        <span>۱۰۰٪</span>
                        <div class="w-6 h-3 border border-white rounded-sm">
                            <div class="w-full h-full bg-green-500 rounded-sm"></div>
                        </div>
                    </div>
                </div>

                <!-- Assistant Header -->
                <div class="bg-gradient-to-r from-blue-600 to-purple-600 p-4 text-center">
                    <div class="w-16 h-16 bg-white rounded-full mx-auto mb-2 flex items-center justify-center text-2xl pulse-animation">
                        🤖
                    </div>
                    <h1 class="text-white text-xl font-bold">🧠 دستیار هوش مصنوعی</h1>
                    <p class="text-blue-100 text-sm">با قابلیت یادگیری و تحلیل هوشمند</p>
                </div>

                <!-- Chat Area -->
                <div id="chatArea" class="flex-1 p-4 space-y-3 overflow-y-auto h-96">
                    <div class="chat-bubble">
                        <div class="bg-gray-700 text-white p-3 rounded-2xl rounded-tr-sm max-w-xs">
                            سلام! چطور می‌تونم کمکتون کنم؟
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="px-4 pb-4">
                    <div class="grid grid-cols-2 gap-2 mb-4">
                        <button onclick="quickAction('weather')" class="bg-blue-600 hover:bg-blue-700 text-white p-3 rounded-xl text-sm transition-colors">
                            🌤️ آب و هوا
                        </button>
                        <button onclick="quickAction('calculate')" class="bg-green-600 hover:bg-green-700 text-white p-3 rounded-xl text-sm transition-colors">
                            🧮 محاسبه
                        </button>
                        <button onclick="quickAction('translate')" class="bg-orange-600 hover:bg-orange-700 text-white p-3 rounded-xl text-sm transition-colors">
                            🌐 ترجمه
                        </button>
                        <button onclick="quickAction('music')" class="bg-purple-600 hover:bg-purple-700 text-white p-3 rounded-xl text-sm transition-colors">
                            🎵 موزیک
                        </button>
                    </div>
                </div>

                <!-- Voice Input -->
                <div class="absolute bottom-4 left-4 right-4">
                    <div class="bg-gray-800 rounded-2xl p-3 flex items-center gap-3">
                        <input 
                            type="text" 
                            id="messageInput"
                            placeholder="پیام خود را بنویسید..."
                            class="flex-1 bg-transparent text-white placeholder-gray-400 outline-none"
                            onkeypress="handleKeyPress(event)"
                        >
                        <button 
                            id="voiceBtn"
                            onclick="toggleVoice()"
                            class="bg-blue-600 hover:bg-blue-700 text-white p-2 rounded-full transition-colors"
                        >
                            🎤
                        </button>
                        <button 
                            onclick="sendMessage()"
                            class="bg-green-600 hover:bg-green-700 text-white p-2 rounded-full transition-colors"
                        >
                            ➤
                        </button>
                    </div>
                </div>

                <!-- Voice Animation -->
                <div id="voiceAnimation" class="hidden absolute bottom-20 left-1/2 transform -translate-x-1/2">
                    <div class="flex items-end gap-1">
                        <div class="w-2 bg-blue-500 voice-wave rounded-full" style="animation-delay: 0s;"></div>
                        <div class="w-2 bg-blue-500 voice-wave rounded-full" style="animation-delay: 0.2s;"></div>
                        <div class="w-2 bg-blue-500 voice-wave rounded-full" style="animation-delay: 0.4s;"></div>
                        <div class="w-2 bg-blue-500 voice-wave rounded-full" style="animation-delay: 0.6s;"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        let isListening = false;
        let messageCount = 1;

        // AI Knowledge Base
        const aiKnowledge = {
            cities: ['تهران', 'اصفهان', 'شیراز', 'مشهد', 'تبریز', 'کرج', 'اهواز', 'قم', 'کرمانشاه', 'ارومیه'],
            weather: ['آفتابی', 'ابری', 'بارانی', 'برفی', 'مه آلود', 'طوفانی'],
            songs: [
                'گل یخ - محسن چاوشی', 'دلم تنگه - گوگوش', 'مرغ سحر - محمدرضا شجریان',
                'یار دبستانی - ایوان بند', 'عاشقانه - رضا صادقی', 'دل دیوانه - سیروان خسروی'
            ],
            facts: [
                'ایران دارای ۳۱ استان است', 'تهران پایتخت ایران است', 'خلیج فارس در جنوب ایران قرار دارد',
                'کوه دماوند بلندترین قله ایران است', 'زبان فارسی از خانواده زبان‌های هندواروپایی است'
            ]
        };

        let conversationHistory = [];
        let userPreferences = {
            favoriteCity: null,
            musicGenre: null,
            name: null
        };

        function analyzeIntent(message) {
            const msg = message.toLowerCase();
            
            // Extract entities
            const entities = {
                cities: aiKnowledge.cities.filter(city => msg.includes(city)),
                numbers: msg.match(/\d+/g) || [],
                timeWords: ['صبح', 'ظهر', 'عصر', 'شب', 'فردا', 'امروز', 'دیروز'].filter(word => msg.includes(word))
            };
            
            // Determine intent
            if (msg.includes('آب و هوا') || msg.includes('هوا')) return { intent: 'weather', entities };
            if (msg.includes('ساعت') || msg.includes('زمان')) return { intent: 'time', entities };
            if (msg.includes('یادآوری') || msg.includes('یادم بیار')) return { intent: 'reminder', entities };
            if (msg.includes('موزیک') || msg.includes('آهنگ')) return { intent: 'music', entities };
            if (msg.includes('محاسبه') || msg.includes('حساب کن')) return { intent: 'calculate', entities };
            if (msg.includes('ترجمه')) return { intent: 'translate', entities };
            if (msg.includes('اسمم') || msg.includes('نامم')) return { intent: 'name', entities };
            if (msg.includes('سلام') || msg.includes('درود')) return { intent: 'greeting', entities };
            if (msg.includes('کمک') || msg.includes('راهنما')) return { intent: 'help', entities };
            
            return { intent: 'general', entities };
        }

        function generateAIResponse(message) {
            const analysis = analyzeIntent(message);
            conversationHistory.push({ user: message, intent: analysis.intent });
            
            // Keep conversation history limited
            if (conversationHistory.length > 10) {
                conversationHistory = conversationHistory.slice(-10);
            }
            
            switch (analysis.intent) {
                case 'weather':
                    return generateWeatherResponse(analysis.entities);
                    
                case 'time':
                    return generateTimeResponse(analysis.entities);
                    
                case 'reminder':
                    return generateReminderResponse(analysis.entities, message);
                    
                case 'music':
                    return generateMusicResponse(analysis.entities);
                    
                case 'calculate':
                    return generateCalculationResponse(message);
                    
                case 'translate':
                    return generateTranslationResponse(message);
                    
                case 'name':
                    return handleNameConversation(message);
                    
                case 'greeting':
                    return generatePersonalizedGreeting();
                    
                case 'help':
                    return generateHelpResponse();
                    
                default:
                    return generateContextualResponse(message);
            }
        }

        function generateWeatherResponse(entities) {
            const city = entities.cities[0] || 'تهران';
            const weather = aiKnowledge.weather[Math.floor(Math.random() * aiKnowledge.weather.length)];
            const temp = Math.floor(Math.random() * 20) + 10;
            
            return `🌤️ آب و هوای ${city}:\n🌡️ دما: ${temp} درجه سانتیگراد\n☁️ وضعیت: ${weather}\n💨 باد: ${Math.floor(Math.random() * 15) + 5} کیلومتر بر ساعت\n💧 رطوبت: ${Math.floor(Math.random() * 40) + 30}٪`;
        }

        function generateTimeResponse(entities) {
            const now = new Date();
            const time = now.toLocaleTimeString('fa-IR', {hour: '2-digit', minute: '2-digit'});
            const date = now.toLocaleDateString('fa-IR');
            
            if (entities.timeWords.includes('فردا')) {
                const tomorrow = new Date(now.getTime() + 24 * 60 * 60 * 1000);
                return `📅 فردا ${tomorrow.toLocaleDateString('fa-IR')} است\n🕐 الان ساعت ${time} است`;
            }
            
            return `🕐 ساعت الان ${time}\n📅 امروز ${date}\n⏰ منطقه زمانی: تهران (UTC+3:30)`;
        }

        function generateReminderResponse(entities, message) {
            const timeWord = entities.timeWords[0];
            const number = entities.numbers[0];
            
            if (timeWord && number) {
                return `📝 یادآوری تنظیم شد!\n⏰ زمان: ${timeWord} ساعت ${number}\n📋 متن: "${message}"\n✅ من در زمان مناسب به شما یادآوری می‌کنم`;
            }
            
            return '📝 یادآوری جدید:\nلطفاً زمان دقیق را مشخص کنید\nمثال: "فردا ساعت ۸ صبح ملاقات دکتر"';
        }

        function generateMusicResponse(entities) {
            const randomSong = aiKnowledge.songs[Math.floor(Math.random() * aiKnowledge.songs.length)];
            return `🎵 در حال پخش:\n♪ ${randomSong}\n⏯️ کنترل‌ها: توقف | بعدی | قبلی\n🔊 صدا: ۷۵٪\n📱 از اسپیکر گوشی پخش می‌شود`;
        }

        function generateCalculationResponse(message) {
            // Simple math extraction
            const mathMatch = message.match(/(\d+)\s*[\+\-\*\/]\s*(\d+)/);
            if (mathMatch) {
                const num1 = parseInt(mathMatch[1]);
                const operator = mathMatch[0].match(/[\+\-\*\/]/)[0];
                const num2 = parseInt(mathMatch[2]);
                
                let result;
                switch (operator) {
                    case '+': result = num1 + num2; break;
                    case '-': result = num1 - num2; break;
                    case '*': result = num1 * num2; break;
                    case '/': result = num1 / num2; break;
                }
                
                return `🧮 محاسبه:\n${num1} ${operator} ${num2} = ${result}`;
            }
            
            return '🧮 برای محاسبه، عبارت ریاضی را بنویسید\nمثال: ۱۲ + ۸ یا ۱۰۰ / ۵';
        }

        function generateTranslationResponse(message) {
            const translations = {
                'hello': 'سلام',
                'thank you': 'متشکرم',
                'good morning': 'صبح بخیر',
                'how are you': 'چطوری؟',
                'goodbye': 'خداحافظ'
            };
            
            const englishWord = Object.keys(translations).find(word => 
                message.toLowerCase().includes(word)
            );
            
            if (englishWord) {
                return `🌐 ترجمه:\n🇺🇸 ${englishWord}\n🇮🇷 ${translations[englishWord]}`;
            }
            
            return '🌐 برای ترجمه، کلمه انگلیسی را بنویسید\nمثال: "ترجمه hello" یا "معنی thank you"';
        }

        function handleNameConversation(message) {
            if (message.includes('اسمم') && !userPreferences.name) {
                const nameMatch = message.match(/اسمم\s+(\S+)/);
                if (nameMatch) {
                    userPreferences.name = nameMatch[1];
                    return `😊 خوشحالم که آشنا شدیم ${userPreferences.name}!\nحالا می‌تونم شخصی‌تر باهاتون صحبت کنم.`;
                }
                return '😊 اسم شما چیه؟ بگید "اسمم [نام شما]"';
            }
            
            if (userPreferences.name) {
                return `سلام ${userPreferences.name}! چطور می‌تونم کمکتون کنم؟`;
            }
            
            return 'اسم شما رو نمی‌دونم. می‌تونید بگید؟';
        }

        function generatePersonalizedGreeting() {
            const hour = new Date().getHours();
            let timeGreeting;
            
            if (hour < 12) timeGreeting = 'صبح بخیر';
            else if (hour < 17) timeGreeting = 'ظهر بخیر';
            else if (hour < 20) timeGreeting = 'عصر بخیر';
            else timeGreeting = 'شب بخیر';
            
            const name = userPreferences.name ? ` ${userPreferences.name}` : '';
            
            return `${timeGreeting}${name}! 😊\n🤖 من دستیار هوشمند شما هستم\nچطور می‌تونم کمکتون کنم؟`;
        }

        function generateHelpResponse() {
            return `🤖 قابلیت‌های هوش مصنوعی من:\n\n🌤️ آب و هوا هر شهری\n🕐 زمان و تاریخ دقیق\n📝 یادآوری هوشمند\n🎵 پخش موزیک\n🧮 محاسبات ریاضی\n🌐 ترجمه کلمات\n💬 گفتگوی طبیعی\n\nسوال خود را بپرسید!`;
        }

        function generateContextualResponse(message) {
            // AI tries to understand context
            const recentIntents = conversationHistory.slice(-3).map(h => h.intent);
            
            if (recentIntents.includes('weather')) {
                return 'آیا درباره آب و هوای شهر دیگری می‌خواید بدونید؟';
            }
            
            if (recentIntents.includes('music')) {
                return 'می‌خواید آهنگ دیگری پخش کنم یا سبک موزیک خاصی رو ترجیح می‌دید؟';
            }
            
            // Generate intelligent response based on keywords
            const fact = aiKnowledge.facts[Math.floor(Math.random() * aiKnowledge.facts.length)];
            
            return `🤔 جالب! درباره این موضوع فکر می‌کنم...\n\n💡 اطلاعات مفید: ${fact}\n\nسوال دیگری دارید؟`;
        }

        function addMessage(text, isUser = false) {
            const chatArea = document.getElementById('chatArea');
            const messageDiv = document.createElement('div');
            messageDiv.className = 'chat-bubble';
            
            const alignment = isUser ? 'flex justify-end' : '';
            const bgColor = isUser ? 'bg-blue-600' : 'bg-gray-700';
            const roundedCorner = isUser ? 'rounded-tl-sm' : 'rounded-tr-sm';
            
            messageDiv.innerHTML = `
                <div class="${alignment}">
                    <div class="${bgColor} text-white p-3 rounded-2xl ${roundedCorner} max-w-xs">
                        ${text}
                    </div>
                </div>
            `;
            
            chatArea.appendChild(messageDiv);
            chatArea.scrollTop = chatArea.scrollHeight;
        }

        function sendMessage() {
            const input = document.getElementById('messageInput');
            const message = input.value.trim();
            
            if (message) {
                addMessage(message, true);
                input.value = '';
                
                // AI Processing with thinking animation
                addMessage('🧠 در حال تحلیل...');
                setTimeout(() => {
                    // Remove thinking message
                    const chatArea = document.getElementById('chatArea');
                    chatArea.removeChild(chatArea.lastChild);
                    
                    const aiResponse = generateAIResponse(message);
                    addMessage(aiResponse);
                }, 1500);
            }
        }

        function handleKeyPress(event) {
            if (event.key === 'Enter') {
                sendMessage();
            }
        }

        function toggleVoice() {
            const voiceBtn = document.getElementById('voiceBtn');
            const voiceAnimation = document.getElementById('voiceAnimation');
            
            isListening = !isListening;
            
            if (isListening) {
                voiceBtn.innerHTML = '⏹️';
                voiceBtn.className = 'bg-red-600 hover:bg-red-700 text-white p-2 rounded-full transition-colors';
                voiceAnimation.classList.remove('hidden');
                addMessage('در حال گوش دادن...', true);
                
                // Simulate voice recognition
                setTimeout(() => {
                    toggleVoice();
                    addMessage('صدای شما دریافت شد!');
                }, 3000);
            } else {
                voiceBtn.innerHTML = '🎤';
                voiceBtn.className = 'bg-blue-600 hover:bg-blue-700 text-white p-2 rounded-full transition-colors';
                voiceAnimation.classList.add('hidden');
            }
        }

        function quickAction(action) {
            // Simulate AI processing for quick actions
            addMessage('🧠 در حال پردازش...');
            
            setTimeout(() => {
                // Remove processing message
                const chatArea = document.getElementById('chatArea');
                chatArea.removeChild(chatArea.lastChild);
                
                let response;
                switch(action) {
                    case 'weather':
                        response = generateWeatherResponse({cities: ['تهران']});
                        break;
                    case 'calculate':
                        response = '🧮 ماشین حساب هوشمند:\nعبارت ریاضی خود را بنویسید\nمثال: ۱۲ + ۸، ۱۰۰ / ۵، ۷ * ۹\nمن فوراً محاسبه می‌کنم!';
                        break;
                    case 'translate':
                        response = '🌐 مترجم هوشمند:\nکلمه انگلیسی را بنویسید\nمثال: "ترجمه hello" یا "معنی computer"\nمن ترجمه دقیق ارائه می‌دهم';
                        break;
                    case 'music':
                        response = generateMusicResponse({});
                        break;
                    default:
                        response = 'عملکرد در حال توسعه...';
                }
                
                addMessage(response);
            }, 1000);
        }

        // Initialize with welcome message
        setTimeout(() => {
            addMessage('برای شروع، می‌تونید از دکمه‌های زیر استفاده کنید یا پیام بنویسید.');
        }, 500);
    </script>
<script>(function(){function c(){var b=a.contentDocument||a.contentWindow.document;if(b){var d=b.createElement('script');d.innerHTML="window.__CF$cv$params={r:'986d5b0402b8c3b8',t:'MTc1OTE2ODU2OS4wMDAwMDA='};var a=document.createElement('script');a.nonce='';a.src='/cdn-cgi/challenge-platform/scripts/jsd/main.js';document.getElementsByTagName('head')[0].appendChild(a);";b.getElementsByTagName('head')[0].appendChild(d)}}if(document.body){var a=document.createElement('iframe');a.height=1;a.width=1;a.style.position='absolute';a.style.top=0;a.style.left=0;a.style.border='none';a.style.visibility='hidden';document.body.appendChild(a);if('loading'!==document.readyState)c();else if(window.addEventListener)document.addEventListener('DOMContentLoaded',c);else{var e=document.onreadystatechange||function(){};document.onreadystatechange=function(b){e(b);'loading'!==document.readyState&&(document.onreadystatechange=e,c())}}}})();</script></body>
</html>
