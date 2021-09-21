FROM python:3.8-slim-buster

ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install dependencies:
COPY requirements.txt .

RUN apk --update --no-cache add \
    gcc build-base freetype-dev libpng-dev openblas-dev g++ musl-dev && \
    ln -s /usr/include/locale.h /usr/include/xlocale.h
RUN pip install -r requirements.txt


ENV clientId={$clientId}
ENV studyId={$studyId}
ENV nEXP={$nEXP}


# Run the application:

COPY . .
CMD ["mlflow run examples/docker -P alpha=0.5"]
