# Keep your preferred version
FROM python:3.10.8-slim-buster

# FIX: Point apt to the archive servers because Buster is EOL
RUN sed -i s/deb.debian.org/archive.debian.org/g /etc/apt/sources.list && \
    sed -i s/security.debian.org/archive.debian.org/g /etc/apt/sources.list && \
    sed -i '/stretch-updates/d' /etc/apt/sources.list

# Now apt update will work
RUN apt update && apt upgrade -y
RUN apt install git ffmpeg wget -y

# SECURITY FIX: Create the non-root user Choreo requires
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

