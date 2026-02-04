# ใช้ Jenkins image อย่างเป็นทางการ
FROM jenkins/jenkins:lts

# สลับเป็น root เพื่อ install package
USER root

# ติดตั้ง dependency ที่จำเป็น
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    wget \
    gnupg \
    curl \
    fonts-liberation \
    libasound2 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libc6 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libgbm1 \
    libgcc1 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libstdc++6 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    xdg-utils \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# ติดตั้ง Google Chrome (ไม่ใช้ apt-key)
RUN wget -q -O /usr/share/keyrings/google-linux-signing-keyring.gpg \
        https://dl.google.com/linux/linux_signing_key.pub \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-linux-signing-keyring.gpg] \
        http://dl.google.com/linux/chrome/deb/ stable main" \
        > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

# ติดตั้ง Robot Framework + SeleniumLibrary
RUN pip3 install --no-cache-dir --break-system-packages \
    robotframework \
    robotframework-seleniumlibrary \
    selenium

# กลับไปใช้ user jenkins
USER jenkins
