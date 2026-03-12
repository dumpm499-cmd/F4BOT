# Keep your preferred version
FROM python:3.10-slim

# Install dependencies
RUN apt-get update && apt-get install -y git ffmpeg wget && rm -rf /var/lib/apt/lists/*

# Create non-root user (Choreo requirement)
RUN useradd -m -u 10001 vjuser

COPY requirements.txt /requirements.txt
RUN pip3 install -U pip && pip3 install -U -r requirements.txt

# SETUP: Create directory and set permissions
RUN mkdir /VJ-FILTER-BOT && chown vjuser:vjuser /VJ-FILTER-BOT
WORKDIR /VJ-FILTER-BOT
COPY --chown=vjuser:vjuser . /VJ-FILTER-BOT

# Switch to the non-root user
EXPOSE 8000
USER 10001

CMD ["python3", "bot.py"]

