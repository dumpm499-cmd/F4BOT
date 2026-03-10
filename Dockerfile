# Don't Remove Credit @VJ_Bots
# Subscribe YouTube Channel For Amazing Bot @Tech_VJ
# Ask Doubt on telegram @KingVJ01

FROM python:3.10.8-slim-buster

RUN apt update && apt upgrade -y
RUN apt install git -y

# --- ADD ONLY THIS SECTION ---
# This stops the Choreo "CKV_DOCKER_3" error
RUN useradd -m -u 10001 vjuser
# -----------------------------

COPY requirements.txt /requirements.txt
RUN pip3 install -U pip && pip3 install -U -r requirements.txt

RUN mkdir /VJ-FILTER-BOT
WORKDIR /VJ-FILTER-BOT
COPY . /VJ-FILTER-BOT

# --- AND THIS LINE AT THE END ---
USER 10001
# -----------------------------

CMD ["python3", "bot.py"]

